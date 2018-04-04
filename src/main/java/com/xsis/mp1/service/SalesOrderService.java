package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.InventoryDao;
import com.xsis.mp1.dao.SalesOrderDao;
import com.xsis.mp1.dao.SalesOrderDetailDao;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.SalesOrder;
import com.xsis.mp1.model.SalesOrderDetail;
import com.xsis.mp1.model.Variant;

@Service
@Transactional
public class SalesOrderService {

	@Autowired
	SalesOrderDao salesOrderDao; 
	
	@Autowired
	InventoryDao inventoryDao; 
	
	@Autowired
	SalesOrderDetailDao salesOrderDetailDao; 
	
	public void save(SalesOrder salesOrder) {
		// TODO Auto-generated method stub
		//salesOrderDao.save(salesOrder);  
		/*List<SalesOrderDetail> sodetails = salesOrder.getSalesOrderDetails(); 
		for(SalesOrderDetail salesOrderDetail : sodetails) {
			Inventory inventory = inventoryDao.getVariant(salesOrderDetail.getVariant().getId());
			inventory.setEndingQty(inventory.getEndingQty()-salesOrderDetail.getQty());
			inventory.setSalesOrderQty(salesOrderDetail.getQty());
			inventoryDao.update(inventory);*/
	
			SalesOrder so = new SalesOrder();
			so.setCustomer(salesOrder.getCustomer());
			so.setGrandTotal(salesOrder.getGrandTotal());
			so.setCreatedBy(salesOrder.getCreatedBy());
			so.setModifiedBy(salesOrder.getModifiedBy());
			salesOrderDao.save(so);
			
			for(SalesOrderDetail sod : salesOrder.getSalesOrderDetails()) {
				Variant variant = new Variant();
				variant.setId(sod.getVariant().getId());
				SalesOrderDetail salesOrderDetails = new SalesOrderDetail();
				salesOrderDetails.setVariant(variant);
				salesOrderDetails.setSalesOrder(so);
				salesOrderDetails.setQty(sod.getQty());
				salesOrderDetails.setSubTotal(sod.getSubTotal());
				salesOrderDetails.setUnitPrice(sod.getUnitPrice());
				salesOrderDetails.setCreatedBy(sod.getCreatedBy());
				salesOrderDetails.setModifiedBy(sod.getModifiedBy());
				salesOrderDetailDao.save(salesOrderDetails);
			}
		}

	public List<SalesOrder> selectAll() {
		// TODO Auto-generated method stub
		return salesOrderDao.selectAll();
	}

	public void updateStock(SalesOrder salesOrder) {
		// TODO Auto-generated method stub
		List<SalesOrderDetail> sodetails = salesOrder.getSalesOrderDetails();
		for(SalesOrderDetail  salesOrderDetail :  sodetails) {
			Inventory inventory =  inventoryDao.getVariant(salesOrderDetail.getVariant().getId());
			inventory.setEndingQty(inventory.getEndingQty()-salesOrderDetail.getQty());
		}
	}

}
