package com.navprayas.bidding.admin.dao;

import java.util.List;

import com.navprayas.bidding.fileupload.entity.BidItemEntity;

public interface AdminBidItemDao {
	public Integer createBidItem(BidItemEntity bidItemEntity);

	public List<BidItemEntity> getBidItemsList(Long auctionId);

	public List<BidItemEntity> getBidItemsListByUserId(Long userId);

	public String updateBidItemById(Long auctionId, Integer bidItemId);

}
