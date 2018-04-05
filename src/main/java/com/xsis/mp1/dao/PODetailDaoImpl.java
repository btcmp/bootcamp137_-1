package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseOrderDetail;
import com.xsis.mp1.model.PurchaseRequestDetail;
import com.xsis.mp1.model.PurchaseOrder;

@Repository
public class PODetailDaoImpl implements PODetailDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(PurchaseOrderDetail poDetail) {
		Session session = sessionFactory.getCurrentSession();
		session.save(poDetail);
		session.flush();
	}

	public List<PurchaseOrderDetail> selectPODetailByPO(PurchaseOrder po) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseOrderDetail pod where pod.purchaseOrder=:po_pod";
		List<PurchaseOrderDetail> prDetails = session.createQuery(hql).setParameter("po_pod", po).list();
		if(prDetails.isEmpty()) {
 			return null;
 		}else {
 			return prDetails;
 		}
	}

	public void delete(PurchaseOrderDetail prDetails) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(prDetails);
		session.flush();
	}

	public List<PurchaseOrderDetail> selectPoDetailByPo(PurchaseOrder po) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseOrderDetail pod where pod.purchaseOrder=:po";
		//List<PurchaseRequestDetail> prDetails = session.createCriteria(PurchaseRequestDetail.class).add(Restrictions.eq("pr.id", pr.getId())).list(); 
 		List<PurchaseOrderDetail> poDetails = session.createQuery(hql).setParameter("po", po).list();
		if(poDetails.isEmpty()) {
 			return null;
 		}else {
 			return poDetails;
 		}
	}

	public PurchaseOrderDetail getOne(long idPod) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(PurchaseOrderDetail.class, idPod);
	}

}
