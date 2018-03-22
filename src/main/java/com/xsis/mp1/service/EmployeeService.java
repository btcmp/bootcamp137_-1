package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.EmployeeDao;
import com.xsis.mp1.model.Employee;

@Service
@Transactional
public class EmployeeService {

	@Autowired
	EmployeeDao employeeDao;

	public void save(Employee employee) {
		employeeDao.save(employee);
	}

	public List<Employee> selectAll() {
		return employeeDao.selectAll();
	}

	public Employee getOne(long id) {
		Employee employee = new Employee();
		employee.setId(id);
		employee.setFirstName("0");
		employee.setLastName("0");
		employee.setHaveAccount(false);
		employee.setActive(false);
		return employeeDao.getOne(employee);
	}

	public void update(Employee employee) {
		employeeDao.update(employee);
	}

	public void delete(Employee employee) {
		employeeDao.delete(employee);
	}
	
	public void saveOrUpdate(Employee employee) {
		employeeDao.saveOrUpdate(employee);
	}

	public void updateStatus(Employee employee) {
		employeeDao.updateStatus(employee);
	}

}
