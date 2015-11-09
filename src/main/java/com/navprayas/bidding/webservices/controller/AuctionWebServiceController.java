package com.navprayas.bidding.webservices.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.navprayas.bidding.auction.service.AuctionService;
import com.navprayas.bidding.webservices.services.BidItemsService;

/**
 * Auction Webservice Controller
 */

@Controller
@RequestMapping("/webservices/**")
public class AuctionWebServiceController {

	Logger logger = LoggerFactory.getLogger(AuctionWebServiceController.class);
	@Autowired
	private BidItemsService bidItemsService;

	/**
	 * This Method is responding the result of auction List with images
	 * 
	 * @param categoryId
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/auction/{categoryId}", method = RequestMethod.GET)
	@ResponseBody
	public String getAuctionBidItem(@PathVariable Long categoryId, HttpServletResponse response) {
		String result = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			;
			result = mapper.writeValueAsString(bidItemsService.getBidItemsList(categoryId));

		} catch (IOException e) {
			logger.debug("Object conveted to json  error" + e.getMessage());
			e.printStackTrace();
		}
		
		response.addHeader("Access-Control-Allow-Origin", "*");
		return result;
	}

}
