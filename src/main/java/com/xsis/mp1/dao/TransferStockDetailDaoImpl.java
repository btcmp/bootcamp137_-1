package com.xsis.mp1.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.TransferStockDetail;

@Repository
public class TransferStockDetailDaoImpl implements TransferStockDetailDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(TransferStockDetail tsDetail) {
		Session session = sessionFactory.getCurrentSession();
		session.save(tsDetail);
		session.flush();
	}

}
