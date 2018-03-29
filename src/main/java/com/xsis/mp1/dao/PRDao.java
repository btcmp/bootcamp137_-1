package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.PurchaseRequest;

public interface PRDao {

	public List<PurchaseRequest> selectAll();

	public void save(PurchaseRequest pr);

	public PurchaseRequest getOne(PurchaseRequest pr);

	public void delete(PurchaseRequest pr);

}
