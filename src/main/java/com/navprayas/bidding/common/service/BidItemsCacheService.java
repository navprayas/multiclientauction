package com.navprayas.bidding.common.service;

import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.auctioncache.AuctionCacheManager;
import com.navprayas.bidding.auctioncache.AuctionQueueUtility;
import com.navprayas.bidding.common.dao.ICommonDao;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.common.form.Category;
import com.navprayas.bidding.utility.BidItemScheduler;
import com.navprayas.bidding.utility.ObjectRegistry;

@Service("bidItemsCacheService")
public class BidItemsCacheService implements IBidItemsCacheService {

	@Autowired
	@Qualifier("commonRepository")
	private ICommonDao commonDao;

	private volatile boolean mapUpdated = false;

	private final static Logger logger = LoggerFactory
			.getLogger(BidItemsCacheService.class);

	private final Map<Long, BidItem> bidItemsMap = Collections
			.synchronizedMap(new HashMap<Long, BidItem>());

	BidItemScheduler scheduler = null;

	// public Date auctionStartTime;
	// public long auctionId;
	// covert to multiple auctionId's with respective to Client Ids
	public Map<Long, Long> clientAuctionMap = new ConcurrentHashMap<Long, Long>();
	public Map<Long, Date> auctionStartTimeMap = new ConcurrentHashMap<Long, Date>();

	/* boolean startFlag = true; */
	public Map<Long, Boolean> auctionStartFlags = new ConcurrentHashMap<Long, Boolean>();

	@PostConstruct
	public void init() {
		// initCache();
		ObjectRegistry.getInstance().putObject(
				BidItemsCacheService.class.getName(), this);
	}

	@Transactional
	public void initCache(Long clientId) {
		logger.debug("Initializing cache " + new Date());
		auctionStartFlags.put(clientId, true);
		Date startTime = null;
		if (auctionStartTimeMap.get(clientId) != null) {
			startTime = auctionStartTimeMap.get(clientId);
		} else {
			// startTime = commonDao.getActualAuctionStartTime(auctionId);
			startTime = commonDao.getActualAuctionStartTime(clientAuctionMap
					.get(clientId));
			auctionStartTimeMap.put(clientId, startTime);

		}

		List<BidSequence> bidSequenceList = commonDao
				.getCurrentBidSequence(clientAuctionMap.get(clientId));
		logger.debug("bidSequenceList " + bidSequenceList);
		try {
			// RedisCacheService.flushDB();
			// RedisCacheService.setBidSequenceList(bidSequenceList, clientId);
			AuctionQueueUtility.setBidSequenceQueue(
					AuctionCacheManager.getActiveAuctionCacheBean(clientId),
					bidSequenceList);
			if (bidSequenceList != null && bidSequenceList.size() > 0) {
				List<Category> categories = commonDao.getCategoryList(clientId);

				// RedisCacheService.setCategories(categories, clientId);
				AuctionCacheManager.setCategories(categories);
				/*
				 * RedisCacheService.setBidIdKey(commonDao.getMaxBidId(),
				 * clientId);
				 * RedisCacheService.setAutoBidIdKey(commonDao.getMaxAutoBidId
				 * (), clientId);
				 */

				AuctionCacheManager.setBidIdKey(clientId,
						commonDao.getMaxBidId());
				AuctionCacheManager.setAutoBidIdKey(clientId,
						commonDao.getMaxAutoBidId());

				scheduler = new BidItemScheduler();
				scheduler.setCacheService(this);
				scheduler.start(startTime, clientId);
			}
		} catch (Exception e) {
			logger.error("Cache service failed " + e.getMessage());
			e.printStackTrace();
		}
	}

	public long setNextBidItem(Long clientId) {
		// String endSequence = RedisCacheService.isEndSequence(clientId);
		String endSequence = AuctionQueueUtility.isEndSequence(clientId);
		if (endSequence != null && endSequence.equals("TRUE")) {
			logger.debug("In End of Sequence");
			commonDao.setAuctionEndTime(clientAuctionMap.get(clientId),
					new Date());
			cleanBidItem(AuctionCacheManager.getActiveBidItemId(clientId),
					AuctionCacheManager.getActiveAuctionId(clientId), clientId);
			// scheduler.stop();
			return 0L;
		} else if (auctionStartFlags.get(clientId)) {
			auctionStartFlags.put(clientId, false);
			logger.debug("In Start of Sequence");
			/* RedisCacheService.setActiveBidItemId(clientId); */
			AuctionCacheManager.setActiveBidItemId(clientId,
					AuctionQueueUtility.pollActiveBidItemId(clientId));
			BidItem bidItem = getBidItem(
					AuctionCacheManager.getActiveBidItemId(clientId),
					clientAuctionMap.get(clientId), clientId);
			logger.debug("BidItem from Redis : " + bidItem);
			return bidItem.getBidSpan();
		} else {
			logger.debug("In Next of Sequence");
			long activeBidItemId = AuctionCacheManager
					.getActiveBidItemId(clientId);
			/*
			 * BidItem bidItem =
			 * AuctionCacheManager.getBidItem(RedisConstants.BIDITEM +
			 * clientAuctionMap.get(clientId) + activeBidItemId + clientId,
			 * String.valueOf(activeBidItemId), clientId);
			 */
			BidItem bidItem = AuctionCacheManager.getActiveBidItem(clientId);
			logger.debug("BidItem from Redis : " + bidItem);
			if (bidItem == null)
				return 0;

			if (bidItem.getTimeLeft() > 0) {
				logger.debug("Extended Time: " + bidItem.getTimeLeft());
				return bidItem.getTimeLeft();
			} else {
				// AuctionCacheManager.setActiveBidItemId(clientId);
				AuctionCacheManager.setActiveBidItemId(clientId,
						activeBidItemId);
				cleanBidItem(activeBidItemId,
						AuctionCacheManager.getActiveAuctionId(clientId),
						clientId);
				bidItem = getBidItem(
						AuctionCacheManager.getActiveBidItemId(clientId),
						clientAuctionMap.get(clientId), clientId);
				if (bidItem == null)
					return 0;
				return bidItem.getBidSpan();
			}
		}
	}

	public void initializeBidItem(BidItem bidItem, Long clientId) {
		Calendar cal = Calendar.getInstance();
		bidItem.setLastUpDateTime(cal.getTime());
		bidItem.setBidStartTime(cal.getTime());
		// long bidSpan =
		// RedisCacheService.getBidItemSpan(bidItem.getBidItemId());
		BidItem activeBidItem = AuctionCacheManager.getActiveBidItem(clientId);

		long bidSpan = activeBidItem.getBidSpan();
		long seqId = activeBidItem.getSeqId();
		cal.add(Calendar.SECOND, (int) bidSpan);
		bidItem.setBidEndTime(cal.getTime());
		bidItem.setStatusCode("ACTIVE");
		bidItem.setBidSpan(bidSpan);
		bidItem.setSeqId(seqId);
	}

	public void setBidItem(BidItem bidItem, Long clientId) {
		AuctionCacheManager
				.setActiveBidItemId(clientId, bidItem.getBidItemId());
		/*
		 * RedisCacheService.setBidItem( RedisConstants.BIDITEM +
		 * bidItem.getAuctionId() + bidItem.getBidItemId() + clientId, bidItem,
		 * clientId);
		 */
		logger.debug("DAO Set BidItem : " + bidItem);
		/*
		 * logger.debug("REDIS Set BidItem : " + RedisCacheService.getBidItem(
		 * RedisConstants.BIDITEM + bidItem.getAuctionId() +
		 * bidItem.getBidItemId() + clientId,
		 * String.valueOf(bidItem.getBidItemId()), clientId));
		 */
	}

	@Transactional
	public BidItem getBidItem(Long bidItemId, Long auctionId, Long clientId) {
		BidItem bidItem = AuctionCacheManager.getActiveBidItem(clientId);
		if (bidItem == null && bidItemId != 0) {
			bidItem = commonDao.getBidItem(bidItemId);
			initializeBidItem(bidItem, clientId);
			setBidItem(bidItem, clientId); // Save to cache
		}
		return bidItem;
	}

	private void cleanBidItem(long bidItemId, Long auctionId, Long clientId) {
		// RedisCacheService.setExpiredBidItem(bidItemId, clientId);
		/*
		 * commonDao.updateBidItem(RedisCacheService.getBidItem(RedisConstants.
		 * BIDITEM + auctionId + bidItemId + clientId, bidItemId + "",
		 * clientId));
		 */

		AuctionCacheManager.setExpiredBidItem(clientId,
				AuctionCacheManager.getActiveBidItem(clientId));

		commonDao.updateBidItem(AuctionCacheManager.getActiveBidItem(clientId));

	}

	public boolean setBidEndTime(long bidItemId, Date bidEndTime,
			Long auctionId, Long clientId) {
		/*
		 * return RedisCacheService.setBidEndTime(bidItemId, bidEndTime,
		 * RedisConstants.BIDITEM + auctionId + bidItemId + clientId, clientId);
		 */
		return true;

	}

	/**
	 * @return the bidItemsMap
	 */
	public Map<Long, BidItem> getBidItemsMap() {
		return bidItemsMap;
	}

	@Transactional
	public void flushCache() {
		logger.debug("Flushing cache " + new Date());
		if (mapUpdated)
			commonDao.flushAllActiveBidItems(bidItemsMap.values());
		mapUpdated = false;
	}

	public Date getAuctionStartTime(Long clientId) {
		return auctionStartTimeMap.get(clientId);
	}

	public Long getAuctionId(Long clientId) {

		return clientAuctionMap.get(clientId);
	}

}
