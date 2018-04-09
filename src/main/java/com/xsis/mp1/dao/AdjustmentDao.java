package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;

import com.xsis.mp1.model.Adjustment;

public interface AdjustmentDao {
	public List<Adjustment> selectAll();

	public void save(Adjustment adjustment);

	public Adjustment getOne(long id);

	public void delete(Adjustment adjustment);

	public void approve(long id);

	public void reject(long id);

	public void createPo(long id);

	//public void setInventory(long id);
	
} 
