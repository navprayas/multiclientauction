package com.navprayas.bidding.auction.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.auction.entity.AuctionEntity;
import com.navprayas.bidding.common.form.Auction;

@Repository
@Transactional
public class AuctionDaoImpl implements AuctionDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(AuctionEntity ob) {
		sessionFactory.getCurrentSession().save(ob);

	}

	public Auction getAuction(Long auctionId) {
		return (Auction) sessionFactory.getCurrentSession().get(Auction.class, auctionId);
	}
}
