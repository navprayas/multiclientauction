package com.navprayas.bidding.utility;

import java.text.SimpleDateFormat;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import redis.clients.jedis.Jedis;

import com.navprayas.bidding.auctioncache.AuctionCacheBean;
import com.navprayas.bidding.auctioncache.AuctionCacheManager;
import com.navprayas.bidding.common.bean.Bidder;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.common.form.Category;
import com.navprayas.bidding.engine.redis.RedisConstants;

/**
 * This Class Redis cache Service holding data into cache
 * 
 * @author cfeindia
 * 
 */
public class RedisCacheService {

	private static final Logger logger = LoggerFactory
			.getLogger(RedisCacheService.class);
	/* private static Redis redis = RedisImpl.getInstance(); */
	public static SimpleDateFormat sdf = new SimpleDateFormat(
			RedisConstants.DATESTRING);

	/*
	 * public static Jedis jedis; static { try { jedis = redis.connect(); }
	 * catch(Exception e) { logger.error("FAILED TO GET REDIS CONNECTION!!!!");
	 * } }
	 */

	public static void flushDB() {
		/*
		 * Jedis jedis = null; try { jedis = redis.connect(); jedis.flushAll();
		 * jedis.bgrewriteaof(); } catch (Exception e) {
		 * logger.error("FAILED TO FLUSH DB!!!"); } redis.close(jedis);
		 */
	}

	public static void setBidItemList(List<BidItem> bidItems, Long clientId) {

		for (BidItem item : bidItems) {
			setBidItem(
					RedisConstants.BIDITEM + item.getAuctionId()
							+ item.getBidItemId() + clientId, item, clientId);
		}
	}

	public static void setBidItem(String key, BidItem bidItem, Long clientId) {

		logger.debug("Set Bid item method is called");
		AuctionCacheBean auctionCacheBean = AuctionCacheManager
				.getActiveAuctionCacheBean(clientId);
		Map<Long, BidItem> itemMap = auctionCacheBean.getBidItemsMap();
		if (itemMap == null) {
			itemMap = new HashMap<Long, BidItem>();
		}

		// Jedis jedis = null;
		try {
			itemMap.put(bidItem.getBidItemId(), bidItem);

			setBidders(bidItem, clientId);
			setCategory(bidItem.getBidItemId(), bidItem.getCategory(), clientId);
			auctionCacheBean.setBidItemsMap(itemMap);

			/*
			 * jedis = redis.connect(); jedis.sadd(RedisConstants.BIDITEMS +
			 * clientId, String.valueOf(bidItem.getBidItemId())); //
			 * System.out.println
			 * ("Biditems getting after setting "+jedis.smembers
			 * (RedisConstants.BIDITEMS // + clientId));
			 * 
			 * jedis.hsetnx(key, RedisConstants.ATTR_BIDITEMID + clientId,
			 * String.valueOf(bidItem.getBidItemId())); jedis.hsetnx(key,
			 * RedisConstants.ATTR_NAME + clientId, (bidItem.getName() == null)
			 * ? "" : bidItem.getName()); jedis.hsetnx(key,
			 * RedisConstants.ATTR_LOCATION + clientId, (bidItem .getLocation()
			 * == null) ? "" : bidItem.getLocation()); jedis.hsetnx(key,
			 * RedisConstants.ATTR_CITY + clientId, (bidItem.getCity() == null)
			 * ? "" : bidItem.getCity()); jedis.hsetnx(key,
			 * RedisConstants.ATTR_ZONE + clientId, (bidItem.getZone() == null)
			 * ? "" : bidItem.getZone()); // jedis.hsetnx(key,
			 * RedisConstants.ATTR_VERSION, //
			 * String.valueOf(bidItem.getVersion())); jedis.hsetnx( key,
			 * RedisConstants.ATTR_MINBIDPRICE + clientId,
			 * (bidItem.getMinBidPrice() == null) ? "0" : String
			 * .valueOf(bidItem.getMinBidPrice())); jedis.hsetnx( key,
			 * RedisConstants.ATTR_MINBIDINCREMENT + clientId,
			 * (bidItem.getMinBidIncrement() == null) ? "0" : String
			 * .valueOf(bidItem.getMinBidIncrement())); jedis.hsetnx(key,
			 * RedisConstants.ATTR_BIDSTARTTIME + clientId,
			 * sdf.format(bidItem.getBidStartTime())); jedis.hsetnx( key,
			 * RedisConstants.ATTR_BIDENDTIME + clientId,
			 * (bidItem.getBidEndTime() != null) ? sdf.format(bidItem
			 * .getBidEndTime()) : ""); jedis.hsetnx(key,
			 * RedisConstants.ATTR_INITIALSTARTTIME + clientId,
			 * String.valueOf(bidItem.getInitialStartTime())); jedis.hsetnx(
			 * key, RedisConstants.ATTR_TIMEEXTAFTERBID + clientId,
			 * (bidItem.getTimeExtAfterBid() == null) ? "0" : String
			 * .valueOf(bidItem.getTimeExtAfterBid())); jedis.hsetnx(key,
			 * RedisConstants.ATTR_STATUSCODE + clientId,
			 * (bidItem.getStatusCode() != null) ? bidItem.getStatusCode() :
			 * ""); jedis.hsetnx( key, RedisConstants.ATTR_LASTUPDATETIME +
			 * clientId, (bidItem.getLastUpDateTime() != null) ?
			 * sdf.format(bidItem .getLastUpDateTime()) : ""); jedis.hsetnx(
			 * key, RedisConstants.ATTR_CREATEDTIME + clientId,
			 * (bidItem.getCreatedTime() != null) ? sdf.format(bidItem
			 * .getCreatedTime()) : ""); jedis.hsetnx( key,
			 * RedisConstants.ATTR_CURRENTMARKETPRICE + clientId,
			 * (bidItem.getCurrentMarketPrice() != null) ? String
			 * .valueOf(bidItem.getCurrentMarketPrice()) : "");
			 * jedis.hsetnx(key, RedisConstants.ATTR_ISAUTOBID + clientId,
			 * String.valueOf(bidItem.isAutoBidFlag())); jedis.hsetnx( key,
			 * RedisConstants.ATTR_AUTOBIDID + clientId, (bidItem.getAUTOBIDID()
			 * != null) ? String.valueOf(bidItem .getAUTOBIDID()) : "");
			 * jedis.hsetnx( key, RedisConstants.ATTR_AUTOBIDAMOUNT + clientId,
			 * (bidItem.getAmountAutoBid() != null) ? String
			 * .valueOf(bidItem.getAmountAutoBid()) : ""); jedis.hsetnx(key,
			 * RedisConstants.ATTR_CURRENCY + clientId, (bidItem .getCurrency()
			 * != null) ? bidItem.getCurrency() : ""); jedis.hsetnx(key,
			 * RedisConstants.ATTR_CATEGORYID + clientId, String
			 * .valueOf((bidItem.getCategory() != null) ? bidItem
			 * .getCategory().getCategoryId() : "")); jedis.hsetnx(key,
			 * RedisConstants.ATTR_AUCTIONID + clientId,
			 * String.valueOf(bidItem.getAuctionId())); jedis.hsetnx( key,
			 * RedisConstants.ATTR_AUTOBIDDERNAME + clientId,
			 * (bidItem.getAutoBidderName() != null) ? bidItem
			 * .getAutoBidderName() : ""); jedis.hsetnx( key,
			 * RedisConstants.ATTR_CURRENTAUTOBIDID + clientId,
			 * (bidItem.getCurrentAutoBidId() != null) ? String
			 * .valueOf(bidItem.getCurrentAutoBidId()) : ""); jedis.hsetnx(key,
			 * RedisConstants.ATTR_BIDSPAN + clientId,
			 * String.valueOf(bidItem.getBidSpan())); jedis.hsetnx(key,
			 * RedisConstants.ATTR_BIDSEQUENCEID + clientId,
			 * String.valueOf(bidItem.getSeqId()));
			 * 
			 * setBidders(bidItem, clientId);
			 * setCategory(bidItem.getBidItemId(), bidItem.getCategory(),
			 * clientId);
			 */

		} catch (Exception e) {
			logger.error("FAILED TO CACHE RedisConstants.BIDITEM: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	public static BidItem getBidItem(String key, String bidItemId, Long clientId) {
		// Jedis jedis = null;
		BidItem bidItem = null;
		// String s = null;
		try {
			// jedis = redis.connect();
			if (!bidItemExists(bidItemId, clientId)) {
				// redis.close(jedis);
				return null;
			}

			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);

			bidItem = auctionCacheBean.getBidItemsCurrentMap().get(
					Long.parseLong(bidItemId));

			/*
			 * bidItem = AuctionCacheManager.getActiveAuctionCacheBean(clientId)
			 * .getBidItemsMap().get(Long.parseLong(bidItemId));
			 */
			/*
			 * BidSequence bidSequence = AuctionCacheManager
			 * .getActiveAuctionCacheBean(clientId)
			 * .getBidItemIdbidSequence().get(bidItem.getBidItemId());
			 */

			/*
			 * s = jedis.hget(key, RedisConstants.ATTR_BIDITEMID + clientId);
			 * bidItem.setBidItemId((s == null || s.equals("null") || s.length()
			 * == 0) ? 0L : Long.parseLong(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_NAME + clientId); bidItem.setName(s); s =
			 * jedis.hget(key, RedisConstants.ATTR_LOCATION + clientId);
			 * bidItem.setLocation(s); s = jedis.hget(key,
			 * RedisConstants.ATTR_CITY + clientId); bidItem.setCity(s); s =
			 * jedis.hget(key, RedisConstants.ATTR_ZONE + clientId);
			 * bidItem.setZone(s); // s = jedis.hget(key,
			 * RedisConstants.ATTR_VERSION); // bidItem.setVersion(( s == null
			 * || s.equals("null") || s.length() // == 0) ? 0 :
			 * Integer.parseInt(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_MINBIDPRICE + clientId);
			 * bidItem.setMinBidPrice((s == null || s.equals("null") ||
			 * s.length() == 0) ? 0.0 : Double.parseDouble(s)); s =
			 * jedis.hget(key, RedisConstants.ATTR_MINBIDINCREMENT + clientId);
			 * bidItem.setMinBidIncrement((s == null || s.equals("null") || s
			 * .length() == 0) ? 0.0 : Double.parseDouble(s)); s =
			 * jedis.hget(key, RedisConstants.ATTR_BIDSTARTTIME + clientId);
			 * bidItem.setBidStartTime((s == null || s.length() == 0) ? null :
			 * sdf .parse(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_BIDENDTIME + clientId);
			 * bidItem.setBidEndTime((s == null || s.equals("null") ||
			 * s.length() == 0) ? null : sdf.parse(s)); s = jedis .hget(key,
			 * RedisConstants.ATTR_INITIALSTARTTIME + clientId);
			 * bidItem.setInitialStartTime((s == null || s.equals("null") || s
			 * .length() == 0) ? 0 : Integer.parseInt(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_TIMEEXTAFTERBID + clientId);
			 * bidItem.setTimeExtAfterBid((s == null || s.equals("null") || s
			 * .length() == 0) ? 0 : Integer.parseInt(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_STATUSCODE + clientId);
			 * bidItem.setStatusCode(s); s = jedis.hget(key,
			 * RedisConstants.ATTR_WINNERID + clientId); s = jedis.hget(key,
			 * RedisConstants.ATTR_LASTUPDATETIME + clientId);
			 * bidItem.setLastUpDateTime((s == null || s.equals("null") || s
			 * .length() == 0) ? null : sdf.parse(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_CREATEDTIME + clientId);
			 * bidItem.setCreatedTime((s == null || s.equals("null") ||
			 * s.length() == 0) ? null : sdf.parse(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_CURRENTMARKETPRICE + clientId);
			 * bidItem.setCurrentMarketPrice((s == null || s.equals("null") || s
			 * .length() == 0) ? 0.0 : Double.parseDouble(s)); s =
			 * jedis.hget(key, RedisConstants.ATTR_ISAUTOBID + clientId);
			 * bidItem.setAutoBidFlag((s == null || s.equals("null") ||
			 * s.length() == 0) ? false : true); s = jedis.hget(key,
			 * RedisConstants.ATTR_AUTOBIDID + clientId);
			 * bidItem.setAUTOBIDID((s == null || s.equals("null") || s.length()
			 * == 0) ? 0L : Long.parseLong(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_AUTOBIDAMOUNT + clientId);
			 * bidItem.setAmountAutoBid((s == null || s.equals("null") || s
			 * .length() == 0) ? 0.0 : Double.parseDouble(s)); s =
			 * jedis.hget(key, RedisConstants.ATTR_CURRENCY + clientId);
			 * bidItem.setCurrency(s); s = jedis.hget(key,
			 * RedisConstants.ATTR_CATEGORYID + clientId);
			 * bidItem.setCategory((s != null) ? getCategory(s, clientId) :
			 * null); s = jedis.hget(key, RedisConstants.ATTR_AUCTIONID +
			 * clientId); bidItem.setAuctionId((s == null || s.equals("null") ||
			 * s.length() == 0) ? 0L : Long.parseLong(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_AUTOBIDDERNAME + clientId);
			 * bidItem.setAutoBidderName(s); s = jedis .hget(key,
			 * RedisConstants.ATTR_CURRENTAUTOBIDID + clientId);
			 * bidItem.setCurrentAutoBidId((s == null || s.equals("null") || s
			 * .length() == 0) ? 0L : Long.parseLong(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_BIDSPAN + clientId); bidItem.setBidSpan((s ==
			 * null || s.equals("null") || s.length() == 0) ? 0L :
			 * Long.parseLong(s)); s = jedis.hget(key,
			 * RedisConstants.ATTR_BIDSEQUENCEID + clientId);
			 * bidItem.setSeqId((s == null || s.equals("null") || s.length() ==
			 * 0) ? 0L : Long.parseLong(s));
			 */

			getBidders(bidItem, clientId);

		} catch (Exception e) {
			logger.error("FAILED TO GET BIDITEM FROM CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return bidItem;
	}

	public static boolean setBidEndTime(long bidItemId, Date bidEndTime,
			String key, Long clientId) {
		// Jedis jedis = null;
		try {
			/*
			 * jedis = redis.connect(); if
			 * (!jedis.sismember(RedisConstants.BIDITEMS + clientId,
			 * String.valueOf(bidItemId))) { redis.close(jedis); return false; }
			 * jedis.hset(key, RedisConstants.ATTR_BIDENDTIME + clientId,
			 * sdf.format(bidEndTime));
			 */

			BidItem bidItem = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId).getBidItemsMap()
					.get(bidItemId);
			if (bidItem == null) {
				return false;
			} else {
				bidItem.setBidEndTime(bidEndTime);
				AuctionCacheManager.getActiveAuctionCacheBean(clientId)
						.getBidItemsMap().put(bidItemId, bidItem);
			}

		} catch (Exception e) {
			logger.error("FAILED TO SET BIDITEM END TIME: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return true;
	}

	public static Date getBidEndTime(long bidItemId, String key, Long clientId) {
		// Jedis jedis = null;
		Date bidEndTime = null;
		try {
			/*
			 * //jedis = redis.connect(); String endTime = jedis.hget(key,
			 * RedisConstants.ATTR_BIDENDTIME + clientId); bidEndTime = (endTime
			 * == null || endTime.length() == 0 || endTime .equals("null")) ?
			 * null : sdf.parse(endTime);
			 */

			bidEndTime = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId).getBidItemsMap()
					.get(bidItemId).getBidEndTime();
			System.out.println("getBid end time " + bidEndTime);

		} catch (Exception e) {
			logger.error("FAILED TO SET BIDITEM END TIME: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return bidEndTime;
	}

	public static boolean setBidItemLastUpdateTime(long bidItemId,
			Date lastUpdateTime, String key, Long clientId) {
		// Jedis jedis = null;
		try {/*
			 * jedis = redis.connect(); if
			 * (!jedis.sismember(RedisConstants.BIDITEMS + clientId,
			 * String.valueOf(bidItemId))) { redis.close(jedis); return false; }
			 * jedis.hset(key, RedisConstants.ATTR_LASTUPDATETIME + clientId,
			 * sdf.format(lastUpdateTime));
			 */

			BidItem bidItem = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId).getBidItemsMap()
					.get(bidItemId);
			if (bidItem == null) {
				return false;
			} else {

				bidItem.setLastUpDateTime(lastUpdateTime);
				AuctionCacheManager.getActiveAuctionCacheBean(clientId)
						.getBidItemsMap().put(bidItemId, bidItem);
			}
		} catch (Exception e) {
			logger.error("FAILED TO SET BIDITEM LAST UPDATE TIME: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return true;
	}

	public static Date getBidItemLastUpdateTime(long bidItemId, String key,
			Long clientId) {
		// Jedis jedis = null;
		Date bidEndTime = null;
		try {
			/* jedis = redis.connect(); */
			/*
			 * String endTime = jedis.hget(key,
			 * RedisConstants.ATTR_LASTUPDATETIME + clientId);
			 */

			/*
			 * bidEndTime = (endTime == null || endTime.length() == 0 || endTime
			 * .equals("null")) ? null : sdf.parse(endTime);
			 */

			bidEndTime = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId).getBidItemsMap()
					.get(bidItemId).getBidEndTime();

		} catch (Exception e) {
			logger.error("FAILED TO SET BIDITEM LAST UPDATE TIME: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return bidEndTime;
	}

	public static void getBidders(BidItem bidItem, Long clientId) {
		// Jedis jedis = null;
		try {
			// jedis = redis.connect();

			/*
			 * Set<String> bidders = jedis.smembers(RedisConstants.BIDDERS +
			 * bidItem.getBidItemId() + clientId);
			 */
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			Map<Long, List<Bidder>> bidItemIdBidderListMap = auctionCacheBean
					.getBidderMap();
			if (bidItemIdBidderListMap == null) {
				bidItemIdBidderListMap = new HashMap<Long, List<Bidder>>();
			}

			List<Bidder> bidders = bidItemIdBidderListMap.get(bidItem
					.getBidItemId());
			if (bidders == null) {
				bidders = new ArrayList<Bidder>();
			}
			for (Bidder bidder : bidders) {
				bidItem.addBidder(bidder);
			}
			bidItemIdBidderListMap.put(bidItem.getBidItemId(), bidders);
			auctionCacheBean.setBidderMap(bidItemIdBidderListMap);

			/*
			 * for (String bidder : bidders) {
			 * bidItem.addBidder(getBidder(bidItem.getBidItemId(), bidder,
			 * clientId)); }
			 */
		} catch (Exception e) {
			logger.error("FAILED TO ADD BIDDER FOR BIDITEM: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	public static void setBidders(BidItem bidItem, Long clientId) {
		List<Bidder> bidders = bidItem.getCurrentBidderList();
		if (bidders == null || bidders.isEmpty())
			return;
		for (Bidder b : bidders) {
			setBidder(bidItem.getBidItemId(), b.getBidderName(), b.isAutoBid(),
					b.getCurrentBidAmount(), clientId);
		}
	}

	public static void setBidder(long bidItemId, String bidderName,
			boolean isAutoBid, double bidAmount, Long clientId) {
		AuctionCacheBean auctionCacheBean = AuctionCacheManager
				.getActiveAuctionCacheBean(clientId);
		Map<String, Bidder> bidderMap = auctionCacheBean.getBidderIdMap();
		Map<Long, List<Bidder>> bidderMapList = auctionCacheBean.getBidderMap();
		if (bidderMap == null) {
			bidderMap = new HashMap<String, Bidder>();
		}
		if (bidderMapList != null) {
			bidderMapList = new HashMap<Long, List<Bidder>>();
		}

		/* Jedis jedis = null; */
		try {

			Bidder bidder = new Bidder();
			bidder.setAutoBid(isAutoBid);
			bidder.setBidderName(bidderName);
			bidder.setAutoBidMaxAnount(bidAmount);
			List<Bidder> bidderList = bidderMapList.get(bidItemId);
			bidderList.add(bidder);
			bidderMap.put(bidderName + bidItemId, bidder);
			bidderMapList.put(bidItemId, bidderList);

			// jedis = redis.connect();
			// String key = RedisConstants.BIDDER + bidItemId + "::";
			/*
			 * jedis.sadd(RedisConstants.BIDDERS + bidItemId + clientId,
			 * bidderName); jedis.hsetnx(key + bidderName + clientId,
			 * "bidderName", bidderName); jedis.hsetnx(key + bidderName +
			 * clientId, "autoBid", String.valueOf(isAutoBid)); jedis.hsetnx(key
			 * + bidderName + clientId, "bidAmount", String.valueOf(bidAmount));
			 */

			auctionCacheBean.setBidderIdMap(bidderMap);
			auctionCacheBean.setBidderMap(bidderMapList);
		} catch (Exception e) {
			logger.error("FAILED TO STORE BIDDER FOR BIDITEM: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	public static Bidder getBidder(long bidItemId, String bidderName,
			Long clientId) {
		// Jedis jedis = null;
		Bidder bidder = null;
		try {
			// jedis = redis.connect();
			// String key = RedisConstants.BIDDER + bidItemId + "::";
			/*
			 * if(!jedis.sismember(RedisConstants.BIDDERS + bidItemId,
			 * bidderName)) { redis.close(jedis); return null; }
			 */
			/*
			 * bidder.setBidderName(jedis.hget(key + bidderName, "bidderName"));
			 * bidder.setAutoBid(Boolean.parseBoolean((jedis.hget( key +
			 * bidderName, "autoBid"))));
			 * bidder.setCurrentBidAmount((jedis.hget(key + bidderName,
			 * "bidAmount") == null) ? 0.0 : Double.parseDouble(jedis .hget(key
			 * + bidderName, "bidAmount")));
			 */

			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			bidder = auctionCacheBean.getBidderIdMap().get(
					bidderName + bidItemId);

		} catch (Exception e) {
			logger.error("FAILED TO GET BIDDER: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return bidder;
	}

	public static List<BidItem> getBidItems(String categoryId, Long clientId) {
		// Jedis jedis = null;
		List<BidItem> bidItems = null;
		try {
			/*
			 * jedis = redis.connect(); Set<String> bidItemIds =
			 * jedis.smembers(RedisConstants.CATEGORY + categoryId); bidItems =
			 * new ArrayList<BidItem>(); for (String bidItemId : bidItemIds) {
			 * bidItems.add(getBidItem(RedisConstants.BIDITEM + bidItemId,
			 * bidItemId, clientId)); }
			 */

			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			auctionCacheBean.getBidderMap();

		} catch (Exception e) {
			logger.error("FAILED TO SET BIDITEM TO CATEGORY: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return bidItems;
	}

	public static List<BidItem> getBidItems(Long clientId) {
		// Jedis jedis = null;
		List<BidItem> bidItems = null;
		try {/*
			 * jedis = redis.connect(); Set<String> bidItemIds =
			 * jedis.smembers(RedisConstants.BIDITEMS + clientId);
			 * System.out.println("bidItemIds" + bidItemIds); for (String
			 * bidItemId : bidItemIds) {
			 * bidItems.add(getBidItem(RedisConstants.BIDITEM + bidItemId +
			 * clientId, bidItemId, clientId)); }
			 */
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			bidItems = auctionCacheBean.getBidItems();

		} catch (Exception e) {
			logger.error("FAILED TO GET BIDITEMS: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return bidItems;
	}

	public static boolean bidItemExists(String bidItemId, Long clientId) {
		Jedis jedis = null;
		try {
			// jedis = redis.connect();
			/*
			 * return jedis.sismember(RedisConstants.BIDITEMS + clientId,
			 * bidItemId);
			 */
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			Map<Long, BidItem> itemMap = auctionCacheBean.getBidItemsMap();
			if (itemMap.get(Long.parseLong(bidItemId)) != null) {
				return true;
			}

		} catch (Exception e) {
			logger.error("FAILED TO CHECK BIDITEM IN CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return false;
	}

	public static void setCategory(long bidItemId, Category category,
			Long clientId) {
		if (category == null)
			return;
		// Jedis jedis = null;
		try {
			/*
			 * jedis = redis.connect(); jedis.sadd(RedisConstants.CATEGORIES +
			 * category.getCategoryId() + clientId, String.valueOf(bidItemId));
			 */

			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);

			Map<Long, Long> categoryIdBidItemIdMap = auctionCacheBean
					.getCategoryBidItemMap();
			if (categoryIdBidItemIdMap == null) {
				categoryIdBidItemIdMap = new HashMap<Long, Long>();
			}

			categoryIdBidItemIdMap.put(category.getCategoryId(), bidItemId);
		} catch (Exception e) {
			logger.error("FAILED TO SET BIDITEM TO CATEGORY: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	public static Category getCategory(String categoryId, Long clientId) {
		// Jedis jedis = null;
		Category category = null;
		try {
			// jedis = redis.connect();
			/*
			 * category = new Category();
			 * category.setCategoryName(jedis.hget(RedisConstants.CATEGORY +
			 * categoryId + clientId, RedisConstants.ATTR_CATEGORY_NAME +
			 * clientId)); category.setCategoryId(Long.valueOf(jedis.hget(
			 * RedisConstants.CATEGORY + categoryId + clientId,
			 * RedisConstants.ATTR_CATEGORY_ID + clientId)));
			 */
			Map<Long, Category> categoryMap = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId).getCategoryMap();
			categoryMap.get(categoryId);

		} catch (Exception e) {
			logger.error("FAILED TO GET CATEGOY FROM CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return category;
	}

	public static void setCategories(List<Category> categoryies, Long clientId) {
		// Jedis jedis = null;
		logger.debug("setting categories");
		try {
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			if (auctionCacheBean == null) {
				auctionCacheBean = new AuctionCacheBean();
				auctionCacheBean.setClientId(clientId);
				AuctionCacheManager.setActiveAuctionCacheBean(auctionCacheBean);
			}

			Map<Long, Category> categoryMap = null;
			if (auctionCacheBean.getCategoryMap() != null) {
				categoryMap = auctionCacheBean.getCategoryMap();
			} else {
				categoryMap = new HashMap<Long, Category>();
			}

			for (Category c : categoryies) {
				categoryMap.put(c.getCategoryId(), c);
			}

			/*
			 * jedis = redis.connect(); for (Category c : categoryies) {
			 * jedis.sadd(RedisConstants.CATEGORIES + clientId,
			 * String.valueOf(c.getCategoryId()));
			 * jedis.hset(RedisConstants.CATEGORY + c.getCategoryId() +
			 * clientId, RedisConstants.ATTR_CATEGORY_NAME + clientId,
			 * c.getCategoryName()); jedis.hset(RedisConstants.CATEGORY +
			 * c.getCategoryId() + clientId, RedisConstants.ATTR_CATEGORY_ID +
			 * clientId, String.valueOf(c.getCategoryId())); }
			 */

		} catch (Exception e) {
			logger.error("FAILED TO SET CATEGORIES LIST IN CACHE: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	public static List<Category> getCategories(Long clientId) {
		// Jedis jedis = null;
		List<Category> categoryList = new ArrayList<Category>();
		try {/*
			 * jedis = redis.connect(); Set<String> categories =
			 * jedis.smembers(RedisConstants.CATEGORIES + clientId); Category
			 * category = null; for (String c : categories) { category = new
			 * Category();
			 * category.setCategoryName(jedis.hget(RedisConstants.CATEGORY + c +
			 * clientId, RedisConstants.ATTR_CATEGORY_NAME + clientId));
			 * category.setCategoryId(Long.valueOf(jedis.hget(
			 * RedisConstants.CATEGORY + c + clientId,
			 * RedisConstants.ATTR_CATEGORY_ID + clientId)));
			 * categoryList.add(category); }
			 */

			Map<Long, Category> mapCategory = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId).getCategoryMap();
			Set<Long> set = mapCategory.keySet();
			for (Long c : set) {
				categoryList.add(mapCategory.get(c));
			}

		} catch (Exception e) {
			logger.error("FAILED TO GET CATEGORIES LIST FROM CACHE: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return categoryList;
	}

	public static void setBidderCategories(List<Category> categories,
			Long clientId) {
		//Jedis jedis = null;
		try {
			/* jedis = redis.connect(); */
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			Map<Long, Category> categoryMap = auctionCacheBean.getCategoryMap();
			for (Category c : categories) {
				/*
				 * jedis.sadd(RedisConstants.BID_CATEGORY + c.getCategoryId() +
				 * clientId, c.getCategoryName());
				 */
				categoryMap.put(c.getCategoryId(), c);

			}
		} catch (Exception e) {
			logger.error("FAILED TO SET BIDCATEOGIRES IN CACHE: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	public static void setBidIdKey(long maxBidId, Long clientId) {
		// Jedis jedis = null;
		try {
			/*
			 * jedis = redis.connect(); jedis.set("::BIDID::" + clientId,
			 * String.valueOf(maxBidId));
			 */
			AuctionCacheManager.setBidIdKey(clientId, maxBidId);
		} catch (Exception e) {
			logger.error("FAILED TO SET BIDCATEOGIRES IN CACHE: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	public static void setAutoBidIdKey(long maxAutoBidId, Long clientId) {
		// Jedis jedis = null;
		try {
			/*
			 * jedis = redis.connect(); jedis.set("::AUTOBIDID::" + clientId,
			 * String.valueOf(maxAutoBidId));
			 */
			AuctionCacheManager.setAutoBidIdKey(clientId, maxAutoBidId);

		} catch (Exception e) {
			logger.error("FAILED TO SET BIDCATEOGIRES IN CACHE: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	public static long getBidItemSpan(long bidItemId, Long clientId) {
		// Jedis jedis = null;
		long bidSpan = 0;
		try {
			/*
			 * jedis = redis.connect(); bidSpan =
			 * Long.parseLong(jedis.hget(RedisConstants.BIDSEQUENCE + bidItemId
			 * + clientId, RedisConstants.ATTR_BIDSPAN + clientId));
			 */
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);

			BidItem bidItem = auctionCacheBean.getBidItemsMap().get(bidItemId);
			bidSpan = bidItem.getBidSpan();

		} catch (Exception e) {
			logger.error("FAILED TO GET BIDITEM SPAN FROM CACHE: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return bidSpan;
	}

	public static void setBidSequenceList(List<BidSequence> bidSequenceList,
			Long clientId) {
		// Jedis jedis = null;
		try {
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			if (auctionCacheBean == null) {
				auctionCacheBean = new AuctionCacheBean();
			}
			// System.out.println("auctionCacheBean" + auctionCacheBean);
			// jedis = redis.connect();

			Map<Long, BidSequence> bidItemIdBidSequenceMap = auctionCacheBean
					.getBidItemIdbidSequence();

			Queue<Map<Long, Long>> seqandBidItemIdQueue = auctionCacheBean
					.getSequenceIdBidItemIdQueue();

			Map<Long, BidItem> bidItemMap = auctionCacheBean.getBidItemsMap();

			if (bidItemIdBidSequenceMap == null) {
				bidItemIdBidSequenceMap = new HashMap<Long, BidSequence>();
			}
			if (seqandBidItemIdQueue == null) {
				seqandBidItemIdQueue = new ArrayDeque<Map<Long, Long>>();
			}

			if (bidItemMap == null) {
				bidItemMap = new HashMap<Long, BidItem>();
			}
			for (BidSequence bidSequenceQueue : bidSequenceList) {
				bidItemIdBidSequenceMap.put(bidSequenceQueue.getBidItem()
						.getBidItemId(), bidSequenceQueue);
				BidItem bidItem = bidSequenceQueue.getBidItem();
				bidItem.setSeqId(bidSequenceQueue.getSequenceId());
				bidItem.setBidSpan(bidSequenceQueue.getBidspan());
				System.out.println("  setting bid sequence BidItem sequence Id"
						+ bidItem.getSeqId());
				System.out
						.println("  setting bid sequence BidItem Span time Id"
								+ bidItem.getBidSpan());

				bidItemMap.put(bidItem.getBidItemId(), bidItem);
				auctionCacheBean
						.setBidItemIdbidSequence(bidItemIdBidSequenceMap);
				auctionCacheBean.setBidItemsMap(bidItemMap);
				Map<Long, Long> map = new HashMap<Long, Long>();
				map.put(bidSequenceQueue.getSequenceId(), bidSequenceQueue
						.getBidItem().getBidItemId());
				seqandBidItemIdQueue.add(map);
				auctionCacheBean
						.setSequenceIdBidItemIdQueue(seqandBidItemIdQueue);

				/*
				 * 
				 * jedis.zadd(RedisConstants.BIDITEMID_SEQUENCE + clientId,
				 * s.getSequenceId(),
				 * String.valueOf(s.getBidItem().getBidItemId()));
				 * jedis.set(RedisConstants.AUCTIONID + clientId,
				 * String.valueOf(s.getAuction().getAuctionId()));
				 * jedis.hset(RedisConstants.BIDSEQUENCE +
				 * s.getBidItem().getBidItemId() + clientId,
				 * RedisConstants.ATTR_BIDITEMID + clientId,
				 * String.valueOf(s.getBidItem().getBidItemId()));
				 * jedis.hset(RedisConstants.BIDSEQUENCE +
				 * s.getBidItem().getBidItemId() + clientId,
				 * RedisConstants.ATTR_SEQUENCEID + clientId,
				 * String.valueOf(s.getSequenceId()));
				 * jedis.hset(RedisConstants.BIDSEQUENCE +
				 * s.getBidItem().getBidItemId() + clientId,
				 * RedisConstants.ATTR_AUCTIONID + clientId,
				 * String.valueOf(s.getAuction().getAuctionId()));
				 * jedis.hset(RedisConstants.BIDSEQUENCE +
				 * s.getBidItem().getBidItemId() + clientId,
				 * RedisConstants.ATTR_BIDSPAN + clientId,
				 * String.valueOf(s.getBidspan()));
				 */}

			/*
			 * Set<String> bidItemList = jedis.zrangeByScore(
			 * RedisConstants.BIDITEMID_SEQUENCE + clientId, 0,
			 * jedis.zcard(RedisConstants.BIDITEMID_SEQUENCE + clientId));
			 */

			/*
			 * for (String bidItemId : bidSequenceList) {
			 * jedis.lpush(RedisConstants.BIDITEMSEQUENCEIDS + clientId,
			 * bidItemId);
			 * 
			 * }
			 */

		} catch (Exception e) {
			logger.error("FAILED TO SET BIDSEQUENCE IN CACHE: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	// Get SEQUENCE ID, BIDITEM ID, BIDSPAN, AUCTION ID. Pass BIDITEM ID and
	// client Id
	public static Map<String, String> getBidItemSequenceDetails(long bidItemId,
			Long clientId) {
		// Jedis jedis = null;
		Map<String, String> sequenceDetails = new HashMap<String, String>();
		try {
			/*
			 * jedis = redis.connect(); sequenceDetails =
			 * jedis.hgetAll(RedisConstants.BIDSEQUENCE + bidItemId + clientId);
			 */
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			BidSequence bidSequence = auctionCacheBean
					.getBidItemIdbidSequence().get(bidItemId);
			sequenceDetails.put(RedisConstants.ATTR_AUCTIONID, bidSequence
					.getAuction().getAuctionId().toString());
			sequenceDetails.put(RedisConstants.ATTR_SEQUENCEID,
					String.valueOf(bidSequence.getSequenceId()));
			sequenceDetails.put(RedisConstants.ATTR_BIDSPAN,
					String.valueOf(bidSequence.getBidspan()));

			System.out.println("sequence Details " + sequenceDetails);
		} catch (Exception e) {
			logger.error("FAILED TO GET BIDSEQUENCE DETAILS FROM CACHE: "
					+ e.getMessage());
			e.printStackTrace();
		}
		/* redis.close(jedis); */
		return sequenceDetails;
	}

	public static void setActiveBidItemId(Long clientId) {
		// Jedis jedis = null;
		try {
			logger.debug("Setting active bid item Id");
			/*
			 * Long bidItemId = jedis.rpop(RedisConstants.BIDITEMSEQUENCEIDS +
			 * clientId);
			 */
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			Queue<Map<Long, Long>> seqIdAndBidItemId = auctionCacheBean
					.getSequenceIdBidItemIdQueue();
			logger.debug("bidItemIds" + seqIdAndBidItemId);
			Map<Long, Long> seqIdBidItemId = seqIdAndBidItemId.poll();
			logger.debug("sequence Id Maps" + seqIdBidItemId);
			/*
			 * jedis = redis.connect(); String bidItemId =
			 * jedis.rpop(RedisConstants.BIDITEMSEQUENCEIDS + clientId);
			 * jedis.set(RedisConstants.ACTIVE_BIDITEMID + clientId, (bidItemId
			 * == null) ? "0" : bidItemId);
			 */

			if (seqIdBidItemId != null) {
				List<Long> l = new ArrayList<Long>();
				l.addAll(seqIdBidItemId.keySet());
				logger.debug("Bid Item Id" + seqIdBidItemId.get(l.get(0)));
				auctionCacheBean
						.setActiveBidItemId(seqIdBidItemId.get(l.get(0)));
				logger.debug("setting active bid item id==========="
						+ auctionCacheBean.getActiveBidItemId());
			} else {
				logger.debug("auction cache bean object is setting ol now bit items are not availble more for bidding");
				auctionCacheBean.setActiveBidItemId(0l);
			}
		} catch (Exception e) {
			logger.error("FAILED TO SET BIDSEQUENCE IN CACHE: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	/**
	 * This
	 * 
	 * @param clientId
	 * @return
	 */
	public static long getActiveBidItemId(Long clientId) {
		// Jedis jedis = null;
		long bidItemId = 0L;
		try {
			/*
			 * jedis = redis.connect(); String id =
			 * jedis.get(RedisConstants.ACTIVE_BIDITEMID + clientId);
			 */
			Long id = AuctionCacheManager.getActiveAuctionCacheBean(clientId)
					.getActiveBidItemId();
			bidItemId = (id == null) ? 0 : id;
			logger.debug("bidItemId" + bidItemId);
		} catch (Exception e) {
			logger.error("FAILED TO GET BIDSEQUENCE IN CACHE: "
					+ e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return bidItemId;
	}

	public static String isEndSequence(Long clientId) {
		// Jedis jedis = null;
		Long endSequence = null;
		try {
			// jedis = redis.connect();
			// endSequence = jedis.get(RedisConstants.ACTIVE_BIDITEMID +
			// clientId);
			endSequence = AuctionCacheManager.getActiveAuctionCacheBean(
					clientId).getActiveBidItemId();
			logger.debug("End of sequnce" + endSequence);
			if (endSequence == null)
				return null;
			if (endSequence == 0L)
				return "TRUE";
		} catch (Exception e) {
			logger.error("FAILED TO GET ENDSEQUNCE IN CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return "FALSE";
	}

	public static void setAuctionId(String auctionId, Long clientId) {
		// Jedis jedis = null;
		try {
			/*
			 * jedis = redis.connect(); jedis.set(RedisConstants.AUCTIONID +
			 * clientId, auctionId);
			 * System.out.println(jedis.get(RedisConstants.AUCTIONID +
			 * clientId));
			 */
			logger.debug("Setting Active Auction Id" + auctionId);
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			if (auctionCacheBean == null) {
				auctionCacheBean = new AuctionCacheBean();
				auctionCacheBean.setClientId(clientId);
				auctionCacheBean.setAuctionId(Long.parseLong(auctionId));

			} else {
				auctionCacheBean.setAuctionId(Long.parseLong(auctionId));
			}

			AuctionCacheManager.setActiveAuctionCacheBean(auctionCacheBean);

		} catch (Exception e) {
			logger.error("FAILED TO GET ENDSEQUNCE IN CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

	public static String getAuctionId(Long clientId) {
		// Jedis jedis = null;
		Long auctionId = null;
		try {
			/*
			 * jedis = redis.connect(); auctionId =
			 * jedis.get(RedisConstants.AUCTIONID + clientId);
			 */
			AuctionCacheBean auctionCacheBean = AuctionCacheManager
					.getActiveAuctionCacheBean(clientId);
			auctionId = auctionCacheBean.getAuctionId();
		} catch (Exception e) {
			logger.error("FAILED TO GET Auction Id CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
		return auctionId.toString();
	}

	public static void setExpiredBidItem(long bidItemId, Long clientId) {
		// Jedis jedis = null;
		try {
			/*
			 * jedis = redis.connect();
			 * jedis.sadd(RedisConstants.EXPIRED_BIDITEMS + clientId,
			 * String.valueOf(bidItemId)); jedis.hset(RedisConstants.BIDITEM +
			 * bidItemId + clientId, RedisConstants.ATTR_STATUSCODE + clientId,
			 * "CLOSED"); jedis.hset(RedisConstants.BIDITEM + bidItemId +
			 * clientId, RedisConstants.ATTR_BIDENDTIME + clientId,
			 * sdf.format(new Date()));
			 */
			BidItem bidItem = new BidItem();
			bidItem.setBidItemId(bidItemId);
			bidItem.setStatusCode("CLOSED");
			bidItem.setBidEndTime(new Date());
			AuctionCacheBean auctionCacheBean = new AuctionCacheBean();
			Map<Long, BidItem> expiredItemsMap = auctionCacheBean
					.getExpiredBidItems();
			if (expiredItemsMap == null) {
				expiredItemsMap = new HashMap<Long, BidItem>();
			}
			expiredItemsMap.put(bidItemId, bidItem);
			auctionCacheBean.setExpiredBidItems(expiredItemsMap);

		} catch (Exception e) {
			logger.error("FAILED TO GET ENDSEQUNCE IN CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		// redis.close(jedis);
	}

}