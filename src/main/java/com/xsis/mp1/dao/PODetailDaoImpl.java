package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseOrderDetail;
import com.xsis.mp1.model.PurchaseRequest;

@Repository
public class PODetailDaoImpl implements PODetailDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(PurchaseOrderDetail purchaseOrderDetail) {
	Session session= sessionFactory.getCurrentSession();
	session.save(purchaseOrderDetail);
	session.flush();
		
	}

	public List<PurchaseOrderDetail> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return  session.createCriteria(PurchaseOrderDetail.class).list();
	}

}
