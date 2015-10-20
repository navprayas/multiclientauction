package com.navprayas.bidding.auctioncache;

import java.util.Map;
import java.util.concurrent.BlockingDeque;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ScheduledExecutorService;

import com.navprayas.bidding.engine.orm.Bid;

public class SingletonBid {
	private BlockingDeque<Bid> queue = new LinkedBlockingDeque<Bid>(1000);
	private BlockingDeque<Bid> processedQueue = new LinkedBlockingDeque<Bid>();
	private Map<Long, Bid> maxBidMap = new ConcurrentHashMap<Long, Bid>();
	private ScheduledExecutorService consumer = Executors.newScheduledThreadPool(10);
	private ExecutorService taskConsumerService = Executors.newCachedThreadPool();

	public BlockingDeque<Bid> getQueue() {
		return queue;
	}

	private static final SingletonBid instance = new SingletonBid();

	// TODO: Which Queue implementation is better, find out later, but right now
	// just test the functionality.
	// TODO: Decide after testing, which thread pool to use, but for
	// functionality testing , it should be OK.
	// This instance should be available when any of the auction starts,
	// in fact it will be executed when class is loaded.
	// TODO:change this getInstance method so that it is best way to create
	// singleton, try Enum
	public static SingletonBid getInstance() {
		return instance;
	}

	public Map<Long, Bid> getMaxBidMap() {

		return maxBidMap;
	}

	public ScheduledExecutorService getConsumer() {

		return consumer;
	}

	public BlockingDeque<Bid> getProcessedQueue() {
		return processedQueue;
	}

	public ExecutorService getTaskConsumerService() {
		return taskConsumerService;
	}


}
