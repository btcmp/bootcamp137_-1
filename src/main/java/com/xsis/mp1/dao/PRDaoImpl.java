package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.PurchaseRequestDetail;

@Repository
public class PRDaoImpl implements PRDao {

	@Autowired
	SessionFactory sessionFactory;

	public List<PurchaseRequest> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(PurchaseRequest.class).list();
	}

	public void save(PurchaseRequest pr) {
		Session session = sessionFactory.getCurrentSession();
		session.clear();
		session.saveOrUpdate(pr);
		session.flush();
	}

	public void delete(PurchaseRequest pr) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(pr);
		session.flush();
	}

	public PurchaseRequest getOne(long id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(PurchaseRequest.class, id);
	}

	public void approve(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update PurchaseRequest set status='Approved' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	public void reject(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update PurchaseRequest set status='Rejected' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	public void createPo(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update PurchaseRequest set status='PO Created' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	public List<PurchaseRequest> searchPRByStatus(String status) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseRequest where status = :status";
		List<PurchaseRequest> prs = session.createQuery(hql).setParameter("status", status).list();
		if(prs.isEmpty()) {
			return null;
		}else {
			return prs;
		}
	}

	public List<PurchaseRequest> searchPRByGlobal(String global) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseRequest where lower(prNo) like :global or lower(status) like :global or lower(notes) like :global";
		List<PurchaseRequest> prs = session.createQuery(hql).setParameter("global", "%"+global.toLowerCase()+"%").list();
		if(prs.isEmpty()) {
			return null;
		}else {
			return prs;
		}
	}

	public int getRowsPR(int bln, int thn) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PurchaseRequest where MONTH(createdOn) = :month and YEAR(createdOn) = :year";
		List<PurchaseRequest> prs = session.createQuery(hql).setParameter("month", bln).setParameter("year", thn).list();
		if(prs.isEmpty()) {
			return 0;
		}
		return prs.size();
	}

	public void submitted(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update PurchaseRequest set status='Submitted' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}
	
	
}
