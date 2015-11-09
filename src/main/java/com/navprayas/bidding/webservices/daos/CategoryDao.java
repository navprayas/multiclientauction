package com.navprayas.bidding.webservices.daos;

import java.util.List;

import com.navprayas.bidding.common.form.Category;

public interface CategoryDao {
	public List<Category> getAllCategory();
	public Category getCategory(Long categoryId);

}
