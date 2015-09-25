package com.navprayas.bidding.utility;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class RedisCacheDataBaseFlushListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("context Initialized");
		RedisCacheService.flushDB();
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("context destroyed");
		RedisCacheService.flushDB();

	}

}
