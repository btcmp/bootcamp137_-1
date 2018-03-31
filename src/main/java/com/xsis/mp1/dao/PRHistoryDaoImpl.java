package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseRequest;
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

	public List<PurchaseRequestHistory> selectHistoryByPR(PurchaseRequest pr) {
		Session session = sessionFactory.getCurrentSession();
		List<PurchaseRequestHistory> prhs = session.createCriteria(PurchaseRequestHistory.class).add(Restrictions.eq("pr.id", pr.getId())).list(); 
 		if(prhs.isEmpty()) {
 			return null;
 		}else {
 			return prhs;
 		}
	}

}
