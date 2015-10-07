package com.navprayas.bidding.auctioncache;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.navprayas.bidding.common.form.BidItem;
@Component
public class AuctionCacheBean {

	private Long auctionId;
	private Long clientId;
	private Date auctionStartTime;
	private Long activeBidItemId;
	private boolean isAuctionClosed = false;
	private Map<Long,BidItem> expiredBidItems;
	

	private List<BidItem> bidItems;

	private Map<Long, BidItem> bidItemsMap;

	public Long getAuctionId() {
		return auctionId;
	}

	public void setAuctionId(Long auctionId) {
		this.auctionId = auctionId;
	}

	public Long getClientId() {
		return clientId;
	}

	public void setClientId(Long clientId) {
		this.clientId = clientId;
	}

	public List<BidItem> getBidItems() {
		return bidItems;
	}

	public void setBidItems(List<BidItem> bidItems) {
		this.bidItems = bidItems;
	}

	public Map<Long, BidItem> getBidItemsMap() {
		return bidItemsMap;
	}

	public void setBidItemsMap(Map<Long, BidItem> bidItemsMap) {
		this.bidItemsMap = bidItemsMap;
	}

	public Date getAuctionStartTime() {
		return auctionStartTime;
	}

	public void setAuctionStartTime(Date auctionStartTime) {
		this.auctionStartTime = auctionStartTime;
	}

	public Long getActiveBidItemId() {
		return activeBidItemId;
	}

	public void setActiveBidItemId(Long activeBidItemId) {
		this.activeBidItemId = activeBidItemId;
	}

	public boolean isAuctionClosed() {
		return isAuctionClosed;
	}

	public void setAuctionClosed(boolean isAuctionClosed) {
		this.isAuctionClosed = isAuctionClosed;
	}

	public Map<Long, BidItem> getExpiredBidItems() {
		return expiredBidItems;
	}

	public void setExpiredBidItems(Map<Long, BidItem> expiredBidItems) {
		this.expiredBidItems = expiredBidItems;
	}

	
}
