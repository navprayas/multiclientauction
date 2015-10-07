package com.navprayas.bidding.engine.orm;

import java.util.Date;

public class Bid {
	private Long id;
	private Integer version;
	private Long bidId;
	private Long bidItemId;
	private Long auctionId;
	private Double bidAmount;
	private String currency;
	private Date bidTime;
	private String bidStatus;
	private String bidderName;
	private String comments;
	private int bidType;
	private String status;
	private Double autoBidAmount;
	private Long bidderId;

	public Bid() {
		// TODO Auto-generated constructor stub
	}

	public Bid(String bidderName, long auctionId, long bidItemId,
			double bidAmount, String currency, String status, int bidType,
			String comments, double autoBidAmount) {
		/* 38 */this.bidderName = bidderName;
		/* 39 */this.auctionId = auctionId;
		/* 40 */this.bidItemId = bidItemId;
		/* 41 */this.bidAmount = bidAmount;
		/* 42 */this.currency = currency;
		/* 43 */this.status = status;
		/* 44 */this.bidType = bidType;
		/* 45 */this.comments = comments;
		/* 46 */this.autoBidAmount = autoBidAmount;
		/*     */}

	/*     */
	/*     */public Bid(long bidderId, long auctionId, long bidItemId,
			double bidAmount, String currency, String status, int bidType,
			String comments, double autoBidAmount) {
		/* 50 */this.bidderId = bidderId;
		/* 51 */this.auctionId = auctionId;
		/* 52 */this.bidItemId = bidItemId;
		/* 53 */this.bidAmount = bidAmount;
		/* 54 */this.currency = currency;
		/* 55 */this.status = status;
		/* 56 */this.bidType = bidType;
		/* 57 */this.comments = comments;
		/* 58 */this.autoBidAmount = autoBidAmount;
		/*     */}

	public int getBidType() {
		return bidType;
	}

	public void setBidType(int bidType) {
		this.bidType = bidType;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public Integer getVersion() {
		return version;
	}

	public void setBidId(Long bidId) {
		this.bidId = bidId;
	}

	public Long getBidId() {
		return bidId;
	}

	public void setBidItemId(Long bidItemId) {
		this.bidItemId = bidItemId;
	}

	public Long getBidItemId() {
		return bidItemId;
	}

	public void setAuctionId(Long auctionId) {
		this.auctionId = auctionId;
	}

	public Long getAuctionId() {
		return auctionId;
	}

	public void setBidAmount(Double bidAmount) {
		this.bidAmount = bidAmount;
	}

	public Double getBidAmount() {
		return bidAmount;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getCurrency() {
		return currency;
	}

	public void setBidTime(Date bidTime) {
		this.bidTime = bidTime;
	}

	public Date getBidTime() {
		return bidTime;
	}

	public void setBidStatus(String bidStatus) {
		this.bidStatus = bidStatus;
	}

	public String getBidStatus() {
		return bidStatus;
	}

	public void setBidderName(String bidderName) {
		this.bidderName = bidderName;
	}

	public String getBidderName() {
		return bidderName;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getComments() {
		return comments;
	}

	public Double getAutoBidAmount() {
		return autoBidAmount;
	}

	public void setAutoBidAmount(Double autoBidAmount) {
		this.autoBidAmount = autoBidAmount;
	}

	public Long getBidderId() {
		return bidderId;
	}

	public void setBidderId(Long bidderId) {
		this.bidderId = bidderId;
	}

}
