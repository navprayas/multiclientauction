package com.navprayas.bidding.fileupload.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.navprayas.bidding.common.constant.CommonConstants;
import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.fileupload.entity.BidItemEntity;
import com.navprayas.bidding.fileupload.service.FileUploadService;

@Controller
@RequestMapping("/admin/**")
public class FileUploadController {

	@Autowired
	private FileUploadService fileUploadService;

	@Autowired
	@Qualifier("commonService")
	private ICommonService commonService;

	@RequestMapping(value = "/FileUpload")
	public String registrationPageForUser(ModelMap modelMap, HttpSession session) {
		Users user = (Users) session.getAttribute(CommonConstants.USER_INFO);
		List<Auction> auctionList = commonService.getAuctionListForAction(user
				.getUserId());
		List<Auction> newAuctionList = new ArrayList<Auction>();
		for (Auction auction : auctionList) {
			if ("Start".equalsIgnoreCase(auction.getStatus())
					|| "Running".equalsIgnoreCase(auction.getStatus())) {
				newAuctionList.add(auction);
			}
		}
		modelMap.addAttribute("AuctionList", newAuctionList);
		return "fileupload";
	}

	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public String saveData(
			@ModelAttribute BidItemEntity bidItemEntity,
			@RequestParam(value = "auctionId", required = false) Long auctionId,
			ModelMap modelMap, HttpSession session) throws IOException,
			ClassNotFoundException, SQLException, ParseException,
			NullPointerException {
		Users user = (Users) session.getAttribute(CommonConstants.USER_INFO);
		String message = "File Upload Successfully";
		try {
			fileUploadService.saveAuctionData(bidItemEntity, auctionId,
					user.getUserId());
			List<Auction> auctionList = commonService
					.getAuctionListForAction(user.getUserId());
			List<Auction> newAuctionList = new ArrayList<Auction>();
			for (Auction auction : auctionList) {
				if ("Start".equalsIgnoreCase(auction.getStatus())
						|| "Running".equalsIgnoreCase(auction.getStatus())) {
					newAuctionList.add(auction);
				}
			}
			
			modelMap.addAttribute("AuctionList", newAuctionList);
		} catch (Exception e) {
			e.printStackTrace();
			message = "File Not Upload";
		}
		modelMap.addAttribute("messages", message);
		return "fileupload";
	}

	@RequestMapping(value = "/downloadfile", method = RequestMethod.GET)
	public String downloadFile(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setHeader("Content-Disposition",
				"attachment; filename=\"Auction_Templates.xls");
		ServletContext context = request.getSession().getServletContext();
		// System.out.println("path"+context.getRealPath("excel/Auction_Item_Template.xls"));
		response.setContentType("application/msexcel");
		FileInputStream fin;

		fin = new FileInputStream(
				context.getRealPath("excel/Auction_Item_Template.xls"));

		byte b[] = new byte[fin.available()];
		fin.read(b);
		ServletOutputStream out = response.getOutputStream();
		out.write(b);
		out.close();
		fin.close();

		return null;
	}

}
