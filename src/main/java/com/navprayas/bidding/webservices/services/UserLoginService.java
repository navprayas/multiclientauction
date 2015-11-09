package com.navprayas.bidding.webservices.services;

import com.navprayas.bidding.common.form.Users;

public interface UserLoginService {

	public Users validateUser(String userName, String password);

}
