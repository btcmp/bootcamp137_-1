package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Employee;

public interface EmployeeDao {

	// create
	public void save(Employee employee);

	// read
	// employee -- list
	public List<Employee> selectAll();

	/// single employee
	public Employee getOne(Employee employee);

	// update
	public void update(Employee employee);

	// delete
	public void delete(Employee employee);

	// save or update
	public void saveOrUpdate(Employee employee);

	//update status employee
	public void updateStatus(Employee employee);

	public List<Employee> getListByStatus();
	
}
