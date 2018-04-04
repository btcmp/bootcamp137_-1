package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.SalesOrder;

public interface SalesOrderDao {

	public void  save(SalesOrder salesOrder);

	public List<SalesOrder> selectAll();

}
