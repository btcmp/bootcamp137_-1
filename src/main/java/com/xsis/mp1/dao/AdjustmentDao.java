package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;

import com.xsis.mp1.model.Adjustment;

public interface AdjustmentDao {

		
	public void save(Adjustment adjustment);
	
	public List<Adjustment> selectAll();
	
}
