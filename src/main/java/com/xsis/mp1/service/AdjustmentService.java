package com.xsis.mp1.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.AdjustmentDao;
import com.xsis.mp1.dao.AdjustmentDetailDao;
import com.xsis.mp1.dao.AdjustmentHistoryDao;
import com.xsis.mp1.dao.InventoryDao;
import com.xsis.mp1.model.Adjustment;
import com.xsis.mp1.model.AdjustmentDetail;
import com.xsis.mp1.model.AdjustmentHistory;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.PurchaseRequestDetail;
import com.xsis.mp1.model.Variant;


@Service
@Transactional
public class AdjustmentService {

	@Autowired
	AdjustmentDao adjustmentDao;
	
	@Autowired
	AdjustmentHistoryDao adjustmentHystoryDao;
	
	@Autowired
	AdjustmentDetailDao adjustmentDetailDao;
	
	@Autowired
	InventoryDao invDao;

	public List<Adjustment> selectAll() {
		List<Adjustment> adj = adjustmentDao.selectAll();
		if(adj.isEmpty()) {
			return null;
		}else {
			for(Adjustment adjustment : adj) {
				List<AdjustmentDetail> adjd = adjustmentDetailDao.selectAdjustmentDetailByadjustment(adjustment);
		 		if(adjd.isEmpty()) {
					
				}else {
					adjustment.setAdjustmentDetails(adjd);
				}
	 		}
			return adj;
		}
	}

	public void save(Adjustment adjustment) {
		Adjustment adj = new Adjustment();
		adj.setOutlet(adjustment.getOutlet());
		adj.setStatus(adjustment.getStatus());
		adj.setNotes(adjustment.getNotes());
		
		//jika data ada, modifiednya aja yg ganti
		if(adj.getId()!=0) {
			adj.setModifiedOn(new Date());
			Adjustment adj2 = adjustmentDao.getOne(adj.getId());
			adj.setCreatedOn(adj2.getCreatedOn());
		}else {
			adj.setCreatedOn(new Date());
		}
		
		adjustmentDao.save(adj);
		
		//hapus data lama
		List<AdjustmentDetail> adjd = adjustmentDetailDao.selectAdjustmentDetailByadjustment(adj);
		if(adjd == null) {
			
		}else {
			for(AdjustmentDetail adjustmentDetail : adjd) {
				adjustmentDetailDao.delete(adjustmentDetail);
			}
		}
		
		if(adjustment.getAdjustmentDetails()!=null) {
			for(AdjustmentDetail adjustmentDetails : adjustment.getAdjustmentDetails()) {
				AdjustmentDetail adjustmentDetail = new AdjustmentDetail();
				adjustmentDetail.setId(adjustmentDetails.getId());
				adjustmentDetail.setAdjustment(adj);
				adjustmentDetail.setVariant(adjustmentDetails.getVariant());
				System.out.println("get Instock "+adjustmentDetails);
				adjustmentDetail.setInStock(adjustmentDetails.getInStock());
				adjustmentDetail.setActualStock(adjustmentDetails.getActualStock());
				adjustmentDetailDao.save(adjustmentDetail);
			}
		}
		
		if(adjustment.getAdjustmentHistory()!=null) {
			for(AdjustmentHistory adjustmentHistory : adjustment.getAdjustmentHistory()) {
				AdjustmentHistory adjustmentH = new AdjustmentHistory();
				adjustmentH.setId(adjustmentHistory.getId());
				adjustmentH.setAdjustment(adj);;
				System.out.println(adj.getId());
				adjustmentH.setStatus(adjustmentHistory.getStatus());
				adjustmentHystoryDao.save(adjustmentH);
				System.out.println("adjustment "+adj.getId());
			}
		}
		
			/*AdjustmentHistory adjh = new AdjustmentHistory();
			Adjustment adj2= new Adjustment();
			adj2.setId(adj.getId());
			adj2.setAdjustmentDetails(adj.getAdjustmentDetails());
			adj2.setAdjustmentHistory(adj.getAdjustmentHistory());
			adj2.setNotes(adj.getNotes());
			adj2.setOutlet(adj.getOutlet());
			System.out.println(adj2.getId());
			System.out.println("ada");
			adjh.setAdjusment(adj2);
			System.out.println(adj2.getId());
			
			System.out.println("ini id adjustment dari history "+adjh.getAdjustment());
			System.out.println(adj2.getId());
			adjh.setStatus(adj.getStatus());
			adjh.setCreatedOn(adj.getCreatedOn());
			adjustmentHystoryDao.save(adjh);*/
		
	}

	public Adjustment getOne(long id) {
		Adjustment adj = adjustmentDao.getOne(id);
		List<AdjustmentDetail> adjd = adjustmentDetailDao.selectAdjustmentDetailByadjustment(adj);
		List<AdjustmentHistory> adjh = adjustmentHystoryDao.selectHistoryByAdjustment(adj);
		if(adjd.isEmpty()) {
			
		}else {
			adj.setAdjustmentDetails(adjd);
		}
		
		if(adjh.isEmpty()) {
			
		}else {
			adj.setAdjustmentHistory(adjh);
		}
		return adj;
	}

	public void delete(Adjustment adj) {
		adjustmentDao.delete(adj);
	}

	public void approve(long id) {
		adjustmentDao.approve(id);
		Adjustment adj = adjustmentDao.getOne(id);
		AdjustmentHistory adjh = new AdjustmentHistory();
		adjh.setCreatedOn(new Date());
		adjh.setAdjustment(adj);;
		adjh.setStatus(adj.getStatus());
		adjustmentHystoryDao.save(adjh);
		
		long idOutlet = adj.getOutlet().getId();
		List<AdjustmentDetail> adjd=adj.getAdjustmentDetails();
		for(AdjustmentDetail adjd2 : adjd) {
			long idVar=adjd2.getVariant().getId();
			adjd2.setActualStock(adjd2.getActualStock());
			adjd2.setAdjustment(adj);
			adjd2.setInStock(adjd2.getInStock());
			adjd2.setCreatedBy(adjd2.getCreatedBy());
			adjd2.setVariant(adjd2.getVariant());
			Inventory inv=invDao.searchInventoryByVarAndOutlet(idVar, idOutlet);
			inv.setAdjustementqty(inv.getAdjustementqty()+(inv.getEndingQty()-adjd2.getActualStock()));
			System.out.println(inv.getEndingQty()-adjd2.getActualStock());
			inv.setEndingQty(adjd2.getActualStock());
		}
	}

	public void reject(long id) {
		adjustmentDao.reject(id);
		Adjustment adj = adjustmentDao.getOne(id);
		AdjustmentHistory adjh = new AdjustmentHistory();
		adjh.setCreatedOn(new Date());
		adjh.setAdjustment(adj);;
		adjh.setStatus(adj.getStatus());
		adjustmentHystoryDao.save(adjh);
	}

	

	public void setInventory(long id) {
		List<AdjustmentDetail> detAdjustments = adjustmentDetailDao.searchById(id);
		for(AdjustmentDetail detAdj : detAdjustments) {
			Inventory inv = invDao.searchEndingQtyByLastModifiedVariant(detAdj.getVariant().getId());
			
			Inventory ii = new Inventory();
			ii.setVariant(detAdj.getVariant());
			ii.setEndingQty(detAdj.getActualStock());
			ii.setAdjustementqty(detAdj.getActualStock());
			ii.setModifiedOn(new Date());
			if(inv != null) {
				ii.setAlertAtQty(inv.getAlertAtQty());
				ii.setBeginning(inv.getEndingQty());
			}else {
				ii.setAlertAtQty(5);
				ii.setBeginning(50);
			}
			invDao.save(ii);
		}
		adjustmentDao.setInventory(id);
		
	}

	public List<Adjustment> getAdjByDate(Date awal, Date akhir) {
		Date startDate = awal;
		Calendar cal = Calendar.getInstance(); 
		cal.setTime(startDate); 
		cal.add(Calendar.DATE, -1);
		startDate = cal.getTime();
		
		Date endDate = akhir;
		Calendar cal2 = Calendar.getInstance(); 
		cal2.setTime(endDate); 
		cal2.add(Calendar.DATE, 1);
		endDate = cal2.getTime();
		return adjustmentDao.searchAdjByDate(startDate, endDate);
	}
	

	
}
