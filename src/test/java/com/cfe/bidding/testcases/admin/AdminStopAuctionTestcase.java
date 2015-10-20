package com.cfe.bidding.testcases.admin;

import junit.framework.TestCase;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.navprayas.bidding.common.service.ICommonService;

public class AdminStopAuctionTestcase extends TestCase {
	ApplicationContext context;
	private final static Logger logger = LoggerFactory
			.getLogger(AdminStopAuctionTestcase.class);
	private ICommonService commonService;

	public void setUp() {
		context = new ClassPathXmlApplicationContext("bidding-servlet.xml");
		System.out.println(context);
		commonService = (ICommonService) context.getBean("commonService");

	}

	public void testStopAuction() {
		System.out.println("test auction Stop");

		commonService.closeAuction(200l);
	}

}
