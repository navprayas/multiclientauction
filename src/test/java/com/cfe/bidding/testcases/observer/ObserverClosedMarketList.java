package com.cfe.bidding.testcases.observer;

import java.util.ArrayList;
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
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.engine.redis.RedisConstants;
import com.navprayas.bidding.observer.service.IObserverService;
import com.navprayas.bidding.utility.RedisCacheService;

public class ObserverClosedMarketList extends TestCase {
	ApplicationContext context;
	private final static Logger logger = LoggerFactory
			.getLogger(ObserverMarketListTestCase.class);
	private ICommonService commonService;
	private IBidderService bidderService;
	private IObserverService observerService;

	protected void setUp() {
		context = new ClassPathXmlApplicationContext("bidding-servlet.xml");
		commonService = (ICommonService) context.getBean("commonService");
		bidderService = (IBidderService) context.getBean("bidderService");
		System.out.println(context);

	}

	public void testObserverClosedMarketList() {
		Integer categoryId = null;
		String page = "1";
		logger.info("In getBidItemsForCategoryForClosedMarketForObserver Method For category: "
				+ categoryId);

		Users user = commonService.getUserForUsername("observer1");
		String name = user.getUsername();
		if (categoryId == null) {
			categoryId = 0;
		}
		logger.debug("UserName For category: " + name);
		List<Bids> bidsList = null;
		CommonVO commonVO = new CommonVO();

		commonVO.setUserName(name);
		NavigationInfo navigationInfo = new NavigationInfo();
		String endSeq = RedisCacheService.isEndSequence(user.getParentId());
		Long auctionId = 0L;
		long seqId = 0L;
		if (endSeq == null) {
			bidsList = new ArrayList<Bids>();
			logger.debug(" For category: BidItems List::" + bidsList);
			System.out.println("bidsList" + bidsList);
			List<BidderCategory> categoryList = commonService.getCategoryList(
					name, user.getParentId());
			System.out.println("bidderCategoryList" + categoryList);
			logger.debug(" For category: bidderCategoryList List::"
					+ categoryList);
			System.out.println("categoryName" + categoryId);

			System.out.println("observer_closed");
		} else if (endSeq.equalsIgnoreCase("false")) {
			long activeBidItemId = RedisCacheService.getActiveBidItemId(user
					.getParentId());
			Map<String, String> activeItemDetails = RedisCacheService
					.getBidItemSequenceDetails(activeBidItemId,
							user.getParentId());
			auctionId = Long.parseLong(activeItemDetails
					.get(RedisConstants.ATTR_AUCTIONID));
			seqId = Long.parseLong(activeItemDetails
					.get(RedisConstants.ATTR_SEQUENCEID));
		} else {
			String strAuctionId = RedisCacheService.getAuctionId(user
					.getParentId());
			if (strAuctionId == null) {
				System.out.print("observer_closed");
			}
			auctionId = new Long(strAuctionId);
		}

		commonVO.setSequenceId(seqId);
		commonVO.setAuctionId(auctionId);
		commonVO.setCategoryId(categoryId);

		logger.debug("Before record count for Biditems:");
		Long count = null;
		count = seqId - 1;
		if (count < 0) {
			count = bidderService
					.findBidItemsCountForClosedListForBidder(commonVO);
		}
		if (seqId == 0 && count != 0) {
			seqId = count + 1;
			commonVO.setSequenceId(seqId);
		}
		navigationInfo.setRowCount(count.intValue());
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

		if (categoryId != 0) {
			bidsList = observerService
					.getBidItemsForCategoryForClosedMarketForObserver(
							categoryId, commonVO);
		} else
			bidsList = observerService
					.getBidItemsForCategoryForClosedMarketForObserver(commonVO);

		logger.debug(" For category: BidItems List::" + bidsList);
		System.out.println("bidsList" + bidsList);
		System.out.println("navigationInfo" + navigationInfo);
		List<BidderCategory> categoryList = commonService.getCategoryList(name,
				user.getParentId());
		System.out.println("bidderCategoryList" + categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);
		System.out.println("categoryName" + categoryId);

		System.out.println("observer_closed");

	}

}
