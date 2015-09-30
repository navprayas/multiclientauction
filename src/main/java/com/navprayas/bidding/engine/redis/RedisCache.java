package com.navprayas.bidding.engine.redis;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutput;
import java.io.ObjectOutputStream;
import java.text.SimpleDateFormat;
import java.util.Set;

import redis.clients.jedis.Jedis;

import com.navprayas.bidding.engine.common.AutoBid;
import com.navprayas.bidding.engine.common.Bid;
import com.navprayas.bidding.engine.common.BidItem;

public class  RedisCache  {
	private static Redis redis;
	public static SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmssZ");

	public static void saveSuccessBid(Bid bid) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();
			jedis.hset("BIDITEM::" + bid.getBidItemId(), "currentAutoBidId",
					String.valueOf(bid.getBidderId()));
			jedis.hset("BIDITEM::" + bid.getBidItemId(), "auctionId",
					String.valueOf(bid.getAuctionId()));
			jedis.hset("BIDITEM::" + bid.getBidItemId(), "currentMarketPrice",
					String.valueOf(bid.bidAmount));
			jedis.hset("BIDITEM::" + bid.getBidItemId(), "currency",
					String.valueOf(bid.getCurrency()));
			jedis.hset("BIDITEM::" + bid.getBidItemId(), "bidTime",
					sdf.format(bid.getBidTime()));
			jedis.hset("BIDITEM::" + bid.getBidItemId(), "lastUpDateTime",
					sdf.format(bid.getBidTime()));
			jedis.hset("BIDITEM::" + bid.getBidItemId(), "statusCode",
					bid.getStatus());
			jedis.hset("BID::BIDITEM::" + bid.getBidItemId(), "bidderId",
					String.valueOf(bid.getBidderId()));
			jedis.hset("BID::BIDITEM::" + bid.getBidItemId(), "bidderName",
					bid.getBidderName());
			jedis.hset("BIDITEM::" + bid.getBidItemId(), "isAutoBid",
					bid.getBidType() == 2 ? "true" : "false");
			jedis.hset("BIDDER::" + bid.getBidItemId() + "::" + bid.bidderName,
					"autoBid", bid.getBidType() == 2 ? "true" : "false");
			jedis.hset("BIDITEM::" + bid.getBidItemId(), "autoBidAmount",
					String.valueOf(bid.getAutoBidAmount()));
			if (bid.bidType == 2) {
				jedis.hset("BIDITEM::" + bid.getBidItemId(), "autoBidderName",
						bid.getBidderName());
			}
		} catch (Exception e) {
			System.out.println("FAILED TO STORE BIDITEM SUCCESS: "
					+ e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);
	}

	public static void addBidder(long bidItemId, String bidderName,
			boolean isAutoBid, double bidAmount) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();
			String key = "BIDDER::" + bidItemId + "::";
			jedis.sadd("::BIDDERS::" + bidItemId, bidderName);
			jedis.hset(key + bidderName, "bidderName", bidderName);
			jedis.hset(key + bidderName, "autoBid", String.valueOf(isAutoBid));
			jedis.hset(key + bidderName, "bidAmount", String.valueOf(bidAmount));
		} catch (Exception e) {
			System.out.println("FAILED TO STORE BIDDER FOR BIDITEM: "
					+ e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);
	}

	public static BidItem getBidItem(long bidItemId) {
		System.out.println("BidItem Overloadin");
		Jedis jedis = null;
		BidItem bidItem = null;
		String s = null;
		try {
			jedis = redis.connect();
			s = jedis.hget("BIDITEM::" + bidItemId, "bidItemId");
			bidItem = new BidItem(Long.parseLong(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "minBidPrice");
			bidItem.setMinBidPrice((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? 0.0D : Double.parseDouble(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "minBidIncrement");
			bidItem.setMinBidIncrement((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? 0.0D : Double.parseDouble(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "bidStartTime");
			bidItem.setBidStartTime((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? null : sdf.parse(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "bidEndTime");
			bidItem.setBidEndTime((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? null : sdf.parse(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "timeExtAfterBid");
			bidItem.setTimeExtAfterBid((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? 0 : Integer.parseInt(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "statusCode");
			bidItem.setStatusCode(s);
			s = jedis.hget("BIDITEM::" + bidItemId, "currency");
			bidItem.setCurrency(s);
			s = jedis.hget("BIDITEM::" + bidItemId, "auctionId");
			bidItem.setAuctionId((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? 0L : Long.parseLong(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "autoBidderName");
			bidItem.setAutoBidderName(s);
			s = jedis.hget("BIDITEM::" + bidItemId, "bidderId");
			bidItem.setAutoBidderId((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? 0L : Long.parseLong(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "isAutoBid");
			bidItem.setAutoBidFlag(Boolean.parseBoolean(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "autoBidAmount");
			bidItem.setAutoBidAmount((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? 0.0D : Double.parseDouble(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "lastUpDateTime");
			bidItem.setLastUpdateTime((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? null : sdf.parse(s));

			bidItem.setBid(getBid(bidItemId));
		} catch (Exception e) {
			System.out.println("FAILED TO GET BIDITEM: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);
		return bidItem;
	}

	public static void setBidItem(BidItem bidItem) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();
			jedis.sadd("::BIDITEMS::", String.valueOf(bidItem.getBidItemId()));
			jedis.hset("BIDITEM::" + bidItem.getBidItemId(), "bidItemId",
					String.valueOf(bidItem.getBidItemId()));
			jedis.hset("BIDITEM::" + bidItem.getBidItemId(), "statusCode",
					bidItem.getStatusCode());
			jedis.hset("BIDITEM::" + bidItem.getBidItemId(), "autoBidderName",
					bidItem.getAutoBidderName());
			jedis.hset("BIDITEM::" + bidItem.getBidItemId(), "isAutoBid",
					String.valueOf(bidItem.isAutoBidFlag()));
			jedis.hset("BIDITEM::" + bidItem.getBidItemId(), "autoBidAmount",
					String.valueOf(bidItem.getAutoBidAmount()));
			jedis.hset("BIDITEM::" + bidItem.getBidItemId(), "bidderId",
					String.valueOf(bidItem.getAutoBidderId()));
			jedis.hset("BIDITEM::" + bidItem.getBidItemId(), "lastUpDateTime",
					sdf.format(bidItem.getLastUpdateTime()));
			jedis.hset("BIDITEM::" + bidItem.getBidItemId(), "bidEndTime",
					sdf.format(bidItem.getBidEndTime()));
		} catch (Exception e) {
			System.out.println("FAILED TO SET BIDITEM: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);
	}

	public static Bid getBid(long bidItemId) {
		Jedis jedis = null;
		String s = null;
		Bid bid = null;
		try {
			jedis = redis.connect();
			bid = new Bid(bidItemId);
			s = jedis.hget("BIDITEM::" + bidItemId, "bidItemId");
			bid.setBidItemId((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? 0L : Long.parseLong(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "currentAutoBidId");
			bid.setBidId((s == null) || (s.equals("null")) || (s.length() == 0) ? 0L
					: Long.parseLong(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "auctionId");
			bid.setAuctionId((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? 0L : Long.parseLong(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "currentMarketPrice");
			bid.setBidAmount((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? 0.0D : Double.parseDouble(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "currency");
			bid.setCurrency(s);
			s = jedis.hget("BIDITEM::" + bidItemId, "bidTime");
			bid.setBidTime((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? null : sdf.parse(s));
			s = jedis.hget("BIDITEM::" + bidItemId, "statusCode");
			bid.setStatus(s);
			s = jedis.hget("BID::BIDITEM::" + bidItemId, "bidderId");
			bid.setStatus(s);
			s = jedis.hget("BID::BIDITEM::" + bidItemId, "bidderName");
			bid.setBidderName(s);
			s = jedis.hget("BIDITEM::" + bidItemId, "isAutoBid");
			bid.setBidType(s.equals("true") ? 2 : (s == null)
					|| (s.equals("null")) || (s.length() == 0) ? 1 : 1);
			if ((s != null) && (s.equals("true"))) {
				bid.setBidderName(jedis.hget("BIDITEM::" + bidItemId,
						"autoBidderName"));
			}
			s = jedis.hget("BIDITEM::" + bidItemId, "autoBidAmount");
			bid.setAutoBidAmount((s == null) || (s.equals("null"))
					|| (s.length() == 0) ? 0.0D : Double.parseDouble(s));
			return bid;
		} catch (Exception e) {
			System.out.println("FAILED TO GET BID: " + e.getMessage());
			e.printStackTrace();

			redis.close(jedis);
		}
		return null;
	}

	public static boolean bidItemExists(BidItem bidItem) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();
			return jedis.sismember("::BIDITEMS::",
					String.valueOf(bidItem.getBidItemId())).booleanValue();
		} catch (Exception e) {
			System.out.println("FAILED TO CHECK BIDITEM IN CACHE: "
					+ e.getMessage());
			e.printStackTrace();

			redis.close(jedis);
		}
		return false;
	}

	public static void saveAutoBid(String key, Bid bid) {
		ByteArrayOutputStream bos = new ByteArrayOutputStream();

		Jedis jedis = null;
		AutoBid autoBid = new AutoBid();
		autoBid.setAuctionId(bid.getAuctionId());

		autoBid.setBidAmount(bid.getAutoBidAmount());
		autoBid.setBidderId(bid.getBidderId());
		autoBid.setBidderName(bid.getBidderName());
		autoBid.setBidItemId(bid.getBidItemId());
		autoBid.setBidTime(bid.getBidTime());
		autoBid.setComments(bid.getComments());
		autoBid.setCurrency(bid.getCurrency());
		autoBid.setVersion(bid.getVersion());
		autoBid.setStatus("A");
		try {
			jedis = redis.connect();
			ObjectOutput out = new ObjectOutputStream(bos);
			autoBid.setBidId(jedis.incr("::AUTOBIDID::").longValue());
			out.writeObject(autoBid);
			out.close();
			jedis.lpush(key.getBytes(), bos.toByteArray());
		} catch (IOException e) {
			redis.close(jedis);
			System.out.println("FAILED TO STORE AUTO BID IN REDIS");
			System.out.println("FAILED AUTO BID: " + bid);
			e.printStackTrace();
		} catch (Exception e) {
			redis.close(jedis);
			System.out.println("FAILED TO STORE AUTO BID IN REDIS");
			System.out.println("FAILED AUTO BID: " + bid);
			e.printStackTrace();
		}
	}

	public static void saveBid(String key, Bid bid) {
		ByteArrayOutputStream bos = new ByteArrayOutputStream();

		Jedis jedis = null;
		try {
			jedis = redis.connect();
			ObjectOutput out = new ObjectOutputStream(bos);
			bid.setBidId(jedis.incr("::BIDID::").longValue());
			out.writeObject(bid);
			out.close();
			jedis.lpush(key.getBytes(), bos.toByteArray());
		} catch (IOException e) {
			redis.close(jedis);
			System.out.println("FAILED TO STORE BID IN REDIS");
			System.out.println("FAILED BID: " + bid);
			e.printStackTrace();
		} catch (Exception e) {
			redis.close(jedis);
			System.out.println("FAILED TO STORE BID IN REDIS");
			System.out.println("FAILED BID: " + bid);
			e.printStackTrace();
		}
	}

	public static Set<String> getExpiredBids() {
		Jedis jedis = null;
		Set<String> set = null;
		try {
			jedis = redis.connect();
			set = jedis.smembers("::EXPIRED::BIDITEMS::");
		} catch (Exception e) {
			System.out.println("FAILED TO GET EXPIRED BIDS LIST ");
			e.printStackTrace();
		}
		redis.close(jedis);
		return set;
	}

	public static void cleanBidItem() {
		Jedis jedis = null;
		try {
			jedis = redis.connect();
			Set<String> bidItems = getExpiredBids();
			for (String bidItemId : bidItems) {
				Set<String> bidders = jedis.smembers("::BIDDERS::" + bidItemId);
				String key = "BIDDER::" + bidItemId + "::";
				for (String bidder : bidders) {
					jedis.del(new String[] { key + bidder });
				}
				jedis.del(new String[] { "::BIDDERS::" + bidItemId });
				jedis.del(new String[] { "BIDITEM::" + bidItemId });
				jedis.srem("::BIDITEMS::", bidItemId);
				jedis.srem("::EXPIRED::BIDITEMS::", bidItemId);
			}
		} catch (Exception e) {
			System.out.println("FAILED TO CLEAN EXPIRED BIDS LIST ");
			e.printStackTrace();
		}
		redis.close(jedis);
	}
}
