package com.xsis.mp1.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.InventoryDao;
import com.xsis.mp1.dao.PODao;
import com.xsis.mp1.dao.PODetailDao;
import com.xsis.mp1.dao.POHistoryDao;
import com.xsis.mp1.dao.PRDetailDao;
import com.xsis.mp1.dao.SupplierDao;
import com.xsis.mp1.dao.UserDao;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseOrderDetail;
import com.xsis.mp1.model.PurchaseOrderHistory;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.PurchaseRequestDetail;
import com.xsis.mp1.model.PurchaseRequestHistory;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.model.User;

@Service
@Transactional
public class POService {

	@Autowired
	PODao poDao;
	
	@Autowired
	POHistoryDao pohDao;
	
	@Autowired
	PODetailDao podDao;
	
	@Autowired
	InventoryDao invDao;
	
	@Autowired
	SupplierDao supDao;
	
	@Autowired
	HttpSession httpSession;
	
	@Autowired
	UserDao userDao;

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
		User user = (User) httpSession.getAttribute("usernya");
		PurchaseOrder po2 = new PurchaseOrder();
		po2.setId(po.getId());
		po2.setOutletId(po.getOutletId());
		po2.setPoNo(po.getPoNo());
		po2.setStatus(po.getStatus());
		po2.setNotes(po.getNotes());
		
		//jika data ada, modifiednya aja yg ganti
		if(po2.getId()!=0) {
			po2.setModifiedBy(user.getId());
			po2.setModifiedOn(new Date());
			PurchaseOrder po3 = poDao.getOne(po2.getId());
			po2.setCreatedOn(po3.getCreatedOn());
		}else {
			po2.setCreatedBy(user.getId());
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
				poDetail.setCreatedBy(user.getId());
				poDetail.setPurchaseOrder(po2);
				poDetail.setVariant(poDetails.getVariant());
				podDao.save(poDetail);
			}
		}
		
		if(po.getId() != 0 && po.getStatus()=="created") {
			
		}else {
			PurchaseOrderHistory poh = new PurchaseOrderHistory();
			poh.setPurchaseOrder(po2);
			poh.setCreatedBy(user.getId());
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

	public void delete(PurchaseOrder po) {
		poDao.delete(po);
	}

	public void approve(long id) {
		User user = (User) httpSession.getAttribute("usernya");
		poDao.approve(id);
		PurchaseOrder po = poDao.getOne(id);
		PurchaseOrderHistory poh = new PurchaseOrderHistory();
		poh.setCreatedOn(new Date());
		poh.setPurchaseOrder(po);
		poh.setStatus(po.getStatus());
		poh.setCreatedBy(user.getId());
		pohDao.save(poh);
	}

	public void reject(long id) {
		User user = (User) httpSession.getAttribute("usernya");
		poDao.reject(id);
		PurchaseOrder po = poDao.getOne(id);
		PurchaseOrderHistory poh = new PurchaseOrderHistory();
		poh.setCreatedOn(new Date());
		poh.setPurchaseOrder(po);
		poh.setStatus(po.getStatus());
		poh.setCreatedBy(user.getId());
		pohDao.save(poh);
	}

	public void process(long id) {
		User user = (User) httpSession.getAttribute("usernya");
		poDao.process(id);
		PurchaseOrder po = poDao.getOne(id);
		
		List<PurchaseOrderDetail> pods = podDao.selectPoDetailByPo(po);
		
		if(pods.isEmpty()) {
			
		}else {
			po.setPurchaseOrderDetails(pods);
			po.setCreatedBy(user.getId());
		}
		
		
		
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yy");
		Date date = new Date();
		String tgl = dateFormat.format(date);
		
		Calendar cal = Calendar.getInstance();
		int thn = cal.get(Calendar.YEAR);
		int bln = cal.get(Calendar.MONTH)+1;
		int no = poDao.getRowsPR(bln, thn)+1;
		String nomor;
		
		if(no < 10) {
			nomor = "00"+no;
		} else if(no < 100) {
			nomor = "0"+no;
		} else {
			nomor = Integer.toString(no);
		}
		
		String poNo = "PO/"+"KEL1/"+tgl+"/"+nomor;
		
		
		PurchaseOrderHistory poh = new PurchaseOrderHistory();
		poh.setCreatedOn(new Date());
		poh.setPurchaseOrder(po);
		poh.setStatus(po.getStatus());
		pohDao.save(poh);

	}

	public void update(PurchaseOrder po) {
		User user = (User) httpSession.getAttribute("usernya");
		
		PurchaseOrder po2 = new PurchaseOrder();
		po2.setId(po.getId());
		po2.setOutletId(po.getOutletId());
		po2.setPoNo(po.getPoNo());
		po2.setStatus(po.getStatus());
		po2.setNotes(po.getNotes());
		po2.setModifiedOn(new Date());
		PurchaseOrder po3 = poDao.getOne(po2.getId());
		po2.setCreatedBy(user.getId());
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
				pod2.setCreatedBy(user.getId());
				podDao.save(pod2);
			}
		}
	}

	public List<Object> getInventoryByVariantAndOutlet(long idPod, long idPo) {
		PurchaseOrder po = poDao.getOne(idPo);
		PurchaseOrderDetail pod = podDao.getOne(idPod);
		return invDao.searchInventoryByVariantAndOutlet(pod.getVariant());
	}

	public Supplier getSupplierByPo(long idPo, long idSup) {
		PurchaseOrder po = poDao.getOne(idPo);
		Supplier sup= new Supplier();
		sup.setId(idSup);
		supDao.getOne(sup);
		return sup;
	}

	public List<PurchaseOrder> getPOByDate(Date awal, Date akhir) {
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
		return poDao.searchPOByDate(startDate, endDate);
	}

	public List<PurchaseOrder> getPOByStatus(String status) {
		return poDao.searchPOByStatus(status);
	}

	public List<PurchaseOrder> getPOByGlobal(String global) {
		return poDao.searchPOByGlobal(global);
	}

	public List<Object> getUsernameByPOId(long id) {
		return userDao.getUsernameByPOId(id);
	}

	public int getPoNeedAction() {
		// TODO Auto-generated method stub
		return poDao.getPoNeedAction();
	}

	
	
}
