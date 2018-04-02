package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.PurchaseRequestDetail;

@Repository
public class PRDetailDaoImpl implements PRDetailDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(PurchaseRequestDetail prDetail) {
		Session session = sessionFactory.getCurrentSession();
		session.save(prDetail);
		session.flush();
	}

	public List<PurchaseRequestDetail> selectPrDetailByPr(PurchaseRequest pr) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseRequestDetail prd where prd.pr=:pr_prd";
		//List<PurchaseRequestDetail> prDetails = session.createCriteria(PurchaseRequestDetail.class).add(Restrictions.eq("pr.id", pr.getId())).list(); 
 		List<PurchaseRequestDetail> prDetails = session.createQuery(hql).setParameter("pr_prd", pr).list();
		if(prDetails.isEmpty()) {
 			return null;
 		}else {
 			return prDetails;
 		}
	}

	public void delete(PurchaseRequestDetail prDetails) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(prDetails);
		session.flush();
	}

	public PurchaseRequestDetail getOne(long idPrd) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(PurchaseRequestDetail.class, idPrd);
	}

}
