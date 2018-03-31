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

	public void save(PurchaseRequest pr) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(pr);
		session.flush();
	}

	public PurchaseRequest getOne(PurchaseRequest pr) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(PurchaseRequest.class, pr.getId());
	}

	public void delete(PurchaseRequest pr) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(pr);
		session.flush();
	}
	
	
}
