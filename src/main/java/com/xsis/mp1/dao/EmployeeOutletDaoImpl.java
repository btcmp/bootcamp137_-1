package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Employee;
import com.xsis.mp1.model.EmployeeOutlet;

@Repository
public class EmployeeOutletDaoImpl implements EmployeeOutletDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(EmployeeOutlet empOutlet) {
		Session session = sessionFactory.getCurrentSession();
		session.save(empOutlet);
		session.flush();
	}

	public void update(EmployeeOutlet empOutlet) {
		// TODO Auto-generated method stub
		
	}

	public void delete(EmployeeOutlet empOutlet) {
		// TODO Auto-generated method stub
		
	}

	public List<EmployeeOutlet> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public EmployeeOutlet getOne(EmployeeOutlet empOutlet) {
		// TODO Auto-generated method stub
		return null;
	}

	public void saveOrUpdate(EmployeeOutlet empOutlet) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(empOutlet);
		session.flush();
	}

	public List<EmployeeOutlet> getEmployeeOutletByEmployee(Employee emp) {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(EmployeeOutlet.class).add(Restrictions.eq("employee.id", emp.getId())).list();
	}

	
}
