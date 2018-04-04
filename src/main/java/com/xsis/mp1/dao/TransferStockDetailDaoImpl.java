package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseRequestDetail;
import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.model.TransferStockDetail;

@Repository
public class TransferStockDetailDaoImpl implements TransferStockDetailDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(TransferStockDetail tsDetail) {
		Session session = sessionFactory.getCurrentSession();
		session.save(tsDetail);
		session.flush();
	}

	public List<TransferStockDetail> selectTsDetailByTS(TransferStock ts) {
		Session session = sessionFactory.getCurrentSession();
		//List<TransferStockDetail> tsDetails = session.createCriteria(TransferStockDetail.class).add(Restrictions.eq("transfer.id", ts.getId())).list(); 
		String hql = "from TransferStockDetail tsd where tsd.transfer=:ts_tsd";
		List<TransferStockDetail> tsDetails = session.createQuery(hql).setParameter("ts_tsd", ts).list();
		if(tsDetails.isEmpty()) {
 			return null;
 		}else {
 			return tsDetails;
 		}
	}

	public List<TransferStockDetail> getTfStockByTfStockId(long id) {
		String hql = "from TransferStockDetail TSD where TSD.transfer.id = :idts";
		Session session = sessionFactory.getCurrentSession();
		List<TransferStockDetail> transferStockDetails = session.createQuery(hql).setParameter("idts", id).list();
		if (transferStockDetails.isEmpty()) {
			return null;
		} else {
			return transferStockDetails;
		}
	}

}
