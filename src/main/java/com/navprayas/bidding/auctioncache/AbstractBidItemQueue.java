package com.navprayas.bidding.auctioncache;

import java.util.Map;
import java.util.concurrent.BlockingDeque;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.LinkedBlockingDeque;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.navprayas.bidding.engine.orm.Bid;

public class AbstractBidItemQueue implements IBidItemQueue {

	private final static Logger LOG = LoggerFactory.getLogger(AbstractBidItemQueue.class);
	private Map<Long, BlockingDeque<Bid>> auctionBidItemQueueMap = 
			new ConcurrentHashMap<Long, BlockingDeque<Bid>>();
	@Override
	public void initializeBidItemQueue(final Long auctionId, final boolean forceReinitialize) {
		if (forceReinitialize) {
			BlockingDeque<Bid> bidItemQueue = new LinkedBlockingDeque<Bid>(1000);
			auctionBidItemQueueMap.put(auctionId, bidItemQueue);
		} else {
			if (auctionBidItemQueueMap.get(auctionId) == null) {
				BlockingDeque<Bid> bidItemQueue = new LinkedBlockingDeque<Bid>(1000);
				auctionBidItemQueueMap.put(auctionId, bidItemQueue);
			} else {
				LOG.warn("Queue for auction Id already existing.");
			}
		}
	}
	
	@Override
	public BlockingDeque<Bid> getBidItemQueue(final Long auctionId) {
		return auctionBidItemQueueMap.get(auctionId);
	}

}
