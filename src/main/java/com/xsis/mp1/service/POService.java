package com.xsis.mp1.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.PODao;
import com.xsis.mp1.dao.PODetailDao;
import com.xsis.mp1.dao.POHistoryDao;
import com.xsis.mp1.dao.PRDetailDao;
import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseOrderDetail;
import com.xsis.mp1.model.PurchaseOrderHistory;

@Service
@Transactional
public class POService {

	@Autowired
	PODao poDao;
	
	@Autowired
	POHistoryDao pohDao;
	
	@Autowired
	PODetailDao podDao;

	public List<PurchaseOrder> selectAll() {
		List<PurchaseOrder> pos = poDao.selectAll();
		if(pos.isEmpty()) {
			return null;
		}else {
			for(PurchaseOrder po : pos) {
				List<PurchaseOrderDetail> pods = podDao.selectPODetailByPO(po);
				if(pods.isEmpty()) {
					
				}else {
					po.setPurchaseOrderDetails(pods);
				}
			}
			return pos;
		}
	}

	public void save(PurchaseOrder po) {
		PurchaseOrder po2 = new PurchaseOrder();
		po2.setId(po.getId());
		po2.setOutletId(po.getOutletId());
		po2.setPoNo(po.getPoNo());
		po2.setStatus(po.getStatus());
		po2.setNotes(po.getNotes());
		
		//jika data ada, modifiednya aja yg ganti
		if(po2.getId()!=0) {
			po2.setModifiedOn(new Date());
			PurchaseOrder po3 = poDao.getOne(po2.getId());
			po2.setCreatedOn(po3.getCreatedOn());
		}else {
			po2.setCreatedOn(new Date());
		}
		
		poDao.save(po2);
		
		//hapus data lama
		List<PurchaseOrderDetail> pods = podDao.selectPODetailByPO(po2);
		if(pods == null) {
			
		}else {
			for(PurchaseOrderDetail prDetails : pods) {
				podDao.delete(prDetails);
			}
		}
		
		if(po.getPurchaseOrderDetails()!=null) {
			for(PurchaseOrderDetail poDetails : po.getPurchaseOrderDetails()) {
				PurchaseOrderDetail poDetail = new PurchaseOrderDetail();
				poDetail.setId(poDetails.getId());
				poDetail.setPurchaseOrder(po2);
				poDetail.setVariant(poDetails.getVariant());
				podDao.save(poDetail);
			}
		}
		
		if(po.getId() != 0 && po.getStatus()=="created") {
			
		}else {
			PurchaseOrderHistory poh = new PurchaseOrderHistory();
			poh.setPurchaseOrder(po2);
			poh.setStatus(po2.getStatus());
			poh.setCreatedOn(po2.getCreatedOn());
			pohDao.save(poh);
		}
	}

	public PurchaseOrder getOne(long id) {
		PurchaseOrder po = poDao.getOne(id);
		List<PurchaseOrderDetail> pods = podDao.selectPODetailByPO(po);
		List<PurchaseOrderHistory> pohs = pohDao.selectHistoryByPO(po);
		if(pods.isEmpty()) {
			
		}else {
			po.setPurchaseOrderDetails(pods);
		}
		
		if(pohs.isEmpty()) {
			
		}else {
			po.setPurchaseOrderHistories(pohs);
		}
		return po;
	}

	public void delete(PurchaseOrder pr) {
		poDao.delete(pr);
	}

	public void approve(long id) {
		poDao.approve(id);
		PurchaseOrder po = poDao.getOne(id);
		PurchaseOrderHistory poh = new PurchaseOrderHistory();
		poh.setCreatedOn(new Date());
		poh.setPurchaseOrder(po);
		poh.setStatus(po.getStatus());
		pohDao.save(poh);
	}

	public void reject(long id) {
		poDao.approve(id);
		PurchaseOrder po = poDao.getOne(id);
		PurchaseOrderHistory poh = new PurchaseOrderHistory();
		poh.setCreatedOn(new Date());
		poh.setPurchaseOrder(po);
		poh.setStatus(po.getStatus());
		pohDao.save(poh);
	}

	public void createPo(long id) {
		poDao.approve(id);
		PurchaseOrder po = poDao.getOne(id);
		PurchaseOrderHistory poh = new PurchaseOrderHistory();
		poh.setCreatedOn(new Date());
		poh.setPurchaseOrder(po);
		poh.setStatus(po.getStatus());
		pohDao.save(poh);
	}

	public void update(PurchaseOrder po) {
		PurchaseOrder po2 = new PurchaseOrder();
		po2.setId(po.getId());
		po2.setOutletId(po.getOutletId());
		po2.setPoNo(po.getPoNo());
		po2.setStatus(po.getStatus());
		po2.setNotes(po.getNotes());
		po2.setModifiedOn(new Date());
		PurchaseOrder po3 = poDao.getOne(po2.getId());
		po2.setCreatedOn(po3.getCreatedOn());
		po2.setPoNo(po3.getPoNo());
		po2.setSupplierId(po.getSupplierId());
		po2.setGrandTotal(po.getGrandTotal());
		po2.setPrId(po.getPrId());
		poDao.update(po2);
		
		List<PurchaseOrderDetail> pods = podDao.selectPODetailByPO(po2);
		if(pods == null) {
			
		}else {
			for(PurchaseOrderDetail pod : pods) {
				podDao.delete(pod);
			}
		}
		
		if(po.getPurchaseOrderDetails()!=null) {
			for(PurchaseOrderDetail pod : po.getPurchaseOrderDetails()) {
				PurchaseOrderDetail pod2 = new PurchaseOrderDetail();
				pod2.setId(pod.getId());
				pod2.setCreatedOn(po2.getCreatedOn());
				pod2.setModifiedOn(po2.getModifiedOn());
				pod2.setPurchaseOrder(po2);
				pod2.setVariant(pod.getVariant());
				pod2.setRequestQty(pod.getRequestQty());
				pod2.setSubTotal(pod.getSubTotal());
				pod2.setUnitCost(pod.getUnitCost());
				podDao.save(pod2);
			}
		}
	}
	
	
}
