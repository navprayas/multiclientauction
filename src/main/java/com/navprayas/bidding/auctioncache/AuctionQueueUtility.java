package com.navprayas.bidding.auctioncache;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import org.springframework.stereotype.Component;

import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;

@Component
public class AuctionQueueUtility {
	private static Map<Long, Queue<Long>> bidSequenceQueueMap = new HashMap<Long, Queue<Long>>();

	public static void setBidSequenceQueue(AuctionCacheBean auctionCacheBean,
			List<BidSequence> bidSequenceList) {
		System.out.println("bidSequenceList :-" + bidSequenceList);
		Map<Long, BidItem> bidItemMap = new HashMap<Long, BidItem>();
		Queue<Long> bidSequenceQueue = new LinkedList<Long>();
		if (bidSequenceList != null && !bidSequenceList.isEmpty()) {

			for (BidSequence bidSequence : bidSequenceList) {
				System.out.println("Bid sequence loop");
				if (bidSequence != null
						&& bidSequence.getBidItem().getBidItemId() != null
						&& bidSequence.getBidItem().getBidItemId() != null) {
					bidSequenceQueue.add(bidSequence.getBidItem()
							.getBidItemId());
					BidItem bidItem = bidSequence.getBidItem();
					bidItem.setSeqId(bidSequence.getSequenceId());
					bidItem.setBidSpan(bidSequence.getBidspan());
					bidItemMap.put(bidSequence.getBidItem().getBidItemId(),
							bidSequence.getBidItem());
					bidSequenceQueueMap.put(auctionCacheBean.getClientId(),
							bidSequenceQueue);
				}
			}
			auctionCacheBean.setBidItemsMap(bidItemMap);

		}
		System.out.println("Setting biditem span and sequence id to bid item " + bidItemMap);
		System.out.println("bidSequenceQueue" + bidSequenceQueue);
	}

	public static Long pollActiveBidItemId(Long clientId) {
		Queue<Long> bidSequenceQueue = bidSequenceQueueMap.get(clientId);
		if (bidSequenceQueue != null) {
			Long activeBidItemId = bidSequenceQueue.poll();
			System.out.println(activeBidItemId);
			return activeBidItemId;
		}
		return null;
	}

	public static String isEndSequence(Long clientId) {
		Long endSequence = null;
		try {
			endSequence = AuctionCacheManager.getActiveBidItemId(clientId);
			if (endSequence == null)
				return null;
			if (endSequence.equals("0"))
				return "TRUE";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "FALSE";
	}

	public static Map<Long, BidItem> getSequentialDetail(Long clientId) {
		AuctionCacheBean auctionCacheBean = AuctionCacheManager
				.getActiveAuctionCacheBean(clientId);

		return auctionCacheBean.getBidItemsMap();
	}

}
