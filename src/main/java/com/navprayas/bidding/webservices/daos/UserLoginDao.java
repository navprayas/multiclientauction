package com.navprayas.bidding.webservices.daos;

import com.navprayas.bidding.common.form.Users;

public interface UserLoginDao {
	public Users validateUser(String userName, String password);
}
