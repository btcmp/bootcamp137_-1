package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseRequestHistory;
import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.model.TransferStockHistory;

@Repository
public class TransferStockHistoryDaoImpl implements TransferStockHistoryDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(TransferStockHistory tsh) {
		Session session = sessionFactory.getCurrentSession();
		session.save(tsh);
		session.flush();
	}

	public List<TransferStockHistory> selectHistoryByTS(TransferStock ts) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from TransferStockHistory tsh where tsh.transfer=:ts_tsh order by tsh.id desc";
		List<TransferStockHistory> tsHistories = session.createQuery(hql).setParameter("ts_tsh", ts).list();
		if(tsHistories.isEmpty()) {
 			return null;
 		}else {
 			return tsHistories;
 		}
	}

}
