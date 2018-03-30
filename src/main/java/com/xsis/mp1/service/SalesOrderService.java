package com.xsis.mp1.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.SalesOrderDao;
import com.xsis.mp1.model.SalesOrder;

@Service
@Transactional
public class SalesOrderService {

	@Autowired
	SalesOrderDao salesOrderDao; 
	public void save(SalesOrder salesOrder) {
		// TODO Auto-generated method stub
		salesOrderDao.save(salesOrder);  
	}

}
