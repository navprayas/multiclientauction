package com.navprayas.bidding.cretateauction.service;

import java.text.ParseException;
import java.util.List;

import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.cretateauction.entity.CreateAuctionEntity;

public interface CreateAuctionService {
	public String saveData(Auction auctionEntity) throws ParseException;
	public List<CreateAuctionEntity> getAllAuctionList();
	public CreateAuctionEntity getAuctionDetails(Integer auctionId);
	

}
