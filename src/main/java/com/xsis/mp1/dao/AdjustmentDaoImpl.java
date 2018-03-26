package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Adjustment;

@Repository
public class AdjustmentDaoImpl implements AdjustmentDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(Adjustment adjustment) {
		Session session = sessionFactory.getCurrentSession();
		session.save(adjustment);
		session.flush();
		
	}

	public List<Adjustment> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(Adjustment.class).list();
	}

}
