package com.navprayas.bidding.admin.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.navprayas.bidding.common.constant.CommonConstants;
import com.navprayas.bidding.fileupload.entity.BidItemEntity;

@Repository
public class AdminBidItemDaoImpl implements AdminBidItemDao {
	@Autowired
	private SessionFactory sessionFactory;

	public String createBidItem(BidItemEntity bidItemEntity) {
		sessionFactory.getCurrentSession().save(bidItemEntity);
		return CommonConstants.SUCCESS;
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
	public String updateBidItemById(Long auctionId, Long bidItemId) {
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
