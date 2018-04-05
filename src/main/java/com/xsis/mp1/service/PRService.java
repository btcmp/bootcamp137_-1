package com.xsis.mp1.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.InventoryDao;
import com.xsis.mp1.dao.PODao;
import com.xsis.mp1.dao.PODetailDao;
import com.xsis.mp1.dao.POHistoryDao;
import com.xsis.mp1.dao.PRDao;
import com.xsis.mp1.dao.PRDetailDao;
import com.xsis.mp1.dao.PRHistoryDao;
import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseOrderDetail;
import com.xsis.mp1.model.PurchaseOrderHistory;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.PurchaseRequestDetail;
import com.xsis.mp1.model.PurchaseRequestHistory;

@Service
@Transactional
public class PRService {

	@Autowired
	PRDao prDao;
	
	@Autowired
	PRHistoryDao prhDao;
	
	@Autowired
	PRDetailDao prdDao;
	
	@Autowired
	PODao poDao;
	
	@Autowired
	PODetailDao podDao;
	
	@Autowired
	POHistoryDao pohDao;
	
	@Autowired
	InventoryDao invDao;

	public List<PurchaseRequest> selectAll() {
		List<PurchaseRequest> prs = prDao.selectAll();
		if(prs.isEmpty()) {
			return null;
		}else {
			for(PurchaseRequest pr : prs) {
				List<PurchaseRequestDetail> prds = prdDao.selectPrDetailByPr(pr);
				if(prds.isEmpty()) {
					
				}else {
					pr.setPrDetails(prds);
				}
			}
			return prs;
		}
	}

	public void save(PurchaseRequest pr) {
		PurchaseRequest preq = new PurchaseRequest();
		preq.setId(pr.getId());
		preq.setOutletId(pr.getOutletId());
		preq.setPrNo(pr.getPrNo());
		preq.setReadyTime(pr.getReadyTime());
		preq.setStatus(pr.getStatus());
		preq.setNotes(pr.getNotes());
		
		//jika data ada, modifiednya aja yg ganti
		if(preq.getId()!=0) {
			preq.setModifiedOn(new Date());
			PurchaseRequest prc = prDao.getOne(preq.getId());
			preq.setCreatedOn(prc.getCreatedOn());
		}else {
			preq.setCreatedOn(new Date());
		}
		
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yy");
		Date date = new Date();
		String tgl = dateFormat.format(date);
		
		Calendar cal = Calendar.getInstance();
		int thn = cal.get(Calendar.YEAR);
		int bln = cal.get(Calendar.MONTH)+1;
		int no = prDao.getRowsPR(bln, thn)+1;
		String nomor;
		
		if(no < 10) {
			nomor = "00"+no;
		} else if(no < 100) {
			nomor = "0"+no;
		} else {
			nomor = Integer.toString(no);
		}
		
		String prNo = "PR/"+"KEL1/"+tgl+"/"+nomor;
		
		if(preq.getId()!=0) {
			preq.setPrNo(pr.getPrNo());
		}else {
			preq.setPrNo(prNo);
		}
		
		prDao.save(preq);
		
		//hapus data lama
		List<PurchaseRequestDetail> prds = prdDao.selectPrDetailByPr(preq);
		if(prds == null) {
			
		}else {
			for(PurchaseRequestDetail prDetails : prds) {
				prdDao.delete(prDetails);
			}
		}
		
		if(pr.getPrDetails()!=null) {
			for(PurchaseRequestDetail prDetails : pr.getPrDetails()) {
				PurchaseRequestDetail prDetail = new PurchaseRequestDetail();
				prDetail.setId(prDetails.getId());
				prDetail.setPr(preq);
				prDetail.setVariant(prDetails.getVariant());
				prDetail.setRequestQty(prDetails.getRequestQty());
				prdDao.save(prDetail);
			}
		}
		
		if(pr.getId() != 0 && pr.getStatus().equals("Created")) {
			
		}else {
			PurchaseRequestHistory prh = new PurchaseRequestHistory();
			prh.setPr(preq);
			prh.setStatus(preq.getStatus());
			prh.setCreatedOn(preq.getCreatedOn());
			prhDao.save(prh);
		}
	}

	public PurchaseRequest getOne(long id) {
		PurchaseRequest pr = prDao.getOne(id);
		List<PurchaseRequestDetail> prds = prdDao.selectPrDetailByPr(pr);
		List<PurchaseRequestHistory> prhs = prhDao.selectHistoryByPR(pr);
		if(prds.isEmpty()) {
			
		}else {
			pr.setPrDetails(prds);
		}
		
		if(prhs.isEmpty()) {
			
		}else {
			pr.setPrHistories(prhs);
		}
		return pr;
	}

	public void delete(PurchaseRequest pr) {
		prDao.delete(pr);
	}

	public void approve(long id) {
		prDao.approve(id);
		PurchaseRequest pr = prDao.getOne(id);
		PurchaseRequestHistory prh = new PurchaseRequestHistory();
		prh.setCreatedOn(new Date());
		prh.setPr(pr);
		prh.setStatus(pr.getStatus());
		prhDao.save(prh);
	}

	public void reject(long id) {
		prDao.reject(id);
		PurchaseRequest pr = prDao.getOne(id);
		PurchaseRequestHistory prh = new PurchaseRequestHistory();
		prh.setCreatedOn(new Date());
		prh.setPr(pr);
		prh.setStatus(pr.getStatus());
		prhDao.save(prh);
	}

	public void createPo(long id) {
		prDao.createPo(id);
		PurchaseRequest pr = prDao.getOne(id);
		
		List<PurchaseRequestDetail> prds = prdDao.selectPrDetailByPr(pr);
		
		if(prds.isEmpty()) {
			
		}else {
			pr.setPrDetails(prds);
		}
		
		PurchaseRequestHistory prh = new PurchaseRequestHistory();
		prh.setCreatedOn(new Date());
		prh.setPr(pr);
		prh.setStatus(pr.getStatus());
		prhDao.save(prh);
		
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
		
		PurchaseOrder po = new PurchaseOrder();
		po.setCreatedOn(new Date());
		po.setNotes(pr.getNotes());
		po.setPoNo(poNo);
		po.setPrId(pr);
		po.setStatus("PO Created");
		po.setOutletId(pr.getOutletId());
		poDao.save(po);
		if(pr.getPrDetails() == null) {
			
		}else {
			for(PurchaseRequestDetail prd : pr.getPrDetails()) {
				PurchaseOrderDetail pod = new PurchaseOrderDetail();
				pod.setCreatedOn(po.getCreatedOn());
				pod.setPurchaseOrder(po);
				pod.setRequestQty(prd.getRequestQty());
				pod.setVariant(prd.getVariant());
				podDao.save(pod);
			}
		}
		
		PurchaseOrderHistory poh = new PurchaseOrderHistory();
		poh.setCreatedOn(po.getCreatedOn());
		poh.setPurchaseOrder(po);
		poh.setStatus(po.getStatus());
		pohDao.save(poh);
	}

	public List<Object> getInventoryByVariantAndOutlet(long idPrd, long idPr) {
		PurchaseRequest pr = prDao.getOne(idPr);
		PurchaseRequestDetail prd = prdDao.getOne(idPrd);
		return invDao.searchInventoryByVariantAndOutlet(prd.getVariant());
	}

	public List<PurchaseRequest> getPRByStatus(String status) {
		return prDao.searchPRByStatus(status);
	}

	public List<PurchaseRequest> getPRByGlobal(String global) {
		return prDao.searchPRByGlobal(global);
	}

	public void submitted(long id) {
		prDao.submitted(id);
		PurchaseRequest pr = prDao.getOne(id);
		PurchaseRequestHistory prh = new PurchaseRequestHistory();
		prh.setCreatedOn(new Date());
		prh.setPr(pr);
		prh.setStatus(pr.getStatus());
		prhDao.save(prh);
	}
	
	
}
