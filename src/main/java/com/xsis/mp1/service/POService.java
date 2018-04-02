package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.PODao;
import com.xsis.mp1.model.PurchaseOrder;

@Service
@Transactional
public class POService {

	@Autowired
	PODao poDao;

	public List<PurchaseOrder> selectAll() {
		return poDao.selectAll();
	}

	public PurchaseOrder getOne(long id) {
		// TODO Auto-generated method stub
		return poDao.geOne(id);
	}
	
	
}
