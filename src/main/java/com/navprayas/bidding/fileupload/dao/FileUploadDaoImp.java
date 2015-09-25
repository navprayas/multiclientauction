package com.navprayas.bidding.fileupload.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.fileupload.entity.BidItemEntity;
import com.navprayas.bidding.fileupload.entity.ItemLotEntity;
@Repository
@Transactional
public class FileUploadDaoImp implements FileUploadDao{
	
	@Autowired
	SessionFactory sessionFactory;

	public void saveAuctionDataDao(ItemLotEntity itemLotEntity,BidItemEntity bidItemEntity,BidSequence bidSequence) {
		Integer bidItemEntity1 = (Integer)this.sessionFactory.getCurrentSession()
			      .save(bidItemEntity);
			    Long bidItemId = Long.valueOf(Long.parseLong(bidItemEntity1.toString()));
			    BidItem bidItem = (BidItem)this.sessionFactory.getCurrentSession().get(BidItem.class, bidItemId);
			    bidItem.setBidItemId(bidItemId);
			    bidSequence.setBidItem(bidItem);
			    bidSequence.setBidspan(Long.valueOf(120L));
			    this.sessionFactory.getCurrentSession().save(bidSequence);
			    itemLotEntity.setBidItemId(bidItemEntity1.intValue());
			    itemLotEntity.setLotId(bidItemEntity1.intValue());
			    System.out.println(itemLotEntity.getLotId());
			    this.sessionFactory.getCurrentSession().save(itemLotEntity);

	}

	

	

}
