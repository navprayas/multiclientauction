package com.cfe.bidding.testcases.observer;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import junit.framework.TestCase;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.navprayas.bidding.common.constant.CommonConstants;
import com.navprayas.bidding.common.dto.CommonVO;
import com.navprayas.bidding.common.dto.ObserverVO;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.engine.redis.RedisConstants;
import com.navprayas.bidding.observer.service.IObserverService;
import com.navprayas.bidding.utility.CometPusher;
import com.navprayas.bidding.utility.RedisCacheService;

public class ObserverBidApproveTestCase extends TestCase {
	ApplicationContext context;
	private final static Logger logger = LoggerFactory
			.getLogger(ObserverBidApproveTestCase.class);
	private ICommonService commonService;
	private IObserverService observerService;

	protected void setUp() {
		context = new ClassPathXmlApplicationContext("bidding-servlet.xml");
		System.out.println(context);
		commonService = (ICommonService) context.getBean("commonService");
		observerService = (IObserverService) context.getBean("observerService");
	}

	public void doExtendBiddingTestCase() {
		ObserverVO observerVO = new ObserverVO();
		observerVO.setBidAmount(10000d);
		observerVO.setCategoryId("2");
		logger.debug("In getH1Approved Method::");
		String page = observerVO.getPageO();
		logger.debug("Page No:" + page);

		Users user = commonService.getUserForUsername("observer1");

		if (observerVO.getCategoryId() == null)
			observerVO.setCategoryId("0");
		Long categoryId = Long.parseLong(observerVO.getCategoryId());
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();

		boolean success = true;
		if (observerVO != null && observerVO.getBidItemId() != null) {
			success = observerService.getH1Approved(observerVO, name);
		}
		logger.debug("UserName For category: " + name);

		List<Bids> bidsList = null;

		CommonVO commonVO = new CommonVO();
		commonVO.setUserName(name);
		Long auctionId = 0L;
		long seqId = 0L;
		String endSeq = RedisCacheService.isEndSequence(user.getParentId());
		if (endSeq == null) {
			bidsList = new ArrayList<Bids>();
			System.out.println("bidsList" + bidsList);
			List<BidderCategory> bidCategoryList = commonService
					.getCategoryList(name, user.getParentId());
			System.out.println("bidderCategoryList" + bidCategoryList);
			logger.debug(" For category: categoryList List::" + bidCategoryList);

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
				System.out.println("observer_closed");
			}
			auctionId = new Long(strAuctionId);

		}
		commonVO.setSequenceId(seqId);
		commonVO.setAuctionId(auctionId);
		commonVO.setCategoryId(categoryId);

		//Integer categoryL = categoryId.intValue();
		System.out.println("H1Approved" + success);
		/*
		 * if(categoryId != 0){ bidsList =
		 * observerService.getBidItemsForCategoryForClosedMarketForObserver
		 * (categoryId, commonVO); } else { bidsList =
		 * observerService.getBidItemsForCategoryForClosedMarketForObserver
		 * (commonVO); } modelMap.addAttribute("bidsList", bidsList);
		 * List<BidderCategory> bidCategoryList =
		 * commonService.getCategoryList(name);
		 * modelMap.addAttribute("bidderCategoryList", bidCategoryList);
		 * logger.debug(" For category: categoryList List::"+bidCategoryList);
		 * 
		 * modelMap.addAttribute("categoryName", categoryId);
		 */

		System.out.println("observer_closed");

	}
}
