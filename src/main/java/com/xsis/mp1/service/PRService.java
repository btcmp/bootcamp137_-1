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
	
	
}
