package com.navprayas.bidding.auctioncache;

import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import com.navprayas.bidding.common.bean.Bidder;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.common.form.Category;

public class AuctionCacheBean {

	private Long auctionId;
	private Long clientId;
	private Date auctionStartTime;
	private Long activeBidItemId;
	private boolean isAuctionClosed = false;
	private Map<Long, BidItem> expiredBidItems;
	private Map<Long, List<Bidder>> bidderMap;
	private List<BidItem> bidItems;
	private Map<String, Bidder> bidderIdMap;

	private Map<Long, BidItem> bidItemsMap;
	private Map<Long, Category> categoryMap;
	private Map<Long, Long> categoryBidItemMap;
	private Map<Long, BidSequence> bidItemIdbidSequence;
    private BidItem bidItem;
    private Queue<Map<Long,Long>> sequenceIdBidItemIdQueue;
    
    private Map<Long, BidItem> bidItemsCurrentMap = Collections
			.synchronizedMap(new HashMap<Long, BidItem>());
    
    
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

	public Map<Long, List<Bidder>> getBidderMap() {
		return bidderMap;
	}

	public void setBidderMap(Map<Long, List<Bidder>> bidderMap) {
		this.bidderMap = bidderMap;
	}

	public Map<Long, Category> getCategoryMap() {
		return categoryMap;
	}

	public void setCategoryMap(Map<Long, Category> categoryMap) {
		this.categoryMap = categoryMap;
	}

	public Map<String, Bidder> getBidderIdMap() {
		return bidderIdMap;
	}

	public void setBidderIdMap(Map<String, Bidder> bidderIdMap) {
		this.bidderIdMap = bidderIdMap;
	}

	public Map<Long, Long> getCategoryBidItemMap() {
		return categoryBidItemMap;
	}

	public void setCategoryBidItemMap(Map<Long, Long> categoryBidItemMap) {
		this.categoryBidItemMap = categoryBidItemMap;
	}

	

	public Map<Long, BidSequence> getBidItemIdbidSequence() {
		return bidItemIdbidSequence;
	}

	public void setBidItemIdbidSequence(
			Map<Long, BidSequence> bidItemIdbidSequence) {
		this.bidItemIdbidSequence = bidItemIdbidSequence;
	}

	public BidItem getBidItem() {
		return bidItem;
	}

	public void setBidItem(BidItem bidItem) {
		this.bidItem = bidItem;
	}

	public Queue<Map<Long, Long>> getSequenceIdBidItemIdQueue() {
		return sequenceIdBidItemIdQueue;
	}

	public void setSequenceIdBidItemIdQueue(
			Queue<Map<Long, Long>> sequenceIdBidItemIdQueue) {
		this.sequenceIdBidItemIdQueue = sequenceIdBidItemIdQueue;
	}

	public Map<Long, BidItem> getBidItemsCurrentMap() {
		return bidItemsCurrentMap;
	}

	public void setBidItemsCurrentMap(Map<Long, BidItem> bidItemsCurrentMap) {
		this.bidItemsCurrentMap = bidItemsCurrentMap;
	}

}
