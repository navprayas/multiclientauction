package com.navprayas.bidding.webservices.controller;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.navprayas.bidding.common.constant.CommonConstants;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.webservices.dtos.LoginDto;
import com.navprayas.bidding.webservices.dtos.ResponseDto;
import com.navprayas.bidding.webservices.services.UserLoginService;

/**
 * This Is Login Web service
 */
@Controller
@RequestMapping("/webservices/**")
class LoginWebserviceController {
	Logger logger = org.slf4j.LoggerFactory.getLogger(LoginWebserviceController.class);
	@Autowired
	private UserLoginService userLoginService;

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public String getLoginUser(@RequestBody String body, HttpServletResponse response, HttpSession session) {
		ObjectMapper mapper = new ObjectMapper();
		UUID uuid = null;
		ResponseDto responseDto = null;
		String result = null;
		try {

			LoginDto loginDto = mapper.readValue(body, LoginDto.class);

			Users user = userLoginService.validateUser(loginDto.getUserName(), loginDto.getPassword());
			responseDto = new ResponseDto();
			if (user != null) {

				uuid = UUID.randomUUID();
				responseDto.setStatus(CommonConstants.SUCCESS);
				responseDto.setUserId(user.getUserId());
				responseDto.setUserName(user.getUsername());
				responseDto.setToken(uuid.toString());
				session.setAttribute(CommonConstants.USER_INFO, user);

			} else {
				responseDto.setStatus(CommonConstants.FAILURE);
			}
			result = mapper.writeValueAsString(responseDto);
			response.addHeader("Access-Control-Allow-Origin", "*");
		} catch (IOException e) {
			logger.error("Error occured" + e);
			e.printStackTrace();
		}
		return result;
	}

}
