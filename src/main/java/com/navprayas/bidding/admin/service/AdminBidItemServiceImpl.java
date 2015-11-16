package com.navprayas.bidding.admin.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.admin.dao.AdminBidItemDao;
import com.navprayas.bidding.fileupload.entity.BidItemEntity;

@Service
@Transactional
public class AdminBidItemServiceImpl implements AdminBidItemService {
	@Autowired
	private AdminBidItemDao adminBidItemDao;

	public BidItemEntity createBidItem(BidItemEntity bidItemEntity) {
		bidItemEntity.setCreatedTime(new Date());
		return adminBidItemDao.createBidItem(bidItemEntity);
	}

	@Override
	public List<BidItemEntity> getBidItemsList(Long auctionId) {
		return adminBidItemDao.getBidItemsList(auctionId);
	}

	@Override
	public List<BidItemEntity> getBidItemsListByUserId(Long userId) {
		return adminBidItemDao.getBidItemsListByUserId(userId);
	}

	@Override
	public String updateBidItemById(Long auctionId, Integer bidItemId) {
		return adminBidItemDao.updateBidItemById(auctionId, bidItemId);
	}

}
