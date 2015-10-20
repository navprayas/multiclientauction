package com.navprayas.bidding.common.service;

import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.auctioncache.AuctionCacheBean;
import com.navprayas.bidding.auctioncache.AuctionCacheManager;
import com.navprayas.bidding.common.dao.ICommonDao;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.common.form.Category;
import com.navprayas.bidding.engine.redis.RedisConstants;
import com.navprayas.bidding.utility.BidItemScheduler;
import com.navprayas.bidding.utility.ObjectRegistry;
import com.navprayas.bidding.utility.RedisCacheService;

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
			RedisCacheService.setBidSequenceList(bidSequenceList, clientId);
			if (bidSequenceList != null && bidSequenceList.size() > 0) {
				List<Category> categories = commonDao.getCategoryList(clientId);

				RedisCacheService.setCategories(categories, clientId);
				RedisCacheService
						.setBidIdKey(commonDao.getMaxBidId(), clientId);
				RedisCacheService.setAutoBidIdKey(commonDao.getMaxAutoBidId(),
						clientId);

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
		logger.debug("calling next biditem============= " + UUID.randomUUID());
		String endSequence = RedisCacheService.isEndSequence(clientId);
		if (endSequence != null && endSequence.equals("TRUE")) {
			logger.debug("In End of Sequence");
			commonDao.setAuctionEndTime(clientAuctionMap.get(clientId),
					new Date());
			cleanBidItem(RedisCacheService.getActiveBidItemId(clientId),
					Long.parseLong(RedisCacheService.getAuctionId(clientId)),
					clientId);
			 scheduler.stop();
			return 0L;
		} else if (auctionStartFlags.get(clientId)) {
			logger.debug("calling next biditem============= Start sequnce");
			auctionStartFlags.put(clientId, false);
			logger.debug("In Start of Sequence");
			RedisCacheService.setActiveBidItemId(clientId);
			BidItem bidItem = getBidItem(
					RedisCacheService.getActiveBidItemId(clientId),
					clientAuctionMap.get(clientId), clientId);
			logger.debug("BidItem from Redis : start cache" + bidItem);
			return bidItem.getBidSpan();
		} else {
			logger.debug("calling next biditem============= Next sequnce else part");
			logger.debug("In Next of Sequence");
			long activeBidItemId = RedisCacheService
					.getActiveBidItemId(clientId);

			BidItem bidItem = RedisCacheService.getBidItem(
					RedisConstants.BIDITEM + clientAuctionMap.get(clientId)
							+ activeBidItemId + clientId,
					String.valueOf(activeBidItemId), clientId);
			logger.debug("BidItem from Redis : " + bidItem);
			if (bidItem == null)
				return 0;

			if (bidItem.getTimeLeft() > 0) {
				logger.debug("Extended Time: " + bidItem.getTimeLeft());
				return bidItem.getTimeLeft();
			} else {
				RedisCacheService.setActiveBidItemId(clientId);
				cleanBidItem(activeBidItemId, Long.parseLong(RedisCacheService
						.getAuctionId(clientId)), clientId);
				bidItem = getBidItem(
						RedisCacheService.getActiveBidItemId(clientId),
						clientAuctionMap.get(clientId), clientId);
				System.out.println(" Next Bid Item Abcd   " + bidItem);

				if (bidItem == null)
					return 0;
				System.out.println("Bid span time in next bid sequence"
						+ bidItem.getBidSpan());

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
		Map<String, String> bidItemDetails = RedisCacheService
				.getBidItemSequenceDetails(bidItem.getBidItemId(), clientId);
		System.out.println(bidItemDetails);
		long bidSpan = Long.parseLong((String) bidItemDetails
				.get(RedisConstants.ATTR_BIDSPAN));
		long seqId = Long.parseLong((String) bidItemDetails
				.get(RedisConstants.ATTR_SEQUENCEID));
		cal.add(Calendar.SECOND, (int) bidSpan);
		bidItem.setBidEndTime(cal.getTime());
		bidItem.setStatusCode("ACTIVE");
		bidItem.setBidSpan(bidSpan);
		bidItem.setSeqId(seqId);
	}

	public void setBidItem(BidItem bidItem, Long clientId) {
		/*
		 * RedisCacheService.setBidItem( RedisConstants.BIDITEM +
		 * bidItem.getAuctionId() + bidItem.getBidItemId() + clientId, bidItem,
		 * clientId);
		 */

		System.out.println("gettting time left " + bidItem.getTimeLeft());
		AuctionCacheBean auctionCacheBean = AuctionCacheManager
				.getActiveAuctionCacheBean(clientId);

		auctionCacheBean.getBidItemsCurrentMap().put(bidItem.getBidItemId(),
				bidItem);
		//auctionCacheBean.setBidItem(bidItem);
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
		/*
		 * BidItem bidItem = RedisCacheService.getBidItem(RedisConstants.BIDITEM
		 * + auctionId + bidItemId + clientId, String.valueOf(bidItemId),
		 * clientId);
		 */
		 AuctionCacheBean auctionCacheBean = AuctionCacheManager
		.getActiveAuctionCacheBean(clientId);
		
		BidItem bidItem = auctionCacheBean.getBidItemsCurrentMap().get(bidItemId);
		if (bidItem == null && bidItemId != 0) {
			bidItem = commonDao.getBidItem(bidItemId);
			initializeBidItem(bidItem, clientId);
			setBidItem(bidItem, clientId); // Save to cache
		}
		return bidItem;
	}

	private void cleanBidItem(long bidItemId, Long auctionId, Long clientId) {
		RedisCacheService.setExpiredBidItem(bidItemId, clientId);
		commonDao.updateBidItem(RedisCacheService.getBidItem(
				RedisConstants.BIDITEM + auctionId + bidItemId + clientId,
				bidItemId + "", clientId));
	}

	public boolean setBidEndTime(long bidItemId, Date bidEndTime,
			Long auctionId, Long clientId) {
		return RedisCacheService.setBidEndTime(bidItemId, bidEndTime,
				RedisConstants.BIDITEM + auctionId + bidItemId + clientId,
				clientId);
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
