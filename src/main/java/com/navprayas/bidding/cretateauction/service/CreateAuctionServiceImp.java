package com.navprayas.bidding.cretateauction.service;

import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.cretateauction.dao.CreateAuctionDao;
import com.navprayas.bidding.cretateauction.entity.CreateAuctionEntity;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class CreateAuctionServiceImp
  implements CreateAuctionService
{
  @Autowired
  CreateAuctionDao auctionDao;
  
  public String saveData(Auction auctionEntity)
    throws ParseException
  {
    auctionEntity.setCreatedTime(new Timestamp(new Date().getTime()));
    
    this.auctionDao.save(auctionEntity);
    return "createauction/CreateAuction";
  }
  
  public List<CreateAuctionEntity> getAllAuctionList()
  {
    return this.auctionDao.getAllAuctionList();
  }
  
  public CreateAuctionEntity getAuctionDetails(Integer auctionId)
  {
    return this.auctionDao.getAuction(auctionId);
  }
}
