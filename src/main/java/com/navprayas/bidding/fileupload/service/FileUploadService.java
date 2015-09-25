package com.navprayas.bidding.fileupload.service;


import java.io.IOException;

import com.navprayas.bidding.fileupload.entity.BidItemEntity;


public interface FileUploadService {

	public String saveAuctionData(BidItemEntity bidItemEntity, Long selectedAuctionId,Long userId) throws IOException ;
}
