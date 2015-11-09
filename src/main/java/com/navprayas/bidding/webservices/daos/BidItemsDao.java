package com.navprayas.bidding.webservices.daos;

import java.util.List;

import com.navprayas.bidding.common.form.BidItem;

public interface BidItemsDao {
	public List<BidItem> getBidItemsList(Long categoryId);
}
