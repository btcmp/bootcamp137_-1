package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseOrderHistory;

public interface POHistoryDao {

	void save(PurchaseOrderHistory poh);

	List<PurchaseOrderHistory> selectHistoryByPO(PurchaseOrder po);

}
