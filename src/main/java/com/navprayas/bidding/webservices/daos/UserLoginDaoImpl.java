package com.navprayas.bidding.webservices.daos;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.navprayas.bidding.common.constant.CommonConstants;
import com.navprayas.bidding.common.form.Users;

@Repository
public class UserLoginDaoImpl implements UserLoginDao {
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public Users validateUser(String userName, String password) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Users.class)
				.add(Restrictions.eq("username", userName)).add(Restrictions.eq("password", password));
		return (Users) criteria.uniqueResult();
	}

}
