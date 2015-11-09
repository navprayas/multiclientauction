package com.navprayas.bidding.webservices.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.common.form.Category;
import com.navprayas.bidding.webservices.daos.CategoryDao;

/**
 * 
 * @author cfeindia This class Implementation for getting all category
 * 
 */

@Service
@Transactional
public class CategoryServiceImpl implements CategoryService {
	Logger log = LoggerFactory.getLogger(CategoryServiceImpl.class);
	@Autowired
	private CategoryDao categoryDao;

	/**
	 * Get All Category
	 */
	@Override
	public List<Category> getAllCategory() {
		log.debug("get All Category Method is called");
		return categoryDao.getAllCategory();
	}

}
