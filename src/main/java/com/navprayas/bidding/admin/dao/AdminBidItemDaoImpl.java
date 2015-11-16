package com.navprayas.bidding.admin.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.navprayas.bidding.common.constant.CommonConstants;
import com.navprayas.bidding.fileupload.entity.BidItemEntity;

@Repository
public class AdminBidItemDaoImpl implements AdminBidItemDao {
	@Autowired
	private SessionFactory sessionFactory;

	public BidItemEntity createBidItem(BidItemEntity bidItemEntity) {

		Integer id = (Integer) sessionFactory.getCurrentSession().save(bidItemEntity);
		MultipartFile mFile = bidItemEntity.getFile();
		bidItemEntity.setBidItemId(id);
		bidItemEntity
				.setImageUrl(bidItemEntity.getImageUrl() + bidItemEntity.getBidItemId() + mFile.getOriginalFilename());
		if (bidItemEntity != null) {
			sessionFactory.getCurrentSession().update(bidItemEntity);
		}
		return bidItemEntity;
	}

	@Override
	public List<BidItemEntity> getBidItemsList(Long auctionId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(BidItemEntity.class);

		criteria.add(Restrictions.eq("auctionId", auctionId));

		return criteria.list();
	}

	@Override
	public List<BidItemEntity> getBidItemsListByUserId(Long userId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(BidItemEntity.class);

		criteria.add(Restrictions.eq("userId", userId));

		return criteria.list();
	}

	@Override
	public String updateBidItemById(Long auctionId, Integer bidItemId) {
		BidItemEntity bidItemEntity = (BidItemEntity) sessionFactory.getCurrentSession().get(BidItemEntity.class,
				bidItemId);
		if (bidItemEntity != null) {
			bidItemEntity.setParentAuction(bidItemEntity.getAuctionId());
			bidItemEntity.setAuctionId(auctionId);
			sessionFactory.getCurrentSession().update(bidItemEntity);
		}
		return CommonConstants.SUCCESS;
	}

}
