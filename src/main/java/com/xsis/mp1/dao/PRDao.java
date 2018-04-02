package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.PurchaseRequest;

public interface PRDao {

	public List<PurchaseRequest> selectAll();

	public void save(PurchaseRequest pr);

	public PurchaseRequest getOne(long id);

	public void delete(PurchaseRequest pr);

	public void approve(long id);

	public void reject(long id);

	public void createPo(long id);

	public List<PurchaseRequest> searchPRByStatus(String status);

}
