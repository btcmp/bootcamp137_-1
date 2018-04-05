package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.EmployeeDao;
import com.xsis.mp1.dao.EmployeeOutletDao;
import com.xsis.mp1.dao.UserDao;
import com.xsis.mp1.model.Employee;
import com.xsis.mp1.model.EmployeeOutlet;
import com.xsis.mp1.model.User;

@Service
@Transactional
public class EmployeeService {

	@Autowired
	EmployeeDao employeeDao;

	@Autowired
	EmployeeOutletDao empOutletDao;
	
	@Autowired
	UserDao userDao;
	
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
		Employee empss = employeeDao.getOne(employee);
		List<EmployeeOutlet> empOUtlets = empOutletDao.getEmployeeOutletByEmployee(empss);
		empss.setEmpouts(empOUtlets);
		return empss;
	}

	public void update(Employee employee) {
		employeeDao.update(employee);
	}

	public void delete(Employee employee) {
		employeeDao.delete(employee);
	}
	
	public void saveOrUpdate(Employee employee) {
		Employee emp = new Employee();
		emp.setId(employee.getId());
		emp.setFirstName(employee.getFirstName());
		emp.setLastName(employee.getLastName());
		emp.setEmail(employee.getEmail());
		emp.setTitle(employee.getTitle());
		emp.setHaveAccount(employee.isHaveAccount());
		emp.setActive(employee.isActive());
		employeeDao.saveOrUpdate(emp);
		
		List<EmployeeOutlet> empOutss = empOutletDao.getEmployeeOutletByEmployee(emp);
		if(empOutss!=null) {
			System.out.println("masuk delete");
			for(EmployeeOutlet empouts : empOutss) {
				System.out.println("masuk");
				empOutletDao.delete(empouts);
			}
		}
		
		if(employee.getEmpouts()!=null) {
			for(EmployeeOutlet empOut : employee.getEmpouts()) {
				EmployeeOutlet empOutlet = new EmployeeOutlet();
				//empOutlet.setId(empOut.getId());
				empOutlet.setEmployee(emp);
				empOutlet.setOutlet(empOut.getOutlet());
				empOutletDao.save(empOutlet);
			}
		}
		
		if(employee.getUser()!=null) {
			User user = new User();
			user.setEmployee(emp);
			user.setId(employee.getUser().getId());
			user.setRole(employee.getUser().getRole());
			user.setUsername(employee.getUser().getUsername());
			user.setPassword(employee.getUser().getPassword());
			user.setActive(true);
			userDao.saveOrUpdate(user);
		}
	}

	public void updateStatus(Employee employee) {
		employeeDao.updateStatus(employee);
	}

	public List<Employee> getListByStatus() {
		List<Employee> employees = employeeDao.getListByStatus(); 
		for(Employee employee : employees) {
			List<EmployeeOutlet> empOUtlets = empOutletDao.getEmployeeOutletByEmployee(employee);
			employee.setEmpouts(empOUtlets);
		}
		return employees;
//		return employeeDao.getListByStatus();
	}

	public List<Employee> getOneByUsername(String username) {
		return employeeDao.getOneByUsername(username);
	}

	public int countEmail(String email) {
		return employeeDao.countEmail(email);
	}

	public int countUser(String user) {
		return employeeDao.countUser(user);
	}
}
