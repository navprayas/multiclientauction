package com.navprayas.bidding.auctioncache;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;

import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.Category;

@Component
public class AuctionCacheManager implements InitializingBean {

	private static Map<Long, AuctionCacheBean> activeAuctionMap = new HashMap<Long, AuctionCacheBean>();
	private static List<Category> categoryList = new ArrayList<Category>();
	private static Map<Long, Long> maxBidMap = new HashMap<Long, Long>();
	private static Map<Long, Long> maxAutoBidMap = new HashMap<Long, Long>();

	@Override
	public void afterPropertiesSet() throws Exception {
		// System.out.println("Properties Loaded");
		// setActiveAuction();
		// System.out.println("active Auction id::");
		// bidItemsCacheService.initCache();
		// System.out.println("Active Auction Map" + activeAuctionMap);

	}

	public static void setActiveAuctionId(AuctionCacheBean auctionCacheBean) {
		if (activeAuctionMap.get(auctionCacheBean.getClientId()) == null) {
			activeAuctionMap.put(auctionCacheBean.getClientId(),
					auctionCacheBean);

		}

	}

	public static Long getActiveAuctionId(Long clientId) {
		if (activeAuctionMap.get(clientId) != null) {
			return activeAuctionMap.get(clientId).getAuctionId();
		}
		return null;
	}

	public static void setActiveBidItem(Long clientId, BidItem bidItem) {
		System.out.println("Setting Active Bid Item " + bidItem);
		initializeBidItem(bidItem, clientId);
		activeAuctionMap.get(clientId).getBidItemsMap().put(clientId, bidItem);
	}

	public static BidItem getActiveBidItem(Long clientId) {
		if (activeAuctionMap.get(clientId) != null) {
			Long bidItemId = activeAuctionMap.get(clientId)
					.getActiveBidItemId();
			if (bidItemId != null) {

				BidItem bidItem = activeAuctionMap.get(clientId)
						.getBidItemsMap().get(bidItemId);

				return bidItem;
			}
		}
		return null;
	}

	public static void setActiveBidItemId(Long clientId, Long activeBidItemId) {
		activeAuctionMap.get(clientId).setActiveBidItemId(activeBidItemId);
	}

	public static void setAuctionClosed(Long clientId) {
		activeAuctionMap.get(clientId).setAuctionClosed(true);
	}

	public static boolean isAuctionClosed(Long clientId) {
		if (activeAuctionMap.get(clientId) != null) {
			return activeAuctionMap.get(clientId).isAuctionClosed();
		}
		return false;
	}

	public static Long getActiveBidItemId(Long clientId) {
		return activeAuctionMap.get(clientId).getActiveBidItemId();
	}

	public static AuctionCacheBean getActiveAuctionCacheBean(Long clientId) {
		return activeAuctionMap.get(clientId);
	}

	public static Long getActiveBidSequenceId(Long clientId) {
		BidItem bidItem = getActiveBidItem(clientId);
		return bidItem != null ? bidItem.getSeqId() : null;

	}

	public static List<BidItem> getBidItems(Long clientId) {
		if (activeAuctionMap.get(clientId) != null) {
			return activeAuctionMap.get(clientId).getBidItems();
		}
		return null;
	}

	public static void setCategories(List<Category> list) {
		if (categoryList == null) {
			categoryList.addAll(list);
		}
	}

	public static List<Category> getCategories() {

		return categoryList;

	}

	public static void setBidIdKey(Long clientId, Long maxBidId) {
		if (maxBidMap.get(clientId) == null) {
			maxBidMap.put(clientId, maxBidId);
		}
	}

	public static void setAutoBidIdKey(Long clientId, Long maxAutoBidId) {
		if (maxAutoBidMap.get(clientId) == null) {
			maxAutoBidMap.put(clientId, maxAutoBidId);
		}

	}

	/*
	 * public static BidItem getBidItemDetails(Long activeBidItemId, Long
	 * clientId) {
	 * System.out.println(AuctionCacheManager.getActiveAuctionCacheBean(
	 * clientId).getBidItemsMap()); return
	 * AuctionCacheManager.getActiveAuctionCacheBean(clientId)
	 * .getBidItemsMap().get(activeBidItemId);
	 * 
	 * }
	 */

	public static void initializeBidItem(BidItem bidItem, Long clientId) {
		Calendar cal = Calendar.getInstance();
		bidItem.setLastUpDateTime(cal.getTime());
		bidItem.setBidStartTime(cal.getTime());
		// long bidSpan =
		// RedisCacheService.getBidItemSpan(bidItem.getBidItemId());
		BidItem activeBidItem = AuctionCacheManager.getActiveBidItem(clientId);

		long bidSpan = bidItem.getBidSpan();
		long seqId = bidItem.getSeqId();
		cal.add(Calendar.SECOND, (int) bidSpan);
		bidItem.setBidEndTime(cal.getTime());
		bidItem.setStatusCode("ACTIVE");
		bidItem.setBidSpan(bidSpan);
		bidItem.setSeqId(seqId);
	}

	public static void setExpiredBidItem(Long clientId, BidItem bidItem) {
		bidItem.setStatus("CLOSED");
		bidItem.setBidEndTime(new Date());
		AuctionCacheBean auctionCacheManager = AuctionCacheManager
				.getActiveAuctionCacheBean(clientId);
		auctionCacheManager.getExpiredBidItems().put(bidItem.getBidItemId(),
				bidItem);
	}

}
