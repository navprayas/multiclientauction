package com.cfe.bidding.testcases.bidder;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import junit.framework.TestCase;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.navprayas.bidding.common.bean.Bidder;
import com.navprayas.bidding.common.constant.CommonConstants;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.IBidItemsCacheService;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.observer.service.IObserverService;
import com.navprayas.bidding.utility.RedisCacheService;
import com.navprayas.bidding.utility.comparator.BidderAmountComparator;

public class BidderActiveMarketListTestcase extends TestCase {
	ApplicationContext context;
	private final static Logger logger = LoggerFactory
			.getLogger(BidderMarketListTestCase.class);
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

	public void testBidderActiveMarketList() {/*
		logger.info("In getBidItemsForCategoryForMarketListForBidder Method For category: "
				+ categoryId);
		HttpSession session = httpServletRequest.getSession();
		Users user = (Users) session.getAttribute(CommonConstants.USER_INFO);

		String name = user.getUsername();
		logger.debug("UserName For category: " + name);
		if (categoryId == null) {
			categoryId = 0;
		}
		List<BidderCategory> categoryList = commonService.getCategoryList(name,
				user.getParentId());
		modelMap.addAttribute("bidderCategoryList", categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);
		modelMap.addAttribute("categoryName", categoryId);
		List<BidItem> bidItemsList = new ArrayList<BidItem>();

		String endSeq = RedisCacheService.isEndSequence(user.getParentId());
		System.out.println("end sequence on bidder controller" + endSeq);
		if (endSeq != null && endSeq.equalsIgnoreCase("false")) {
			BidItem activeBidItem = bidItemsCacheService.getBidItem(
					RedisCacheService.getActiveBidItemId(user.getParentId()),
					bidItemsCacheService.getAuctionId(user.getParentId()),
					user.getParentId());
			logger.debug("Active bid item " + activeBidItem.getTimeLeft());
			
			
			if (activeBidItem != null) {
				Long activeBidItemCategoryid = activeBidItem.getCategory()
						.getCategoryId();
				if (categoryId.longValue() == 0) {
					if (!checkBidderAllowedforThisCategory(categoryList,
							activeBidItemCategoryid)) {

						modelMap.addAttribute("bidItemsList", bidItemsList);
						return "bidder_active";
					}
				} else if ((categoryId.longValue() == 0)
						|| (categoryId.longValue() == activeBidItem
								.getCategory().getCategoryId())) {
					logger.debug("Same category Id found " + categoryId);
				} else {
					modelMap.addAttribute("bidItemsList", bidItemsList);
					return "bidder_active";
				}
				activeBidItem.setItemLots(commonService
						.getItemLots(activeBidItem.getBidItemId()));
				logger.debug(" For category: BidItems List::" + bidItemsList);

				if (activeBidItem.getCurrentMarketPrice() == null)
					activeBidItem.setCurrentMarketPrice(activeBidItem
							.getMinBidPrice());
				bidItemsList.add(activeBidItem);

				BidItem tempItem = bidderService.getBidItem(activeBidItem
						.getBidItemId());
				if (tempItem != null && activeBidItem != null) {
					activeBidItem.setSerialNo(tempItem.getSerialNo());
				}

				Map<Long, String> bidItemWithRanks = new HashMap<Long, String>();
				Map<Long, String> bidItemWithAutoBidFlag = new HashMap<Long, String>();

				for (BidItem item : bidItemsList) {
					Bidder tempBidder = new Bidder();
					tempBidder.setBidderName(name);
					List<Bidder> bidders = item.getCurrentBidderList();
					int rank = bidders.indexOf(tempBidder) + 1;
					bidItemWithRanks.put(item.getBidItemId(), rank + "");
					if (item.isAutoBidFlag() && rank > 0
							&& bidders.get(rank - 1).isAutoBid()) {
						bidItemWithAutoBidFlag.put(item.getBidItemId(), "2");
					} else {
						bidItemWithAutoBidFlag.put(item.getBidItemId(), "1");
					}
				}
				modelMap.addAttribute("bidItemWithRanks", bidItemWithRanks);
				modelMap.addAttribute("bidItemWithAutoBidFlag",
						bidItemWithAutoBidFlag);
				Set<Long> biditemBidderSet = prefferedBidItemsForBidder(name);
				Map<Long, Integer> bidItemPrefferMap = new HashMap<Long, Integer>();
				for (Long bidId : biditemBidderSet)
					bidItemPrefferMap.put(bidId, 1);

				logger.debug("bidItemPrefferMap: " + bidItemPrefferMap);
				modelMap.addAttribute("bidItemPrefferMap", bidItemPrefferMap);
			}
		}
		modelMap.addAttribute("bidItemsList", bidItemsList);
		return "bidder_active";
	*/}
}
