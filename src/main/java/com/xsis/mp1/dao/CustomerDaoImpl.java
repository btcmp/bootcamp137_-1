package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Customer;

@Repository
public class CustomerDaoImpl implements CustomerDao{
	
	@Autowired
	SessionFactory sessionFactory; 
	
	public void save(Customer customer) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		session.save(customer); 
		session.flush();
	}

	public List<Customer> selectAll() {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		return session.createCriteria(Customer.class).list();
	}

	public List<Customer> getCustomerByName(String name) {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession(); 
		String hql = "from Customer cust where lower(cust.name) like lower(:name)"; 
		List<Customer> customers = session.createQuery(hql).setParameter("name","%"+name+"%").list(); 
		if (customers.isEmpty()) {
			return null; 
		}
		return customers;
	}

}
