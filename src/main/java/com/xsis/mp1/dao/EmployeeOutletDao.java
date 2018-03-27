package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Employee;
import com.xsis.mp1.model.EmployeeOutlet;

public interface EmployeeOutletDao {

public void save(EmployeeOutlet empOutlet);
	
	public void update(EmployeeOutlet empOutlet);
	
	public void delete(EmployeeOutlet empOutlet);
	
	public List<EmployeeOutlet> selectAll();
	
	public EmployeeOutlet getOne(EmployeeOutlet empOutlet);

	public void saveOrUpdate(EmployeeOutlet empOutlet);

	public List<EmployeeOutlet> getEmployeeOutletByEmployee(Employee empss);
}
