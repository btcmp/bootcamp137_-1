package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.PurchaseRequestDetail;

public interface PRDetailDao {

	void save(PurchaseRequestDetail prDetail);

	List<PurchaseRequestDetail> selectPrDetailByPr(PurchaseRequest pr);

}
