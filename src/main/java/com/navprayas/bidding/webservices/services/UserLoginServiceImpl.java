package com.navprayas.bidding.webservices.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.webservices.daos.UserLoginDao;

@Service
@Transactional
public class UserLoginServiceImpl implements UserLoginService {
	@Autowired
	private UserLoginDao userLoginDao;

	@Override
	public Users validateUser(String userName, String password) {
		
		return userLoginDao.validateUser(userName, password);
	}

}
