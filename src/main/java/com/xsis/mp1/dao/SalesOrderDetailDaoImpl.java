package com.xsis.mp1.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.SalesOrderDetail;

@Repository
public class SalesOrderDetailDaoImpl implements SalesOrderDetailDao{
	
	@Autowired
	SessionFactory sessionFactory; 
	public void save(SalesOrderDetail salesOrderDetails) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.save(salesOrderDetails);
		session.flush(); 
	}

}
