package com.navprayas.bidding.webservices.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.auction.dao.AuctionDao;
import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.webservices.daos.BidItemsDao;
import com.navprayas.bidding.webservices.dtos.BidItemsDto;

@Service
@Transactional
public class BidItemServiceImpl implements BidItemsService {
	@Autowired
	private BidItemsDao BidItemsDao;
	@Autowired
	private AuctionDao auctionDao;

	@Override
	public List<BidItemsDto> getBidItemsList(Long categoryId) {
		List<BidItem> list = BidItemsDao.getBidItemsList(categoryId);

		return bidItemConverterToDTo(list);
	}

	private List<BidItemsDto> bidItemConverterToDTo(List<BidItem> list) {
		List<BidItemsDto> bidItemDtoList = new ArrayList<BidItemsDto>();
		BidItemsDto bidItemsDto = null;

		Auction auction = auctionDao.getAuction(list.get(0).getAuctionId());
		for (BidItem bidItem : list) {
			bidItemsDto = new BidItemsDto();
			if (auction.getAuctionId() != bidItem.getAuctionId()) {
				auction = auctionDao.getAuction(bidItem.getAuctionId());
			}
			bidItemsDto.setAuctionName(auction.getName());
			bidItemsDto.setAuctionId(auction.getAuctionId());
			bidItemsDto.setBidItemId(bidItem.getBidItemId());
			bidItemsDto.setName(bidItem.getName());
			bidItemsDto.setBidStartTime(bidItem.getBidStartTime());
			bidItemsDto.setCurrency(bidItem.getCurrency());
			bidItemsDto.setCity(bidItem.getCity());
			bidItemsDto.setCurrentMarketPrice(bidItem.getCurrentMarketPrice());
			bidItemsDto.setImageUrl(bidItem.getImageUrl());
			bidItemsDto.setMinBidPrice(bidItem.getMinBidPrice());
			bidItemsDto.setMinBidIncrement(bidItem.getMinBidIncrement());
			bidItemDtoList.add(bidItemsDto);
		}

		return bidItemDtoList;

	}

}
