package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.InventoryDao;
import com.xsis.mp1.dao.SalesOrderDao;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.SalesOrder;
import com.xsis.mp1.model.SalesOrderDetail;

@Service
@Transactional
public class SalesOrderService {

	@Autowired
	SalesOrderDao salesOrderDao; 
	
	@Autowired
	InventoryDao inventoryDao; 
	
	public void save(SalesOrder salesOrder) {
		// TODO Auto-generated method stub
		salesOrderDao.save(salesOrder);  
		List<SalesOrderDetail> sodetails = salesOrder.getSalesOrderDetails(); 
		for(SalesOrderDetail salesOrderDetail : sodetails) {
			Inventory inventory = inventoryDao.getVariant(salesOrderDetail.getVariant().getId());
			inventory.setEndingQty(inventory.getEndingQty()-salesOrderDetail.getQty());
			inventory.setSalesOrderQty(salesOrderDetail.getQty());
			inventoryDao.update(inventory);
		}
	}

	public List<SalesOrder> selectAll() {
		// TODO Auto-generated method stub
		return salesOrderDao.selectAll();
	}

}
