package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseOrder;

public interface PODao {

	public List<PurchaseOrder> selectAll();

	public void save(PurchaseOrder po);

	public PurchaseOrder getOne(long id);

	public void delete(PurchaseOrder po);

	public void approve(long id);

	public void reject(long id);

	public void update(PurchaseOrder po);

	public int getRowsPR(int bln, int thn);

}
 