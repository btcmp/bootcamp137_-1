package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.AdjustmentDetail;


@Repository
public class AdjustmentDetailDaoImpl implements AdjustmentDetailDao {
	@Autowired
	SessionFactory sessionFactory;
	
	public void save(AdjustmentDetail adjustmentDetail) {
		Session session = sessionFactory.getCurrentSession();
		session.save(adjustmentDetail);
		session.flush();
		
	}

	public List<AdjustmentDetail> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(AdjustmentDetail.class).list();
	}

}
