package com.navprayas.bidding.utility;

import com.navprayas.bidding.engine.orm.Bid;

public abstract interface Bidder {
	public abstract void call(Bid paramBid);

}
