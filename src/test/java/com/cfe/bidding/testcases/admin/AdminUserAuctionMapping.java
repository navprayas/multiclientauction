package com.cfe.bidding.testcases.admin;

import java.util.ArrayList;
import java.util.List;

import junit.framework.TestCase;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.navprayas.bidding.common.dto.UserVO;
import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.ICommonService;

public class AdminUserAuctionMapping extends TestCase {
	ApplicationContext context;
	private final static Logger logger = LoggerFactory
			.getLogger(AdminAuctionStartTestCase.class);
	private ICommonService commonService;

	public void setUp() {
		context = new ClassPathXmlApplicationContext("bidding-servlet.xml");
		System.out.println(context);
		commonService = (ICommonService) context.getBean("commonService");

	}

	public void testUserAuctionMapping() {
		Users user = commonService.getUserForUsername("admin1");
		if (user == null) {
			System.out.println("user null");
		}
		List<Auction> auctionList = commonService.getAuctionListForAction(user
				.getUserId());
		List<Auction> newAuctionList = new ArrayList<Auction>();
		for (Auction auction : auctionList) {
			if ("Start".equalsIgnoreCase(auction.getStatus())
					|| "Running".equalsIgnoreCase(auction.getStatus())) {
				newAuctionList.add(auction);
			}
		}
		System.out.println("newAuctionList" + newAuctionList);
		System.out.println("AuctionList" + newAuctionList);
		System.out.println("UserList"
				+ commonService.getActiveBidders(user.getUserId()));

		System.out.println("CategoryList"
				+ commonService.getCategoryList(user.getUserId()));
		System.out
				.println("========================================================");

		String selectedUserIdList = null;
		List<UserVO> userlist = commonService
				.getActiveBidders(user.getUserId());
		for (UserVO userVO : userlist) {
			if(selectedUserIdList==null){
				selectedUserIdList= userVO.getUserId().toString();
			}
			selectedUserIdList += "$"+userVO.getUserId();

		}

		String msg = null;
		Long selectedAuctionId = newAuctionList.get(0).getAuctionId();
		String selectedCategoryIdList = "1$2$3$4";

		try {
			commonService.setUserAuctionMap(selectedAuctionId,
					selectedCategoryIdList, selectedUserIdList);
			msg = "All selected Users are now allowed for the auction "
					+ selectedAuctionId;
		} catch (Exception e) {
			e.printStackTrace();
			msg = "Mapping Not successful";
		}

	}
}
