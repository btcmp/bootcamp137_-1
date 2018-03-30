package com.xsis.mp1.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.SalesOrder;

@Repository
public class SalsOrderDaoImpl implements SalesOrderDao{

	
	@Autowired
	SessionFactory sessionFactory; 
	public void save(SalesOrder salesOrder) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		session.save(salesOrder); 
		session.flush();
	}

}
