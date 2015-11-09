package com.navprayas.bidding.auction.dao;

import com.navprayas.bidding.auction.entity.AuctionEntity;
import com.navprayas.bidding.common.form.Auction;

public interface AuctionDao {
	public void save(AuctionEntity ob);

	public Auction getAuction(Long auctionId);

}
