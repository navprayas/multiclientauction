package com.navprayas.bidding.admin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.navprayas.bidding.admin.form.Variable;
import com.navprayas.bidding.admin.service.ManageUserService;
import com.navprayas.bidding.admin.service.VariableService;
import com.navprayas.bidding.auctioncache.BidConsumerEngine;
import com.navprayas.bidding.common.constant.CommonConstants;
import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.BidItemsCacheService;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.utility.ObjectRegistry;
import com.navprayas.bidding.utility.RedisCacheService;

@RequestMapping("/admin/**")
@Controller
public class AdminController {

	private static final String DD_MM_YYYY_HH_MM_SS = "dd/MM/yyyy HH:mm:ss";

	private final static Logger logger = LoggerFactory
			.getLogger(AdminController.class);

	@Autowired
	@Qualifier("commonService")
	private ICommonService commonService;
	@Autowired
	private VariableService variableservice;
	@Autowired
	private ManageUserService manageuserservive;
	@Autowired
	private BidConsumerEngine bidConsumerEngine;

	/*
	 * @RequestMapping("/home") public String getAdminHome(ModelMap modelMap,
	 * HttpServletRequest httpServletRequest) { "admin/vendorRegistrationPage";
	 * System.out.println("Admin home page rendering"); return "adminhome"; }
	 */
	@RequestMapping("/variable")
	public String getVariablePage(ModelMap modelMap,
			HttpServletRequest httpServletRequest) {

		modelMap.addAttribute("variable", new Variable());
		// modelMap.addAttribute("bidItemsList", observerService.getBidItems());

		return "variable";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addVariable(@ModelAttribute("variable") Variable variable,
			BindingResult result, HttpServletRequest httpServletRequest) {

		variableservice.addVariable(variable);

		httpServletRequest.setAttribute("message_variable", "Success");

		return "redirect:/admin/home";
	}

	@RequestMapping("/index")
	public String listManageUser(Map<String, Object> map) {
		map.put("manageuserlist", manageuserservive.listMangeUser());
		return "reguser";
	}

	@RequestMapping(value = { "/superAdmin", "/home" }, method = RequestMethod.GET)
	public String superAdmin(ModelMap modelMap, HttpSession session) {
		Users user = (Users) session.getAttribute(CommonConstants.USER_INFO);
		List<Auction> auctionList = commonService.getAuctionListForAction(user
				.getUserId());
		Integer aunctionRunningOrClosedPresent = 0;
		if (auctionList != null) {
			for (Auction auction : auctionList) {
				if ("END".equalsIgnoreCase(auction.getStatus())
						|| "Running".equalsIgnoreCase(auction.getStatus())) {
					aunctionRunningOrClosedPresent++;
					break;
				}
			}
		}
		modelMap.addAttribute("AuctionList", auctionList);
		modelMap.addAttribute("aunctionRunningOrClosedPresent",
				aunctionRunningOrClosedPresent);
		return "superAdmin";
	}

	@RequestMapping(value = "/initcache", method = RequestMethod.GET)
	public String initcache(
			@RequestParam(value = "auctionStartTime", required = false) String auctionStart,
			@RequestParam(value = "auctionId", required = true) String auctionIdStr,
			@RequestParam(value = "auctionTimeExt", required = false) String auctionTimeExt,
			ModelMap modelMap, HttpSession session) {
		Users user = (Users) session.getAttribute(CommonConstants.USER_INFO);
		Long auctionId = null;
		if (auctionIdStr != null && !auctionIdStr.equals("")) {
			auctionId = Long.parseLong(auctionIdStr);
		}
		if (auctionId == null || !commonService.isValidAuction(auctionId)) {
			// httpServletRequest.setAttribute("NoAuctionPresent",
			// NO_AUCTION_PRESENT);
			String msg = "Auction Not Present - " + auctionId;
			return "redirect:/admin/superAdmin?Message=" + msg;
		}
		/*
		 * Auction auction =
		 * commonService.isAnyRunningAuction(user.getUserId()); if (auction !=
		 * null) { if (auction.getStatus().equalsIgnoreCase("Running")) { String
		 * msg =
		 * "At current Time there is already a auction is running. So Please wait till the auction Ends"
		 * ; return "redirect:/admin/superAdmin?Message=" + msg; } }
		 */
		// KilimEngineGenerator.getAuctioneer().stopAuction();
		// RedisCacheService.flushDB();
		RedisCacheService.setAuctionId(auctionId.toString(), user.getUserId());
		// KilimEngineGenerator.getAuctioneer().restart();
		BidItemsCacheService bidItemsCacheService = (BidItemsCacheService) ObjectRegistry
				.getInstance().getObject(BidItemsCacheService.class.getName());
		/* bidItemsCacheService.setAuctionId(auctionId); */
		bidItemsCacheService.clientAuctionMap.put(user.getUserId(), auctionId);
		try {
			if (auctionStart != null && auctionStart.length() > 0) {
				SimpleDateFormat sdf = new SimpleDateFormat(DD_MM_YYYY_HH_MM_SS);
				Date actualAuctionStartTime = sdf.parse(auctionStart);
				// bidItemsCacheService.setAuctionStartTime(actualAuctionStartTime);
				bidItemsCacheService.auctionStartTimeMap.put(user.getUserId(),
						actualAuctionStartTime);
				commonService.setActualAuctionStartTime(auctionId,
						actualAuctionStartTime);
			} else if (auctionTimeExt != null && auctionTimeExt.length() > 0) {
				Calendar cal = Calendar.getInstance();
				int time = Integer.parseInt(auctionTimeExt);
				cal.add(Calendar.MINUTE, time + 1);
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

		} catch (ParseException e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			throw new RuntimeException(e.getMessage());
		}
		bidItemsCacheService.initCache(user.getUserId());
		bidConsumerEngine.startAuctionBidConsumerThread(auctionId);
		String msg = "Auction Started - " + auctionId;
		return "redirect:/admin/superAdmin?Message=" + msg;
	}

	@RequestMapping(value = "/resetPasswordPage")
	public String resetPasswordPage(HttpServletRequest httpServletRequest) {
		return "resetPasswordHome";
	}

	@RequestMapping(value = "/resetPassword")
	public String resetPasswordForUser(
			@RequestParam(value = "password", required = true) String password,
			@RequestParam(value = "username", required = true) String userName,
			ModelMap modelMap, HttpServletRequest httpServletRequest) {

		boolean userExistsStatus = commonService.checkIfUserExists(userName);
		if (userExistsStatus) {
			commonService.updateUserPassword(userName, password);
			modelMap.addAttribute("resetPasswordMessage",
					"Password Reset successful.");
		} else {
			modelMap.addAttribute("resetPasswordMessage",
					"Please enter a valid User Id.");
		}
		return "resetPasswordHome";
	}

	@RequestMapping(value = "/closeAuction", method = RequestMethod.GET)
	public String closeAuction(
			@RequestParam(value = "auctionId", required = true) Long auctionId,
			ModelMap modelMap, HttpServletRequest httpServletRequest) {
		// String strAuctionId = RedisCacheService.getAuctionId();
		// if(strAuctionId==null)
		// {
		// httpServletRequest.setAttribute("NoAuctionPresent",
		// NO_AUCTION_PRESENT);
		// return "admin/initcache";
		// } else {
		// Long auctionId = new Long(strAuctionId);
		HttpSession session = httpServletRequest.getSession();
		Users user = (Users) session.getAttribute(CommonConstants.USER_INFO);
		String msg = null;
		try {
			commonService.closeAuction(auctionId);
			msg = "Auction Closed - " + auctionId;
			httpServletRequest.setAttribute("SuccessMessage", "Auction Closed");
			// KilimEngineGenerator.getAuctioneer().stopAuction();
			// RedisCacheService.flushDB();
		} catch (Exception e) {
			e.printStackTrace();
			msg = "Auction Could not be Closed - " + auctionId;
		}
		return "redirect:/admin/superAdmin?Message=" + msg;
		// }

	}

	@RequestMapping(value = "/userauctionmap", method = RequestMethod.GET)
	public String getUserAuctionMap(ModelMap modelMap, HttpSession session) {
		Users user = (Users) session.getAttribute(CommonConstants.USER_INFO);
		if (user == null) {
			return "redirect:/login";
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
		logger.debug("newAuctionList" + newAuctionList);
		modelMap.addAttribute("AuctionList", newAuctionList);
		modelMap.addAttribute("UserList",
				commonService.getActiveBidders(user.getUserId()));
		modelMap.addAttribute("CategoryList",
				commonService.getCategoryList(user.getUserId()));
		return "userauctionmap";
	}

	@RequestMapping(value = "/auctionmapping", method = RequestMethod.POST)
	public String setUserAuctionMap(
			@RequestParam(value = "selectedAuctionId", required = true) Long selectedAuctionId,
			@RequestParam(value = "selectedCategoryIdList", required = true) String selectedCategoryIdList,
			@RequestParam(value = "selectedUserIdList", required = true) String selectedUserIdList) {
		String msg = null;
		try {
			logger.debug("selectedAuctionId: " + selectedAuctionId);
			logger.debug("selectedCategoryIdList: " + selectedCategoryIdList);
			logger.debug("selectedUserIdList: " + selectedUserIdList);
			commonService.setUserAuctionMap(selectedAuctionId,
					selectedCategoryIdList, selectedUserIdList);
			msg = "All selected Users are now allowed for the auction "
					+ selectedAuctionId;
		} catch (Exception e) {
			e.printStackTrace();
			msg = "Mapping Not successful";
		}
		return "redirect:/admin/userauctionmap?Message=" + msg;
	}

}