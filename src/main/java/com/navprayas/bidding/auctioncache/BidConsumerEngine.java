package com.navprayas.bidding.auctioncache;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.navprayas.bidding.engine.core.BidPublisher;
import com.navprayas.bidding.utility.BidObserver;

/**
 * This class will start the consumers after initializing them.
 * 
 * @author cfeindia
 * 
 */
@Component("bidConsumerEngine")
public class BidConsumerEngine {

	@Autowired
	@Qualifier("uiBidItemQueue")
	private IBidItemQueue uiBidItemQueue;

	@Autowired
	@Qualifier("processedBidItemQueue")
	private IBidItemQueue processedBidItemQueue;

	@Autowired
	private BidPersister bidPersister;

	private ScheduledExecutorService schedule = Executors
			.newScheduledThreadPool(10);

	// @Value("auction.biditems.process.maxsize")
	private Integer maxItemToProcess = 200;

	public void startAuctionBidConsumerThread(final Long auctionId) {
		uiBidItemQueue.initializeBidItemQueue(auctionId, false);
		processedBidItemQueue.initializeBidItemQueue(auctionId, false);
		schedule.schedule(
				new Consumer(uiBidItemQueue.getBidItemQueue(auctionId),
						schedule, maxItemToProcess, processedBidItemQueue
								.getBidItemQueue(auctionId)), 100,
				TimeUnit.MILLISECONDS);
		schedule.schedule(
				new TaskConsumer(processedBidItemQueue
						.getBidItemQueue(auctionId), schedule, bidPersister),
				1, TimeUnit.MINUTES);
		BidPublisher.getInstance().addObserver(BidObserver.getInstance());
		System.out.println("size "
				+ BidPublisher.getInstance().countObservers());
	}
}
