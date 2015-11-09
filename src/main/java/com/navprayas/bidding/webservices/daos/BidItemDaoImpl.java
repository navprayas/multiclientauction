package com.navprayas.bidding.webservices.daos;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.navprayas.bidding.common.constant.CommonConstants;
import com.navprayas.bidding.common.form.BidItem;

@Repository
public class BidItemDaoImpl implements BidItemsDao {

	@Autowired
	private SessionFactory sessionFactory;

	public List<BidItem> getBidItemsList(Long categoryId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(BidItem.class);
		criteria.add(Restrictions.eq("category.categoryId", categoryId))
				.add(Restrictions.eq("statusCode", CommonConstants.STATUSCODE));
		return criteria.list();
	}
}
