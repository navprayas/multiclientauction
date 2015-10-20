package com.cfe.bidding.testcases.observer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import junit.framework.TestCase;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.navprayas.bidding.common.bean.Bidder;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.IBidItemsCacheService;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.observer.service.IObserverService;
import com.navprayas.bidding.utility.RedisCacheService;
import com.navprayas.bidding.utility.comparator.BidderAmountComparator;

public class ObserverActiveMarketListTestcase extends TestCase {/*
	ApplicationContext context;
	private final static Logger logger = LoggerFactory
			.getLogger(ObserverMarketListTestCase.class);
	private ICommonService commonService;
	private IBidItemsCacheService bidItemsCacheService;
	private IObserverService observerService;

	protected void setUp() {
		context = new ClassPathXmlApplicationContext("bidding-servlet.xml");
		commonService = (ICommonService) context.getBean("commonService");
		bidItemsCacheService = (IBidItemsCacheService) context
				.getBean("bidItemsCacheService");
		observerService = (IObserverService) context.getBean("bidderService");
	}

	public void testObserverActiveMarketList() {

		Integer categoryId = null;

		Users user = commonService.getUserForUsername("observer1");
		String name = user.getUsername();
		if (categoryId == null) {
			categoryId = 0;
		}
		logger.debug("UserName For category: " + name);

		List<BidderCategory> categoryList = commonService.getCategoryList(name,
				user.getParentId());
		System.out.println("bidderCategoryList" + categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);
		System.out.println("categoryName" + categoryId);

		List<BidItem> bidItemsList = new ArrayList<BidItem>();

		BidItem activeBidItem = bidItemsCacheService.getBidItem(
				RedisCacheService.getActiveBidItemId(user.getParentId()),
				bidItemsCacheService.getAuctionId(user.getParentId()),
				user.getParentId());
		if (activeBidItem != null) {

			if ((categoryId.longValue() == 0)
					|| (categoryId.longValue() == activeBidItem.getCategory()
							.getCategoryId())) {
				logger.debug("Same category Id found " + categoryId);
			} else {
				System.out.println("bidItemsList" + bidItemsList);
				System.out.println("observer_active");
			}

			activeBidItem.setItemLots(commonService.getItemLots(activeBidItem
					.getBidItemId()));
			logger.debug(" For category: BidItems List::" + bidItemsList);

			bidItemsList.add(activeBidItem);

			BidItem tempItem = observerService.getBidItem(activeBidItem
					.getBidItemId());
			if (tempItem != null && activeBidItem != null) {
				activeBidItem.setSerialNo(tempItem.getSerialNo());
			}

			for (BidItem item : bidItemsList) {
				List<Bidder> bidders = item.getCurrentBidderList();
				Collections.sort(bidders, new BidderAmountComparator());
				if (bidders.size() > 0) {
					Bidder bidder = bidders.get(0);
					System.out
							.println("CurrentBidder" + bidder.getBidderName());
				} else {
					System.out.println("CurrentBidder" + "");
				}

			}

		}
		System.out.println("bidItemsList" + bidItemsList);
		// return "bidder/active_bidder";
		System.out.println("observer_active");

	}
*/}
