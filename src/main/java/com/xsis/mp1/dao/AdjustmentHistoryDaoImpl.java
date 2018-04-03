package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Adjustment;
import com.xsis.mp1.model.AdjustmentHistory;


@Repository
public class AdjustmentHistoryDaoImpl implements AdjustmentHistoryDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(AdjustmentHistory adjh) {
		Session session = sessionFactory.getCurrentSession();
		session.save(adjh);
		session.flush();
	}
 
	public List<AdjustmentHistory> selectHistoryByAdjustment(Adjustment adjustment) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from AdjustmentHistory adjh where adjh.adjustment=:adjustment order by adjh.id desc";
		List<AdjustmentHistory> adjustmentHistories = session.createQuery(hql).setParameter("adjustment", adjustment).list();
		//List<PurchaseRequestHistory> prhs = session.createCriteria(PurchaseRequestHistory.class).add(Restrictions.eq("pr.id", pr.getId())).list(); 
 		if(adjustmentHistories.isEmpty()) {
 			return null;
 		}else {
 			return adjustmentHistories;
 		}
	}

} 
