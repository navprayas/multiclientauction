package com.navprayas.bidding.webservices.services;

import java.util.List;

import com.navprayas.bidding.webservices.dtos.BidItemsDto;

public interface BidItemsService {
	public List<BidItemsDto> getBidItemsList(Long categoryId);
}
