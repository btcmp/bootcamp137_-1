package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.PRDao;
import com.xsis.mp1.model.PurchaseRequest;

@Service
@Transactional
public class PRService {

	@Autowired
	PRDao prDao;

	public List<PurchaseRequest> selectAll() {
		return prDao.selectAll();
	}

	public void save(PurchaseRequest pr) {
		prDao.save(pr);
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
