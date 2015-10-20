package com.navprayas.bidding.auctioncache;

import java.util.HashMap;
import java.util.Map;
import java.util.Observable;

import com.navprayas.bidding.engine.orm.Bid;
import com.navprayas.bidding.utility.BidObserver;

public class BidPublisher extends Observable {
	private static BidPublisher _instance;
	private static Map<Long, Bid> bids = new HashMap<Long, Bid>();

	public static synchronized BidPublisher getInstance() {
		if (_instance == null) {
			_instance = new BidPublisher();
		}
		return _instance;
	}

	public Map<Long, Bid> getBids() {
		return bids;
	}

	public void notifyBid(Bid bid) {
		bids.put(Long.valueOf(bid.getBidId()), bid);
		setChanged();
		/* notifyObservers(); */
		BidObserver.getInstance().update(_instance, bid.getBidId());
	}
}
