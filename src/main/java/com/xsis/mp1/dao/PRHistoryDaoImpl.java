package com.xsis.mp1.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseRequestHistory;

@Repository
public class PRHistoryDaoImpl implements PRHistoryDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(PurchaseRequestHistory prh) {
		Session session = sessionFactory.getCurrentSession();
		session.save(prh);
		session.flush();
	}

}
