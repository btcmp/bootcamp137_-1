package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseRequest;

@Repository
public class PODaoImpl implements PODao {

	@Autowired
	SessionFactory sessionFactory;

	public List<PurchaseOrder> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(PurchaseOrder.class).list();
	}

	public PurchaseOrder geOne(long id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(PurchaseOrder.class, id);
	}
	
	
}
