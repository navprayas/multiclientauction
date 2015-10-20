package com.navprayas.bidding.auctioncache;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.BlockingDeque;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.navprayas.bidding.engine.orm.Bid;

public class Consumer implements Runnable {
	private final static Logger logger = LoggerFactory
			.getLogger(Consumer.class);

	private final BlockingDeque<Bid> bidItemQueue;
	private final ScheduledExecutorService schedule;
	private final Integer maxItemToProcess;
	private final BlockingDeque<Bid> processedBidItemQueue;
	
	public Consumer(final BlockingDeque<Bid> bidItemQueue,
			final ScheduledExecutorService schedule,
			final Integer maxItemToProcess,
			final BlockingDeque<Bid> processedBidItemQueue) {
		this.bidItemQueue = bidItemQueue;
		this.schedule = schedule;
		this.maxItemToProcess = maxItemToProcess;
		this.processedBidItemQueue = processedBidItemQueue;
	}

	@Override
	public void run() {
		final List<Bid> itemsList = new ArrayList<Bid>(maxItemToProcess);
		if (!bidItemQueue.isEmpty()) {
			logger.debug("processing items {}", bidItemQueue.size());
			
			bidItemQueue.drainTo(itemsList, maxItemToProcess);
			processedBidItemQueue.addAll(itemsList);
			Bid firstBid = itemsList.get(0);
			for(Bid bid : itemsList) {
				if (bid.getBidAmount() > firstBid.getBidAmount()) {
					firstBid = bid;
				}
			}
			System.out.println("size " + BidPublisher.getInstance().countObservers());
			BidPublisher.getInstance().notifyBid(firstBid);
			
		}
		// Reschedule the the consumer thread for again..........
		schedule.schedule(this, 1000, TimeUnit.MILLISECONDS);
	}
}
