package com.cfe.bidding.testcases.admin;

import java.util.Calendar;

import junit.framework.TestCase;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.BidItemsCacheService;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.utility.ObjectRegistry;
import com.navprayas.bidding.utility.RedisCacheService;

public class AdminAuctionStartTestCase extends TestCase {
	ApplicationContext context;
	private final static Logger logger = LoggerFactory
			.getLogger(AdminAuctionStartTestCase.class);

	public void setUp() {
		context = new ClassPathXmlApplicationContext("bidding-servlet.xml");
		System.out.println(context);

	}

	public void testAuction() {
		System.out.println("test auction start");
		ICommonService commonService;
		String auctionStart = null, auctionIdStr = "308", auctionTimeExt = "120";
		commonService = (ICommonService) context.getBean("commonService");

		Users user = commonService.getUserForUsername("admin1");
		Long auctionId = null;
		if (auctionIdStr != null && !auctionIdStr.equals("")) {
			auctionId = Long.parseLong(auctionIdStr);
		}
		if (auctionId == null || !commonService.isValidAuction(auctionId)) {
			String msg = "Auction Not Present - " + auctionId;
			logger.debug(msg);
		}
		RedisCacheService.setAuctionId(auctionId.toString(), user.getUserId());
		BidItemsCacheService bidItemsCacheService = (BidItemsCacheService) ObjectRegistry
				.getInstance().getObject(BidItemsCacheService.class.getName());
		bidItemsCacheService.clientAuctionMap.put(user.getUserId(), auctionId);
		try {
			if (auctionStart != null && auctionStart.length() > 0) {/*
																	 * SimpleDateFormat
																	 * sdf = new
																	 * SimpleDateFormat
																	 * (
																	 * DD_MM_YYYY_HH_MM_SS
																	 * ); Date
																	 * actualAuctionStartTime
																	 * =
																	 * sdf.parse
																	 * (
																	 * auctionStart
																	 * ); //
																	 * bidItemsCacheService
																	 * .
																	 * setAuctionStartTime
																	 * (
																	 * actualAuctionStartTime
																	 * );
																	 * bidItemsCacheService
																	 * .
																	 * auctionStartTimeMap
																	 * .
																	 * put(user.
																	 * getUserId
																	 * (),
																	 * actualAuctionStartTime
																	 * );
																	 * commonService
																	 * .
																	 * setActualAuctionStartTime
																	 * (
																	 * auctionId
																	 * ,
																	 * actualAuctionStartTime
																	 * );
																	 */
			} else if (auctionTimeExt != null && auctionTimeExt.length() > 0) {
				Calendar cal = Calendar.getInstance();
				int time = Integer.parseInt(auctionTimeExt);
				cal.add(Calendar.MINUTE, time + 3);
				// bidItemsCacheService.setAuctionStartTime(cal.getTime());
				bidItemsCacheService.auctionStartTimeMap.put(user.getUserId(),
						cal.getTime());
				commonService.setActualAuctionStartTime(auctionId,
						cal.getTime());
			} else {
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.MINUTE, 3);
				/* bidItemsCacheService.setAuctionStartTime(cal.getTime()); */
				bidItemsCacheService.auctionStartTimeMap.put(user.getUserId(),
						cal.getTime());
				commonService.setActualAuctionStartTime(auctionId,
						cal.getTime());
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			throw new RuntimeException(e.getMessage());
		}
		bidItemsCacheService.initCache(user.getUserId());
		String msg = "Auction Started - " + auctionId;
		logger.debug(msg);

	}
}
