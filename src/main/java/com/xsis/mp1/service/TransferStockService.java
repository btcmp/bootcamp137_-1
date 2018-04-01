package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.TransferStockDao;
import com.xsis.mp1.dao.TransferStockDetailDao;
import com.xsis.mp1.dao.TransferStockHistoryDao;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.PurchaseRequestDetail;
import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.model.TransferStockDetail;
import com.xsis.mp1.model.TransferStockHistory;

@Service
@Transactional
public class TransferStockService {

	@Autowired
	TransferStockDao tsDao;
	
	@Autowired
	TransferStockDetailDao tsdDao;
	
	@Autowired
	TransferStockHistoryDao tshDao;
	
	public List<TransferStock> selectAll() {
		List<TransferStock> tss = tsDao.selectAll();
		if(tss.isEmpty()) {
			return null;
		}else {
			for(TransferStock ts : tss) {
				List<TransferStockDetail> tsds = tsdDao.selectTsDetailByTS(ts);
				if(tsds.isEmpty()) {
					
				}else {
					ts.setTsDetails(tsds);
				}
			}
			return tss;
		}
	}

	public void save(TransferStock ts) {
		TransferStock tfs = new TransferStock();
		tfs.setId(ts.getId());
		tfs.setFromOutlet(ts.getFromOutlet());
		tfs.setToOutlet(ts.getToOutlet());
		tfs.setStatus(ts.getStatus());
		tfs.setNotes(ts.getNotes());
		tsDao.save(tfs);
		
		if(ts.getTsDetails()!=null) {
			for(TransferStockDetail tsDetails : ts.getTsDetails()) {
				TransferStockDetail tsDetail = new TransferStockDetail();
				tsDetail.setId(tsDetails.getId());
				tsDetail.setTransfer(tfs);
				tsDetail.setVariant(tsDetails.getVariant());
				tsDetail.setInStock(tsDetails.getInStock());
				tsDetail.setTransferQty(tsDetails.getTransferQty());
				tsdDao.save(tsDetail);
			}
		}
		
		TransferStockHistory tsh = new TransferStockHistory();
		tsh.setTransfer(tfs);
		tsh.setStatus(tfs.getStatus());
		tshDao.save(tsh);
	}

	public TransferStock getOne(long id) {
		TransferStock ts = tsDao.getOne(id);
		List<TransferStockDetail> tsds = tsdDao.selectTsDetailByTS(ts);
		List<TransferStockHistory> tshs = tshDao.selectHistoryByTS(ts);
		if(tsds.isEmpty()) {
			
		}else {
			ts.setTsDetails(tsds);
		}
		
		if(tshs.isEmpty()) {
			
		}else {
			ts.setTsHistories(tshs);
		}
		return ts;
	}
	
}
