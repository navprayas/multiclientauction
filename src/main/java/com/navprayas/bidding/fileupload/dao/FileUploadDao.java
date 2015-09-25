package com.navprayas.bidding.fileupload.dao;

import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.fileupload.entity.BidItemEntity;
import com.navprayas.bidding.fileupload.entity.ItemLotEntity;

public interface FileUploadDao {

	public void saveAuctionDataDao(ItemLotEntity itemLotEntity,
			BidItemEntity bidItemEntity, BidSequence bidSequence);
}
