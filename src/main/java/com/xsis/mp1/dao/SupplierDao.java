package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Supplier;

public interface SupplierDao {
	
	//create 
	public void save(Supplier supplier); 
	
	//read 
	public List<Supplier> selectAll(); 
	
	public Supplier getOne(Supplier supplier); 
	
	//update 
	public void update(Supplier supplier); 
	
	public void saveOrUpdate(Supplier supplier); 
	
	//delete
	public void delete(Supplier supplier);

	public List<Supplier> getSupplierBySearchName(String search);

	/*public List<Supplier> getSupplierBySearchName(String search); */
	
}
