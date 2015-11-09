package com.navprayas.bidding.webservices.daos;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.navprayas.bidding.common.form.Category;

@Repository
public class CategoryDaoImpl implements CategoryDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Category> getAllCategory() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Category.class);
		return criteria.list();
	}

	@Override
	public Category getCategory(Long categoryId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Category.class)
				.add(Restrictions.eq("categoryId", categoryId));
		return (Category) criteria.uniqueResult();
	}

}
