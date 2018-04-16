package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.SalesOrderDetail;

public interface SalesOrderDetailDao {

	void save(SalesOrderDetail salesOrderDetails);

	List<SalesOrderDetail> selectAll(long salesOrder);

}
