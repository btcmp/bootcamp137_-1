package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.PurchaseOrderDetail;
import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseOrderDetail;

public interface PODetailDao {
	void save(PurchaseOrderDetail poDetail);

	List<PurchaseOrderDetail> selectPODetailByPO(PurchaseOrder po);

	void delete(PurchaseOrderDetail poDetails);

	List<PurchaseOrderDetail> selectPoDetailByPo(PurchaseOrder po);

	PurchaseOrderDetail getOne(long idPod);
}
