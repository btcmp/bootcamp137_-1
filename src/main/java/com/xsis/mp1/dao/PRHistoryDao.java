package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.PurchaseRequestHistory;

public interface PRHistoryDao {

	void save(PurchaseRequestHistory prh);

	List<PurchaseRequestHistory> selectHistoryByPR(PurchaseRequest pr);

}
