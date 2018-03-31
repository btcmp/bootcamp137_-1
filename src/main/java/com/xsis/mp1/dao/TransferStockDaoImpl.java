package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.TransferStock;

@Repository
public class TransferStockDaoImpl implements TransferStockDao{

	@Autowired
	SessionFactory sessionFactory;
	
	public List<TransferStock> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(TransferStock.class).list();
	}

}
