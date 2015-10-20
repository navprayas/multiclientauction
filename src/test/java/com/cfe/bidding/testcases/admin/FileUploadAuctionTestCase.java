package com.cfe.bidding.testcases.admin;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

import junit.framework.TestCase;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.fileupload.entity.BidItemEntity;
import com.navprayas.bidding.fileupload.service.FileUploadService;

public class FileUploadAuctionTestCase extends TestCase {
	ApplicationContext context;
	private final static Logger logger = LoggerFactory
			.getLogger(FileUploadAuctionTestCase.class);
	private ICommonService commonService;
	private FileUploadService fileUploadService;

	public void setUp() {
		context = new ClassPathXmlApplicationContext("bidding-servlet.xml");
		System.out.println(context);
		commonService = (ICommonService) context.getBean("commonService");

		fileUploadService = (FileUploadService) context
				.getBean("fileUploadServiceImp");

	}
	public void testFileUploadAuction() {
		BidItemEntity bidItemEntity=new  BidItemEntity();
		Users user = commonService.getUserForUsername("admin1");
		String message = "File Upload Successfully";
		try {
			File file = new File(
					"/home/cfeindia/Desktop/Auction_Item_TemplateItems.xls");
			FileInputStream input = new FileInputStream(file);
			MultipartFile multipartFile = new MockMultipartFile("file",
					file.getName(), "text/plain", IOUtils.toByteArray(input));
			
			bidItemEntity.setFile(multipartFile);
			fileUploadService.saveAuctionData(bidItemEntity, -1l,
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

			System.out.println("AuctionList" + newAuctionList);
		} catch (Exception e) {
			e.printStackTrace();
			message = "File Not Upload";
		}
		System.out.println("messages" + message);

	}
}
