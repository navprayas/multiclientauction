package com.navprayas.bidding.admin.service;

import java.util.List;

import com.navprayas.bidding.fileupload.entity.BidItemEntity;

public interface AdminBidItemService {
	public BidItemEntity createBidItem(BidItemEntity bidItemEntity);
	public List<BidItemEntity> getBidItemsList(Long auctionId) ;
	public List<BidItemEntity> getBidItemsListByUserId(Long userId);
	public String updateBidItemById(Long auctionId, Integer bidItemId);
}
