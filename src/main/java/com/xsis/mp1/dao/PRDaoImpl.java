package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseRequest;

@Repository
public class PRDaoImpl implements PRDao {

	@Autowired
	SessionFactory sessionFactory;

	public List<PurchaseRequest> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(PurchaseRequest.class).list();
	}
	
	
}
