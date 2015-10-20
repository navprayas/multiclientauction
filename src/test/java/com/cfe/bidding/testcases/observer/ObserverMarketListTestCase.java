package com.cfe.bidding.testcases.observer;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import junit.framework.TestCase;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.tuckey.web.filters.urlrewrite.utils.StringUtils;

import com.navprayas.bidding.bidder.service.IBidderService;
import com.navprayas.bidding.common.dto.CommonVO;
import com.navprayas.bidding.common.dto.NavigationInfo;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.IBidItemsCacheService;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.engine.redis.RedisConstants;
import com.navprayas.bidding.utility.RedisCacheService;

public class ObserverMarketListTestCase extends TestCase {
	ApplicationContext context;
	private final static Logger logger = LoggerFactory
			.getLogger(ObserverMarketListTestCase.class);
	private ICommonService commonService;
	private IBidItemsCacheService bidItemsCacheService;
	private IBidderService bidderService;

	protected void setUp() {
		context = new ClassPathXmlApplicationContext("bidding-servlet.xml");
		commonService = (ICommonService) context.getBean("commonService");
		bidItemsCacheService = (IBidItemsCacheService) context
				.getBean("bidItemsCacheService");
		bidderService = (IBidderService) context.getBean("bidderService");
		System.out.println(context);

	}

	public void testObserverMarketList() {

		Integer categoryId = null;
		String page = null;

		Users user = commonService.getUserForUsername("observer1");
		logger.info("In getBidItemsForCategoryForMarketListForObserver Method For category: "
				+ categoryId);

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

		List<BidItem> bidItemsList = null;

		System.out.println("refreshTime" + -1);
		String endSeq = RedisCacheService.isEndSequence(user.getParentId());

		CommonVO commonVO = new CommonVO();

		commonVO.setUserName(name);
		NavigationInfo navigationInfo = new NavigationInfo();

		if (endSeq == null) {
			if (RedisCacheService.getAuctionId(user.getParentId()) == null) {
				System.out.println("Market List page observer_marketlist");
			}
			Long auctionId = new Long(RedisCacheService.getAuctionId(user
					.getParentId()));

			commonVO.setSequenceId(0L);
			commonVO.setAuctionId(auctionId);
			commonVO.setCategoryId(categoryId);
			logger.debug("Before record count for Biditems:");

			Long count = null;
			if (categoryId != 0) {
				count = bidderService
						.findBidItemsCountForMarketListForBidderForCategory(commonVO);
			} else {
				count = bidderService
						.findBidItemsCountForMarketListForBidder(commonVO);
			}
			navigationInfo.setRowCount(Integer.valueOf(count + ""));

			if (StringUtils.isBlank(page)) {
				navigationInfo.setCurrentPage(1);
			} else {
				navigationInfo.setCurrentPage(Integer.parseInt(page));
			}
			int curPage = (navigationInfo.getCurrentPage() - 1) < 0 ? 0
					: (navigationInfo.getCurrentPage() - 1);
			logger.debug("Before getting data");
			commonVO.setFirstResult(curPage * navigationInfo.getPageSize());
			commonVO.setMaxResult(navigationInfo.getPageSize());

			logger.debug("****** BidItems Count is::" + count + " *******");

			if (categoryId != 0)
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(
								categoryId, commonVO);
			else
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(commonVO);
			if (bidItemsList == null || bidItemsList.size() == 0) {
				System.out.println("Market List page observer_marketlist");
			}
			Date date = null;
			if (bidItemsCacheService.getAuctionStartTime(user.getParentId()) == null) {
				date = commonService.getActualAuctionStartTime(auctionId);
			} else {
				date = bidItemsCacheService.getAuctionStartTime(user
						.getParentId());
			}
			if (date == null) {
				System.out.println("Market List page observer_marketlist");
			}
			Date currDate = new Date();
			long refreshTime = date.getTime() - currDate.getTime();
			refreshTime = (long) (refreshTime / 1000);
			if (refreshTime < 0) {
				System.out.println("Market List page observer_marketlist");
				// throw new
				// RuntimeException("Refresh time can not be negative");
			}

			if (curPage > 0 && bidItemsList.size() > 0) {
				refreshTime = refreshTime
						+ ((curPage * navigationInfo.getPageSize()))
						* bidItemsList.get(0).getBidSpan();
			}
			System.out.println("refreshTime" + refreshTime);
			for (BidItem bidItem : bidItemsList) {
				bidItem.setTimeLeft(refreshTime);
				refreshTime += bidItem.getBidSpan();
				if (bidItem.getCurrentMarketPrice() == null) {
					bidItem.setCurrentMarketPrice(bidItem.getMinBidPrice());
					bidItemsList.set(bidItemsList.indexOf(bidItem), bidItem);
				}
			}
		} else if (endSeq.equalsIgnoreCase("false")) {
			long activeBidItemId = RedisCacheService.getActiveBidItemId(user
					.getParentId());
			Map<String, String> activeItemDetails = RedisCacheService
					.getBidItemSequenceDetails(activeBidItemId,
							user.getParentId());
			long auctionId = Long.parseLong(activeItemDetails
					.get(RedisConstants.ATTR_AUCTIONID));
			long seqId = Long.parseLong(activeItemDetails
					.get(RedisConstants.ATTR_SEQUENCEID));

			commonVO.setSequenceId(seqId);
			commonVO.setAuctionId(auctionId);
			commonVO.setCategoryId(categoryId);

			Long count = null;
			if (categoryId != 0) {
				count = bidderService
						.findBidItemsCountForMarketListForBidderForCategory(commonVO);
			} else {
				count = bidderService
						.findBidItemsCountForMarketListForBidder(commonVO);
			}
			navigationInfo.setRowCount(Integer.valueOf(count + ""));
			logger.debug("****** BidItems Count is::" + count + " *******");

			if (StringUtils.isBlank(page)) {
				navigationInfo.setCurrentPage(1);
			} else {
				navigationInfo.setCurrentPage(Integer.parseInt(page));
			}
			int curPage = (navigationInfo.getCurrentPage() - 1) < 0 ? 0
					: (navigationInfo.getCurrentPage() - 1);
			logger.debug("Before getting data");
			commonVO.setFirstResult(curPage * navigationInfo.getPageSize());
			commonVO.setMaxResult(navigationInfo.getPageSize());

			if (categoryId != 0)
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(
								categoryId, commonVO);
			else
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(commonVO);

			BidItem activeBidItem = bidItemsCacheService.getBidItem(
					RedisCacheService.getActiveBidItemId(user.getParentId()),
					bidItemsCacheService.getAuctionId(user.getParentId()),
					user.getParentId());

			long refreshTime = activeBidItem.getTimeLeft();
			logger.debug("*****refreshTime::" + refreshTime);
			if (curPage > 0 && bidItemsList.size() > 0) {
				refreshTime = refreshTime
						+ ((curPage * navigationInfo.getPageSize()))
						* bidItemsList.get(0).getBidSpan();
			}
			System.out.println("refreshTime" + refreshTime);

			for (BidItem bidItem : bidItemsList) {
				bidItem.setTimeLeft(refreshTime);
				logger.debug("bidItem : " + bidItem.getBidItemId() + " "
						+ bidItem.getBidSpan() + " " + refreshTime);
				refreshTime += bidItem.getBidSpan();
				if (bidItem.getCurrentMarketPrice() == null) {
					bidItem.setCurrentMarketPrice(bidItem.getMinBidPrice());
					bidItemsList.set(bidItemsList.indexOf(bidItem), bidItem);
				}
			}
		} else {
			bidItemsList = new ArrayList<BidItem>();
		}
		logger.debug(" For category: BidItems List::" + bidItemsList);
		System.out.println("bidItemsList" + bidItemsList);

		System.out.println("navigationInfo" + navigationInfo);

		System.out.println("Market List page observer_marketlist");

	}

}
