package com.xsis.mp1.service;

import java.util.Date;
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
			/*Inventory inv = new Inventory(); 
			inv.setVariant(salesOrderDetail.getVariant());
			System.out.println("y : " + inventory.getEndingQty());
			int awal = inventory.getEndingQty(); 
			int pengurang = salesOrderDetail.getQty(); 
			int hasil = awal-pengurang ;
			inv.setId(inventory.getId());
			inv.setEndingQty(hasil);
			inv.setSalesOrderQty(salesOrderDetail.getQty());
			inv.setBeginning(inventory.getBeginning());
			inv.setModifiedOn(new Date());
			inventoryDao.update(inv);*/ 
			//System.out.println(salesOrderDetail.getVariant().getId());
		}
	}

}
