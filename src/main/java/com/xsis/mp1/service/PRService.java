package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.PRDao;
import com.xsis.mp1.dao.PRDetailDao;
import com.xsis.mp1.dao.PRHistoryDao;
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

	public List<PurchaseRequest> selectAll() {
		return prDao.selectAll();
	}

	public void save(PurchaseRequest pr) {
		PurchaseRequest preq = new PurchaseRequest();
		preq.setId(pr.getId());
		preq.setOutletId(pr.getOutletId());
		preq.setPrNo(pr.getPrNo());
		preq.setReadyTime(pr.getReadyTime());
		preq.setStatus(pr.getStatus());
		preq.setNotes(pr.getNotes());
		prDao.save(preq);
		
		if(pr.getPrDetails()!=null) {
			for(PurchaseRequestDetail prDetails : pr.getPrDetails()) {
				PurchaseRequestDetail prDetail = new PurchaseRequestDetail();
				prDetail.setId(prDetails.getId());
				prDetail.setPr(preq);
				//prDetail.setVariantId(prd.getVariantId());
				prDetail.setRequestQty(prDetails.getRequestQty());
				prdDao.save(prDetail);
			}
		}
		
		PurchaseRequestHistory prh = new PurchaseRequestHistory();
		prh.setPr(preq);
		prh.setStatus(preq.getStatus());
		prhDao.save(prh);
	}

	public PurchaseRequest getOne(long id) {
		PurchaseRequest pr = new PurchaseRequest();
		pr.setId(id);
		pr.setStatus("0");
		pr.setPrNo("0");
		return prDao.getOne(pr);
	}

	public void delete(PurchaseRequest pr) {
		prDao.delete(pr);
	}
	
	
}
