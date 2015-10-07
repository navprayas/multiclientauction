package com.navprayas.bidding.utility;

public class BidderFactory {
	public static Bidder create() {
		return new BidderImpl(AuctioneerFactory.create().getMailBox());
	}
}
