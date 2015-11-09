package com.navprayas.bidding.webservices.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.navprayas.bidding.webservices.services.BidItemsService;
import com.navprayas.bidding.webservices.services.CategoryService;

/**
 * Category Controller
 */
@Controller
@RequestMapping("/webservices/**")
public class CategoryController {
	Logger log = LoggerFactory.getLogger(CategoryController.class);
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BidItemsService bidItemsService;

	@RequestMapping(value = "/allcategory")
	@ResponseBody
	public String getAllCategory(HttpServletResponse response, HttpSession session) {
		String result = null;
		ObjectMapper mapper = new ObjectMapper();

		try {

			result = mapper.writeValueAsString(categoryService.getAllCategory());

		} catch (IOException e) {
			log.error("Error occured" + e);
			e.printStackTrace();
		}
		response.addHeader("Access-Control-Allow-Origin", "*");
		return result;
	}

	/**
	 * This method loading images for particular category
	 * 
	 * @param categoryId
	 * @return
	 */
	@RequestMapping(value = "/category/{categoryId}")
	@ResponseBody
	public String getCategoryItems(@PathVariable Long categoryId, HttpServletResponse response) {
		String result = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			;
			result = mapper.writeValueAsString(bidItemsService.getBidItemsList(categoryId));

		} catch (IOException e) {
			log.debug("Object conveted to json  error" + e.getMessage());
			e.printStackTrace();
		}
		log.debug("");
		response.addHeader("Access-Control-Allow-Origin", "*");
		return result;
	}

}
