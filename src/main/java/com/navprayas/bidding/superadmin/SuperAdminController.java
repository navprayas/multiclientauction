package com.navprayas.bidding.superadmin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.navprayas.bidding.common.constant.CommonConstants;
import com.navprayas.bidding.common.form.Authorities;
import com.navprayas.bidding.common.form.UserDetails;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.form.UsersForm;
import com.navprayas.bidding.common.service.ICommonService;

@RequestMapping("/superadmin/**")
@Controller
public class SuperAdminController {
	@Autowired
	@Qualifier("commonService")
	private ICommonService commonService;

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String getAdmins(ModelMap modelMap, HttpSession session) {
		Users user = (Users) session.getAttribute(CommonConstants.USER_INFO);
		List<Users> adminsList = commonService.getAdminList(user.getUserId());
		modelMap.addAttribute("userlist", adminsList);

		return "superadminhome";
	}

	@RequestMapping(value = "/registeradmin", method = RequestMethod.GET)
	public String getSuperAdminHome(ModelMap modelMap,
			HttpServletRequest httpServletRequest) {
		return "registeradmin";
	}

	@RequestMapping(value = "/registration")
	public String registerUser(ModelMap modelMap, UsersForm usersForm,
			HttpSession session) {
		Users user = (Users) session.getAttribute(CommonConstants.USER_INFO);
		Users users = new Users();
		users.setUsername(usersForm.getUsername());
		users.setPassword(usersForm.getPassword());
		users.setEnabled(true);
		users.setEmail(usersForm.getEmail());
		users.setParentId(user.getUserId());

		String role = usersForm.getRole();
		Authorities authorities = new Authorities();
		authorities.setUsername(usersForm.getUsername());
		authorities.setAuthority(role);

		UserDetails userDetails = new UserDetails();
		String lastName = usersForm.getLastName();
		String middleName = usersForm.getMiddleName();

		userDetails.setFirstName(usersForm.getFirstName());
		// userDetails.setDateofbirth(usersForm.getDateofbirth());
		if (lastName != null) {
			userDetails.setLastName(lastName);
		}
		if (middleName != null) {
			userDetails.setMiddleName(middleName);
		}

		String status = commonService.saveUser(users, authorities, userDetails);

		StringBuilder strMessage = new StringBuilder(
				"redirect:/admin/registrationPage?registrationMessage=");
		if (status != null && "success".equals(status)) {
			strMessage.append("User Registered successfully.");

		} else {
			strMessage
					.append("User Registration failed. Please try again later.");
		}
		return strMessage.toString();
	}

	@RequestMapping(value = "/useractivedeactive", method = RequestMethod.GET)
	public String activateDeactivateAdmin(@RequestParam Long userId,
			@RequestParam int status, ModelMap modelMap, HttpSession session) {
		System.out.println("userId" + userId);
		System.out.println("userId" + status);
		if (status == 1) {
			status = 0;
		} else {
			status = 1;
		}
		commonService.activeDeactiveUser(userId, status);
		Users user = (Users) session.getAttribute(CommonConstants.USER_INFO);
		List<Users> adminsList = commonService.getAdminList(user.getUserId());
		modelMap.addAttribute("userlist", adminsList);
		return "superadminhome";
	}

	@RequestMapping(value = "/resetPasswordPage")
	public String resetPasswordPage(HttpServletRequest httpServletRequest) {
		return "resetpasswordsuperadmin";
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
		return "resetpasswordsuperadmin";
	}

}
