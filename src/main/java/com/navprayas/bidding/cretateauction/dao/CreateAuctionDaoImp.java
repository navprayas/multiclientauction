package com.navprayas.bidding.cretateauction.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.cretateauction.entity.CreateAuctionEntity;

@Repository
@Transactional
public class CreateAuctionDaoImp implements CreateAuctionDao {
	@Autowired
	SessionFactory sessionFactory;

	public String save(Auction auctionEntity) {
		Long id = null;
		String auctionId = null;

		id = (Long) this.sessionFactory.getCurrentSession().save(auctionEntity);
		auctionId = id.toString();

		return auctionId;
	}

	@Override
	public List<CreateAuctionEntity> getAllAuctionList() {
		// TODO Auto-generated method stub
		Criteria criteria = sessionFactory.getCurrentSession()
				.createCriteria(CreateAuctionEntity.class)
				.add(Restrictions.eq("isApproved", "0"));
		return (List<CreateAuctionEntity>) criteria.list();
	}

	@Override
	public CreateAuctionEntity getAuction(Integer auctionId) {
		// TODO Auto-generated method stub
		return (CreateAuctionEntity) sessionFactory.getCurrentSession().get(
				CreateAuctionEntity.class, auctionId);

	}

	public Auction getAuctionForExcel(Long auctionId) {
		// TODO Auto-generated method stub
		return (Auction) sessionFactory.getCurrentSession().get(Auction.class,
				auctionId);

	}

}
