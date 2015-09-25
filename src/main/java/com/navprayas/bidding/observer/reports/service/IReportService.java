package com.navprayas.bidding.observer.reports.service;

import java.util.List;
import java.util.Set;

import com.navprayas.bidding.common.dto.ReportVO;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.Bids;

public interface IReportService {
	
	public List<Bids> getReportSummary1(String userName, ReportVO reportVO,Long clientId);
	public  List<Bids> getBidsForCategoryObserverReportSummary1(ReportVO reportVO, String userName,Long clientId);
	public  Set<String> getLotsList(String userName);
	public  List<BidItem> getBidsForLotsObserverReportSummary1(long lotid, String userName);
	public  List<Bids> getBidsForLotsObserverReportSummary1(ReportVO reportVO, String userName,Long clientId);
}
