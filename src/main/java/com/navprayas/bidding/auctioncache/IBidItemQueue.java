package com.navprayas.bidding.auctioncache;

import java.util.concurrent.BlockingDeque;

import com.navprayas.bidding.engine.orm.Bid;

/**
 * Interface to govern all BidItemQueue required methods.
 * @author cfeindia
 *
 */
public interface IBidItemQueue {

	/**
	 * Initialize the bid item queue and put it in the map.
	 * @param auctionId auctionId
	 * @param forceReinitialize pass true if you want to clean the queue corresponding to the auction id
	 *                          already existing.
	 */
	public void initializeBidItemQueue(final Long auctionId, final boolean forceReinitialize);
	
	/**
	 * returns the Bid item queue corresponding to the auction id.
	 * @param auctionId auction id
	 * @return already initialized queue for auction id
	 */
	public BlockingDeque<Bid> getBidItemQueue(final Long auctionId);
}
