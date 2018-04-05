package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Adjustment;
import com.xsis.mp1.model.AdjustmentDetail;
import com.xsis.mp1.model.PurchaseOrderDetail;


@Repository
public class AdjustmentDetailDaoImpl implements AdjustmentDetailDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(AdjustmentDetail adjustmentDetail) {
		Session session = sessionFactory.getCurrentSession();
		session.save(adjustmentDetail);
		session.flush();
	}

	public List<AdjustmentDetail> selectAdjustmentDetailByadjustment(Adjustment adjustment) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from AdjustmentDetail add where add.adjustment=:adjustment";
		//List<PurchaseRequestDetail> prDetails = session.createCriteria(PurchaseRequestDetail.class).add(Restrictions.eq("pr.id", pr.getId())).list(); 
 		List<AdjustmentDetail> adjustmentDetails = session.createQuery(hql).setParameter("adjustment", adjustment).list();
		if(adjustmentDetails.isEmpty()) {
 			return null;
 		}else {
 			return adjustmentDetails;
 		}
	} 

	public void delete(AdjustmentDetail adjustmentDetail) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(adjustmentDetail);
		session.flush();
	}

	public AdjustmentDetail getOne(long idAdjd) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(AdjustmentDetail.class, idAdjd);
	}

}
