package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.PurchaseOrderDetail;

public interface PODetailDao {
	public void save(PurchaseOrderDetail purchaseOrderDetail);
	
	public List<PurchaseOrderDetail> selectAll();
}
