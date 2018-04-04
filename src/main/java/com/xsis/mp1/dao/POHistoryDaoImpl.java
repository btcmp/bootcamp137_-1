package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseOrderDetail;
import com.xsis.mp1.model.PurchaseOrderHistory;

@Repository
public class POHistoryDaoImpl implements POHistoryDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(PurchaseOrderHistory poh) {
		Session session = sessionFactory.getCurrentSession();
		session.save(poh);
		session.flush();
	}

	public List<PurchaseOrderHistory> selectHistoryByPO(PurchaseOrder po) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseOrderHistory poh where poh.purchaseOrder=:po order by poh.id desc";
		List<PurchaseOrderHistory> poHistories = session.createQuery(hql).setParameter("po", po).list();
		//List<PurchaseOrderHistory> pohs = session.createCriteria(PurchaseOrderHistory.class).add(Restrictions.eq("po.id", po.getId())).list(); 
 		if(poHistories.isEmpty()) {
 			return null;
 		}else {
 			return poHistories;
 		}
	}

}
