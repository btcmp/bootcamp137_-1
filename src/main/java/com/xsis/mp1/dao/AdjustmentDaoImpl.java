package com.xsis.mp1.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Adjustment;
import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseRequest;


@Repository
public class AdjustmentDaoImpl implements AdjustmentDao {

	@Autowired
	SessionFactory sessionFactory;

	public List<Adjustment> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(Adjustment.class).list();
	}

	public void save(Adjustment adjustment) {
		Session session = sessionFactory.getCurrentSession();
		session.clear();
		session.saveOrUpdate(adjustment);
		session.flush();
	}
 
	public void delete(Adjustment adjustment) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(adjustment);
		session.flush();
	}

	public Adjustment getOne(long id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Adjustment.class, id);
	}

	public void approve(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update Adjustment set status='Approved' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	public void reject(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update Adjustment set status='Rejected' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	public void createPo(long id) {
		/*Session session = sessionFactory.getCurrentSession();
		String hql = "update Adjustment set status='PO Created' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();*/
	}

	@Override
	public void setInventory(long id) {
/*		Session session = sessionFactory.getCurrentSession();
		String hql = "update Adjustment set status='Rejected' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();*/
	}

	@Override
	public List<Adjustment> searchAdjByDate(Date startDate, Date endDate) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from Adjustment where createdOn BETWEEN :start AND  :end";
		List<Adjustment> adj = session.createQuery(hql).setParameter("start", startDate).setParameter("end", endDate).list();
		if(adj.isEmpty()) {
			return null;
		}else {
			return adj;
		}
	}

	@Override
	public int getAdjNeedAction() {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from Adjustment where status!='Submitted'";
		List<Adjustment> adjs = session.createQuery(hql).list();
		if(adjs.isEmpty()) {
			return 0;
		}
		return adjs.size();
	}
	
	
}
