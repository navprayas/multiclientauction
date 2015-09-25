package com.navprayas.bidding.common.service;

import java.util.Map;
import java.util.Date;

import com.navprayas.bidding.common.form.BidItem;

public interface IBidItemsCacheService {
	public BidItem getBidItem(Long bidItemId, Long auctionId, Long clientId);

	public void setBidItem(BidItem bidItem, Long clientId);

	public Map<Long, BidItem> getBidItemsMap();

	public void flushCache();

	public Date getAuctionStartTime(Long clientId);

	public long getAuctionId(Long clientId);
}
