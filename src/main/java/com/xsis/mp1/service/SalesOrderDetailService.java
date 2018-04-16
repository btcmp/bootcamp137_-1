package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.SalesOrderDao;
import com.xsis.mp1.dao.SalesOrderDetailDao;
import com.xsis.mp1.model.SalesOrderDetail;

@Service
@Transactional
public class SalesOrderDetailService {
	
	@Autowired
	SalesOrderDetailDao salesOrderDetailDao;
	
	@Autowired
	SalesOrderDao salesOrderDao; 
	
	public List<SalesOrderDetail> selectAll(long idCustomer ){
		long idSo = salesOrderDao.getIdSalesOrder(idCustomer);
		System.out.println("id Sales Order : "+idSo);
		if(idSo != 0) {
			return salesOrderDetailDao.selectAll(idSo);
		}else {
			return null;
		}
	}
}
