package com.navprayas.bidding.auctioncache;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.BlockingDeque;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.navprayas.bidding.engine.orm.Bid;

public class TaskConsumer implements Runnable {
	private static final int MAX_BID_ITEM_PROCESSED = 500;
	private final static Logger logger = LoggerFactory
			.getLogger(TaskConsumer.class);
	private BlockingDeque<Bid> processedbidItemQueue;
	private final ScheduledExecutorService schedule;
	private final BidPersister bidPersister;

	public TaskConsumer(final BlockingDeque<Bid> processedbidItemQueue,
			final ScheduledExecutorService schedule,
			final BidPersister bidPersister) {
		this.processedbidItemQueue = processedbidItemQueue;
		this.schedule = schedule;
		this.bidPersister = bidPersister;
	}

	@Override
	public void run() {
		final List<Bid> itemsList = new ArrayList<Bid>(MAX_BID_ITEM_PROCESSED);
		logger.debug("Task Consumer is called ");
		if (!processedbidItemQueue.isEmpty()) {
			logger.debug("processing items {}", processedbidItemQueue.size());
			processedbidItemQueue.drainTo(itemsList, MAX_BID_ITEM_PROCESSED);
			bidPersister.persist(itemsList);
			// Save Item List to DB through JDBC Template.
		}
		schedule.schedule(this, 30000, TimeUnit.MILLISECONDS);
	}
}
