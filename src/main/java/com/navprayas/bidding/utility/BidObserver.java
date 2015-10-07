package com.navprayas.bidding.utility;

import java.util.Observable;
import java.util.Observer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.BidItemsCacheService;
import com.navprayas.bidding.common.service.IBidItemsCacheService;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.engine.orm.Bid;

public class BidObserver implements Observer {

	private static final Logger logger = LoggerFactory
			.getLogger(BidObserver.class);
	@Autowired
	@Qualifier("bidItemsCacheService")
	private IBidItemsCacheService bidItemsCacheService;
	@Autowired
	private ICommonService commonService;

	private static BidObserver _instance;

	/**
	 * @return the bidItemsCacheService
	 */
	public IBidItemsCacheService getBidItemsCacheService() {
		return bidItemsCacheService;
	}

	/**
	 * @param bidItemsCacheService
	 *            the bidItemsCacheService to set
	 */
	public void setBidItemsCacheService(
			IBidItemsCacheService bidItemsCacheService) {
		this.bidItemsCacheService = bidItemsCacheService;
	}

	private BidObserver() {
		super();
	}

	public static synchronized BidObserver getInstance() {
		if (null == _instance) {
			_instance = new BidObserver();
			BidItemsCacheService bidItemsCacheService = (BidItemsCacheService) ObjectRegistry
					.getInstance().getObject(
							BidItemsCacheService.class.getName());
			_instance.setBidItemsCacheService(bidItemsCacheService);
		}
		return _instance;
	}

	public void update(Observable publisher, Object o) {

		try {
			Bid bid = ((BidPublisher) publisher).getBids().get(((Long) o));

			logger.debug("In Bid Observer: " + bid);
			String bidderName = bid.getBidderName();
			Users user = commonService.getUserForUsername(bidderName);
			BidItem bidItem = bidItemsCacheService.getBidItem(bid.getBidItemId(),
					bidItemsCacheService.getAuctionId(user.getParentId()),
					user.getParentId());
			bidItem.setCurrentMarketPrice(bid.getBidAmount());
			bidItemsCacheService.setBidItem(bidItem, user.getParentId());
			logger.debug("In Bid Observer: " + bidItem);
			// update Bid End Time

			logger.debug("Calling Comet Pusher " + bidItem);
			CometPusher.getInstance().setBidDisplay(bidItem, bidderName);
		} catch (Exception e) {
			logger.debug(e.getMessage(), e);
			e.printStackTrace();
		}
	}
}
