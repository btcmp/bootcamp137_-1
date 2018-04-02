package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.EmployeeOutlet;
import com.xsis.mp1.model.Outlet;

public interface OutletDao {
	
	//create 
		public void save(Outlet outlet); 
		
		//read 
		public List<Outlet> selectAll(); 
		
		public Outlet getOne(Outlet outlet); 
		
		//update 
		public void update(Outlet outlet); 
		
		public void saveOrUpdate(Outlet outlet); 
		
		//delete
		public void delete(Outlet outlet);

		public List<Outlet> getOutletBySearchName(String search);

//		public EmployeeOutlet getOutletByEmployeeId(EmployeeOutlet eo); 
}
 