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

	public void save(TransferStock ts) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(ts);
		session.flush();
	}

	public TransferStock getOne(long id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(TransferStock.class, id);
	}

	public void approve(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update TransferStock set status='Approved' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	public void reject(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update TransferStock set status='Rejected' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

}
