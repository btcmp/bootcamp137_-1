package com.xsis.mp1.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.AdjustmentDao;
import com.xsis.mp1.dao.AdjustmentDetailDao;
import com.xsis.mp1.dao.AdjustmentHistoryDao;
import com.xsis.mp1.model.Adjustment;
import com.xsis.mp1.model.AdjustmentDetail;
import com.xsis.mp1.model.AdjustmentHistory;


@Service
@Transactional
public class AdjustmentService {

	@Autowired
	AdjustmentDao adjustmentDao;
	
	@Autowired
	AdjustmentHistoryDao adjustmentHystoryDao;
	
	@Autowired
	AdjustmentDetailDao adjustmentDetailDao;

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
		adj.setId(adjustment.getId());
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
				adjustmentDetail.setActualStock(adjustmentDetails.getActualStock());
				adjustmentDetailDao.save(adjustmentDetail);
			}
		}
		
		if(adjustment.getId() != 0 && adjustment.getStatus()=="created") {
			
		}else {
			AdjustmentHistory adjh = new AdjustmentHistory();
			adjh.setAdjusment(adj);
			adjh.setStatus(adj.getStatus());
			adjh.setCreatedOn(adj.getCreatedOn());
			adjustmentHystoryDao.save(adjh);
		}
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
			adj.setAdjustmentHistory(adjh);;
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
		adjh.setAdjusment(adj);
		adjh.setStatus(adj.getStatus());
		adjustmentHystoryDao.save(adjh);
	}

	public void reject(long id) {
		adjustmentDao.approve(id);
		Adjustment adj = adjustmentDao.getOne(id);
		AdjustmentHistory adjh = new AdjustmentHistory();
		adjh.setCreatedOn(new Date());
		adjh.setAdjusment(adj);
		adjh.setStatus(adj.getStatus());
		adjustmentHystoryDao.save(adjh);
	}

	public void createPo(long id) {
		adjustmentDao.approve(id);
		Adjustment adj = adjustmentDao.getOne(id);
		AdjustmentHistory adjh = new AdjustmentHistory();
		adjh.setCreatedOn(new Date());
		adjh.setAdjusment(adj);
		adjh.setStatus(adj.getStatus());
		adjustmentHystoryDao.save(adjh);
	}
	
	
}
