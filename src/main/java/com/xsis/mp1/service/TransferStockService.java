package com.xsis.mp1.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.InventoryDao;
import com.xsis.mp1.dao.TransferStockDao;
import com.xsis.mp1.dao.TransferStockDetailDao;
import com.xsis.mp1.dao.TransferStockHistoryDao;
import com.xsis.mp1.model.Inventory;
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
	
	@Autowired
	InventoryDao inventoryDao;
	
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

	public void approve(long id) {
		
		TransferStock tstok = tsDao.getOne(id);
		
		//TransferStock tstok = new TransferStock();
		
		long idToOutlet = tstok.getToOutlet().getId();
		long idFromOutlet = tstok.getFromOutlet().getId();
		List<TransferStockDetail> TSD = tsdDao.getTfStockByTfStockId(tstok.getId());
		for(TransferStockDetail TSDetail : TSD) {
			long variantId = TSDetail.getVariant().getId();
			Inventory invent = inventoryDao.searchInventoryByVarAndOutlet(variantId, idFromOutlet);
			invent.setEndingQty(invent.getEndingQty()-TSDetail.getTransferQty());
			
			Inventory iv = inventoryDao.searchInventoryByVarAndOutlet(variantId, idToOutlet);
			if (iv != null) {
				iv.setEndingQty(invent.getEndingQty()+TSDetail.getTransferQty());
			} else {
				Inventory ivNew = new Inventory();
				ivNew.setAdjustementqty(0);
				ivNew.setAlertAtQty(1);
				ivNew.setBeginning(TSDetail.getTransferQty());
				ivNew.setEndingQty(TSDetail.getTransferQty());
				ivNew.setVariant(TSDetail.getVariant());
				ivNew.setOutlet(tstok.getToOutlet());
				ivNew.setCreatedBy(0);
				ivNew.setModifiedBy(0);
				ivNew.setPurchaseQty(0);
				ivNew.setSalesOrderQty(0);
				ivNew.setTransferStockQty(0);
				inventoryDao.save(ivNew);
			}
		}
		tsDao.approve(id);
		//TransferStock ts = tsDao.getOne(id);
		TransferStockHistory tsh = new TransferStockHistory();
		tsh.setCreatedOn(new Date());
		tsh.setTransfer(tstok);
		tsh.setStatus(tstok.getStatus());
		tshDao.save(tsh);
	}

	public void reject(long id) {
		tsDao.reject(id);
		TransferStock ts = tsDao.getOne(id);
		TransferStockHistory tsh = new TransferStockHistory();
		tsh.setCreatedOn(new Date());
		tsh.setTransfer(ts);
		tsh.setStatus(ts.getStatus());
		tshDao.save(tsh);
	}

	public void updateStockInventory(long id) {
		tsDao.approve(id);
		
		
	}

	public void updateStock(TransferStock ts) {
		
	}

	public List<TransferStock> getTSByOutlet(long cari) {
		return tsDao.searchTSByOutlet(cari);
	}
	
}
