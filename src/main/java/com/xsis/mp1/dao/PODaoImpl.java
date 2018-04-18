package com.xsis.mp1.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.PurchaseOrder;

@Repository
public class PODaoImpl implements PODao {

	@Autowired
	SessionFactory sessionFactory;

	public List<PurchaseOrder> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(PurchaseOrder.class).list();
	}

	public void save(PurchaseOrder po) {
		Session session = sessionFactory.getCurrentSession();
		session.clear();
		session.saveOrUpdate(po);
		session.flush();
	}
	
	public void update(PurchaseOrder po) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.clear();
		session.update(po);
		session.flush();
	}

	public void delete(PurchaseOrder po) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(po);
		session.flush();
	}

	public PurchaseOrder getOne(long id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(PurchaseOrder.class, id);
	}

	public void approve(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update PurchaseOrder set status='Approved' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	public void reject(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update PurchaseOrder set status='Rejected' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	public int getRowsPR(int bln, int thn) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseOrder where MONTH(createdOn) = :month and YEAR(createdOn) = :year";
		List<PurchaseOrder> pos = session.createQuery(hql).setParameter("month", bln).setParameter("year", thn).list();
		if(pos.isEmpty()) {
			return 0;
		}
		return pos.size();
	}

	public void process(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update PurchaseOrder set status='Submitted' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	@Override
	public List<PurchaseOrder> searchPOByDate(Date startDate, Date endDate) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseOrder where createdOn BETWEEN :start AND  :end";
		List<PurchaseOrder> pos = session.createQuery(hql).setParameter("start", startDate).setParameter("end", endDate).list();
		if(pos.isEmpty()) {
			return null;
		}else {
			return pos;
		}
	}

	
	public List<PurchaseOrder> searchPOByStatus(String status) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseOrder where status = :status";
		List<PurchaseOrder> pos = session.createQuery(hql).setParameter("status", status).list();
		if(pos.isEmpty()) {
			return null;
		}else {
			return pos;
		}
	}


	public List<PurchaseOrder> searchPOByGlobal(String global) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseOrder where lower(poNo) like :global or lower(status) like :global or lower(supplierId.name) like :global or lower(grandTotal) like :global";
		List<PurchaseOrder> pos = session.createQuery(hql).setParameter("global", "%"+global.toLowerCase()+"%").list();
		if(pos.isEmpty()) {
			return null;
		}else {
			return pos;
		}
	}

	@Override
	public int getPoNeedAction() {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseOrder where status!='Rejected' AND status!='Process'";
		List<PurchaseOrder> pro = session.createQuery(hql).list();
		if(pro.isEmpty()) {
			return 0;
		}
		return pro.size();
	}
}
