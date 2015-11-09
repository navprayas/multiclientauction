package com.navprayas.bidding.webservices.dtos;

import java.util.Date;

public class BidItemsDto {

	private Long auctionId;
	private String auctionName;
	

	private Long bidItemId;

	private String serialNo;

	private String name;

	private String location;

	private String city;

	private String zone = "";

	private Double minBidPrice;

	private Double minBidIncrement;

	private Date bidStartTime;

	private Date bidEndTime;

	private Integer initialStartTime;

	private Integer timeExtAfterBid;

	private String statusCode;

	private Date lastUpDateTime;

	private Date createdTime;

	private Double currentMarketPrice;

	private String currency;

	private String isProcessed;

	private String bidderName;

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	/**
	 * @return the isProcessed
	 */
	public String getIsProcessed() {
		return isProcessed;
	}

	/**
	 * @param isProcessed
	 *            the isProcessed to set
	 */
	public void setIsProcessed(String isProcessed) {
		this.isProcessed = isProcessed;
	}

	private Long AUTOBIDID;

	/**
	 * @return the aUTOBIDID
	 */
	public Long getAUTOBIDID() {
		return AUTOBIDID;
	}

	/**
	 * @param aUTOBIDID
	 *            the aUTOBIDID to set
	 */
	public void setAUTOBIDID(Long aUTOBIDID) {
		AUTOBIDID = aUTOBIDID;
	}

	private String category;

	private String imageUrl;

	public String getBidderName() {
		return bidderName;
	}

	public void setBidderName(String bidderName) {
		this.bidderName = bidderName;
	}

	public Long getAuctionId() {
		return auctionId;
	}

	public void setAuctionId(Long auctionId) {
		this.auctionId = auctionId;
	}

	public Long getBidItemId() {
		return bidItemId;
	}

	public void setBidItemId(Long bidItemId) {
		this.bidItemId = bidItemId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getZone() {
		return zone;
	}

	public void setZone(String zone) {
		this.zone = zone;
	}

	public Double getMinBidPrice() {
		return minBidPrice;
	}

	public void setMinBidPrice(Double minBidPrice) {
		this.minBidPrice = minBidPrice;
	}

	public Double getMinBidIncrement() {
		return minBidIncrement;
	}

	public void setMinBidIncrement(Double minBidIncrement) {
		this.minBidIncrement = minBidIncrement;
	}

	public Date getBidStartTime() {
		return bidStartTime;
	}

	public void setBidStartTime(Date bidStartTime) {
		this.bidStartTime = bidStartTime;
	}

	public Date getBidEndTime() {
		return bidEndTime;
	}

	public void setBidEndTime(Date bidEndTime) {
		this.bidEndTime = bidEndTime;
	}

	public Integer getInitialStartTime() {
		return initialStartTime;
	}

	public void setInitialStartTime(Integer initialStartTime) {
		this.initialStartTime = initialStartTime;
	}

	public Integer getTimeExtAfterBid() {
		return timeExtAfterBid;
	}

	public void setTimeExtAfterBid(Integer timeExtAfterBid) {
		this.timeExtAfterBid = timeExtAfterBid;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public Date getLastUpDateTime() {
		return lastUpDateTime;
	}

	public void setLastUpDateTime(Date lastUpDateTime) {
		this.lastUpDateTime = lastUpDateTime;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public Date getCreatedTime() {
		return createdTime;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Double getCurrentMarketPrice() {
		return currentMarketPrice;
	}

	public void setCurrentMarketPrice(Double currentMarketPrice) {
		this.currentMarketPrice = currentMarketPrice;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getAuctionName() {
		return auctionName;
	}

	public void setAuctionName(String auctionName) {
		this.auctionName = auctionName;
	}
	

}
