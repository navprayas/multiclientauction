package com.cfe.bidding.testcases.observer;

import java.util.Calendar;

import junit.framework.TestCase;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.engine.redis.RedisConstants;
import com.navprayas.bidding.utility.CometPusher;
import com.navprayas.bidding.utility.RedisCacheService;

public class ObserverTimeExtentionTestCase extends TestCase{
	ApplicationContext context;
	private ICommonService commonService;

	protected void setUp() {
		context = new ClassPathXmlApplicationContext("bidding-servlet.xml");
		System.out.println(context);
		commonService = (ICommonService) context.getBean("commonService");

	}

	public void doExtendBiddingTestCase() {

		Long bidItemId = 400L;
		Integer extendTime = 5;
		Users user = commonService.getUserForUsername("observer1");
		if (bidItemId != null && extendTime != null) {
			BidItem bidItem = RedisCacheService.getBidItem(
					RedisConstants.BIDITEM + bidItemId,
					String.valueOf(bidItemId), user.getParentId());
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.SECOND, (int) bidItem.getTimeLeft() + extendTime);
			bidItem.setBidEndTime(cal.getTime());
			cal.add(Calendar.SECOND, -(bidItem.getTimeExtAfterBid() + 10));
			bidItem.setLastUpDateTime(cal.getTime());
			RedisCacheService.setBidEndTime(bidItemId, bidItem.getBidEndTime(),
					RedisConstants.BIDITEM + bidItemId, user.getParentId());
			RedisCacheService.setBidItemLastUpdateTime(bidItemId,
					bidItem.getLastUpDateTime(), RedisConstants.BIDITEM
							+ bidItemId, user.getParentId());
			CometPusher.getInstance().pushBidExtendTime(bidItem);
		}

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		System.out.println(new ResponseEntity<String>(headers, HttpStatus.OK));
	}
}
