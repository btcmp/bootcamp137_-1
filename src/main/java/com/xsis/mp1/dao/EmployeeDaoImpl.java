package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {

	@Autowired
	SessionFactory sessionFactory;

	public void save(Employee employee) {
		Session session = sessionFactory.getCurrentSession();
		session.save(employee);
		session.flush();
	}

	public List<Employee> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(Employee.class).list();
	}

	public Employee getOne(Employee employee) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Employee.class, employee.getId());
	}

	public void update(Employee employee) {
		Session session = sessionFactory.getCurrentSession();
		session.update(employee);
		session.flush();
	}

	public void delete(Employee employee) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(employee);
		session.flush();
	}

	public void saveOrUpdate(Employee employee) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(employee);
		session.flush();
	}
	
}
