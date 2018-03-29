package com.xsis.mp1.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseRequestDetail;

@Repository
public class PRDetailDaoImpl implements PRDetailDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(PurchaseRequestDetail prDetail) {
		Session session = sessionFactory.getCurrentSession();
		session.save(prDetail);
		session.flush();
	}

}
