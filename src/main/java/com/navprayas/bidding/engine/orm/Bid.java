package com.navprayas.bidding.engine.orm;

/*     */import java.io.Serializable;
/*     */
import java.util.Date;

/*     */public class Bid
/*     */implements Serializable
/*     */{
	/*     */private static final long serialVersionUID = 4397762750881516374L;
	/*     */public long Id;
	/*     */public int version;
	/*     */public long bidId;
	/*     */public long bidItemId;
	/*     */public long auctionId;
	/*     */public double bidAmount;
	/*     */public String currency;
	/* 19 */public Date bidTime = new Date();
	/*     */public String status;
	/*     */public long bidderId;
	/*     */public String bidderName;
	/*     */public String comments;
	/*     */public int bidType;
	/*     */public double autoBidAmount;
	public Long parentId;

	/*     */
	/*     */public Bid() {
	}

	/*     */
	/*     */public Bid(long bidderId) {
		/* 30 */this.bidderId = bidderId;
		/*     */}

	/*     */
	/*     */public Bid(String bidderName) {
		/* 34 */this.bidderName = bidderName;
		/*     */}

	/*     */
	/*     */public Bid(String bidderName, long auctionId, long bidItemId,
			double bidAmount, String currency, String status, int bidType,
			String comments, double autoBidAmount, Long parentId) {
		/* 38 */this.bidderName = bidderName;
		/* 39 */this.auctionId = auctionId;
		/* 40 */this.bidItemId = bidItemId;
		/* 41 */this.bidAmount = bidAmount;
		/* 42 */this.currency = currency;
		/* 43 */this.status = status;
		/* 44 */this.bidType = bidType;
		/* 45 */this.comments = comments;
		/* 46 */this.autoBidAmount = autoBidAmount;
		this.parentId = parentId;
		/*     */}

	/*     */
	/*     */public Bid(long bidderId, long auctionId, long bidItemId,
			double bidAmount, String currency, String status, int bidType,
			String comments, double autoBidAmount, Long parentId) {
		/* 50 */this.bidderId = bidderId;
		/* 51 */this.auctionId = auctionId;
		/* 52 */this.bidItemId = bidItemId;
		/* 53 */this.bidAmount = bidAmount;
		/* 54 */this.currency = currency;
		/* 55 */this.status = status;
		/* 56 */this.bidType = bidType;
		/* 57 */this.comments = comments;
		/* 58 */this.autoBidAmount = autoBidAmount;
		this.parentId = parentId;
		/*     */}

	/*     */
	/*     */public void setVersion(int version) {
		/* 62 */this.version = version;
		/*     */}

	/*     */
	/*     */public int getVersion() {
		/* 66 */return this.version;
		/*     */}

	/*     */
	/*     */public void setBidId(long bidId) {
		/* 70 */this.bidId = bidId;
		/*     */}

	/*     */
	/*     */public long getBidId() {
		/* 74 */return this.bidId;
		/*     */}

	/*     */
	/*     */public void setAuctionId(long auctionId) {
		/* 78 */this.auctionId = auctionId;
		/*     */}

	/*     */
	/*     */public long getAuctionId() {
		/* 82 */return this.auctionId;
		/*     */}

	/*     */
	/*     */public long getBidderId() {
		/* 86 */return this.bidderId;
		/*     */}

	/*     */
	/*     */public void setBidderId(long bidderId) {
		/* 90 */this.bidderId = bidderId;
		/*     */}

	/*     */
	/*     */public long getBidItemId() {
		/* 94 */return this.bidItemId;
		/*     */}

	/*     */
	/*     */public void setBidItemId(long bidItemId) {
		/* 98 */this.bidItemId = bidItemId;
		/*     */}

	/*     */
	/*     */public double getBidAmount() {
		/* 102 */return this.bidAmount;
		/*     */}

	/*     */
	/*     */public void setBidAmount(double bidAmount) {
		/* 106 */this.bidAmount = bidAmount;
		/*     */}

	/*     */
	/*     */public String getCurrency() {
		/* 110 */return this.currency;
		/*     */}

	/*     */
	/*     */public void setCurrency(String currency) {
		/* 114 */this.currency = currency;
		/*     */}

	/*     */
	/*     */public String getBidderName() {
		/* 118 */return this.bidderName;
		/*     */}

	/*     */
	/*     */public void setBidderName(String bidderName) {
		/* 122 */this.bidderName = bidderName;
		/*     */}

	/*     */
	/*     */public String getStatus() {
		/* 126 */return this.status;
		/*     */}

	/*     */
	/*     */public void setStatus(String status) {
		/* 130 */this.status = status;
		/*     */}

	/*     */
	/*     */public Date getBidTime() {
		/* 134 */return this.bidTime;
		/*     */}

	/*     */
	/*     */public void setBidType(int bidType) {
		/* 138 */this.bidType = bidType;
		/*     */}

	/*     */
	/*     */public int getBidType() {
		/* 142 */return this.bidType;
		/*     */}

	/*     */
	/*     */public void setComments(String comments) {
		/* 146 */this.comments = comments;
		/*     */}

	/*     */
	/*     */public String getComments() {
		/* 150 */return this.comments;
		/*     */}

	/*     */
	/*     */public double getAutoBidAmount() {
		/* 154 */return this.autoBidAmount;
		/*     */}

	/*     */
	/*     */public void setAutoBidAmount(double autoBidAmount) {
		/* 158 */this.autoBidAmount = autoBidAmount;
		/*     */}

	/*     */
	/*     */public long getId() {
		/* 168 */return this.Id;
		/*     */}

	/*     */
	/*     */public void setId(long id) {
		/* 172 */this.Id = id;
		/*     */}

	/*     */
	/*     */public void setBidTime(Date bidTime) {
		/* 176 */this.bidTime = bidTime;
		/*     */}

	/*     */

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

}
