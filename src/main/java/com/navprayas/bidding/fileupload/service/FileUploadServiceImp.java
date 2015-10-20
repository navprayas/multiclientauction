package com.navprayas.bidding.fileupload.service;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.cretateauction.dao.CreateAuctionDao;
import com.navprayas.bidding.fileupload.dao.FileUploadDao;
import com.navprayas.bidding.fileupload.entity.BidItemEntity;
import com.navprayas.bidding.fileupload.entity.ItemLotEntity;

@Service("fileUploadServiceImp")
@Transactional
public class FileUploadServiceImp implements FileUploadService {
	@Autowired
	FileUploadDao fileUploadDao;
	@Autowired
	private CreateAuctionDao createAuctionDao;

	public String saveAuctionData(BidItemEntity bidItemEntity1,
			Long selectedAuctionId, Long userId) throws IOException {
		ByteArrayInputStream inputStream = (ByteArrayInputStream) bidItemEntity1
				.getFile().getInputStream();

		POIFSFileSystem fs = new POIFSFileSystem(inputStream);
		HSSFWorkbook wb = new HSSFWorkbook(fs);
		String auctionId = null;
		Auction createAuction = null;
		HSSFSheet sheet = wb.getSheetAt(0);
		if (selectedAuctionId == null || selectedAuctionId == -1L) {
			createAuction = new Auction();
			createAuction.setName(sheet.getSheetName());
			createAuction.setIsApproved("1");
			createAuction.setStatus("Start");
			createAuction.setCreatedTime(new Timestamp(new Date().getTime()));
			createAuction.setUserId(userId);
			auctionId = this.createAuctionDao.save(createAuction);
		} else {
			createAuction = createAuctionDao
					.getAuctionForExcel(selectedAuctionId);
		}
		for (int i = 1; i <= sheet.getLastRowNum(); i++) {
			Row row = sheet.getRow(i);
			ItemLotEntity itemLotEntity = new ItemLotEntity();
			BidItemEntity bidItemEntity = new BidItemEntity();

			bidItemEntity.setName(row.getCell(4).getStringCellValue());
			bidItemEntity.setLocation(row.getCell(15).getStringCellValue());
			bidItemEntity.setCity(row.getCell(16).getStringCellValue());

			bidItemEntity.setMinBidPrice(Double.valueOf(row.getCell(11)
					.getNumericCellValue()));
			bidItemEntity.setMinBidIncrement(Double.valueOf(row.getCell(12)
					.getNumericCellValue()));
			bidItemEntity.setBidStartTime(null);
			bidItemEntity.setBidEndTime(null);
			bidItemEntity.setTimeExtn((int) row.getCell(13)
					.getNumericCellValue());
			bidItemEntity.setStatusCode("Start");
			bidItemEntity.setCategoryId(2);
			bidItemEntity.setMarketId(1);
			bidItemEntity.setCurrency(row.getCell(14).getStringCellValue());
			bidItemEntity
					.setLastUpdateTime(new Timestamp(new Date().getTime()));
			bidItemEntity.setCreatedTime(new Timestamp(new Date().getTime()));
			bidItemEntity.setAutobidid(0);
			bidItemEntity.setAutobiddername(null);
			bidItemEntity.setBiddername(null);
			bidItemEntity.setSerialNumber(Double.toString(row.getCell(0)
					.getNumericCellValue()));
			bidItemEntity.setCurrentMarketPrice(Double.valueOf(row.getCell(10)
					.getNumericCellValue()));
			bidItemEntity.setIsProcessed(null);
			bidItemEntity.setInitialStartTime(3);
			bidItemEntity.setDocument(null);

			bidItemEntity.setNocolum(row.getCell(6).getStringCellValue());

			itemLotEntity.setName(row.getCell(4).getStringCellValue());
			itemLotEntity.setLotId(bidItemEntity.getBidItemId());
			itemLotEntity.setBidItemId(bidItemEntity.getBidItemId());
			itemLotEntity.setLengthRange(row.getCell(7).getStringCellValue());
			itemLotEntity.setActualLength(null);
			itemLotEntity.setQuantity((int) row.getCell(8)
					.getNumericCellValue());
			itemLotEntity.setUnit(null);
			itemLotEntity.setCurrency(row.getCell(14).getStringCellValue());
			itemLotEntity.setRemark(row.getCell(5).getStringCellValue());
			itemLotEntity.setZone(row.getCell(9).getStringCellValue());
			itemLotEntity.setLOTNO((int) row.getCell(3).getNumericCellValue());

			BidSequence bidSequence = new BidSequence();
			bidSequence.setSequenceId(Long.valueOf(i));
			bidSequence.setAuction(createAuction);
			if (auctionId != null) {
				bidItemEntity.setAuctionId(Long.valueOf(Long
						.parseLong(auctionId)));

				this.fileUploadDao.saveAuctionDataDao(itemLotEntity,
						bidItemEntity, bidSequence);
			}
		}
		return null;
	}
}
