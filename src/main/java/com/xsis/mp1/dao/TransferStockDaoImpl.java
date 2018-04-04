package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.model.TransferStockDetail;

@Repository
public class TransferStockDaoImpl implements TransferStockDao{

	@Autowired
	SessionFactory sessionFactory;
	
	public List<TransferStock> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(TransferStock.class).list();
	}

	public void save(TransferStock ts) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(ts);
		session.flush();
	}

	public TransferStock getOne(long id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(TransferStock.class, id);
	}

	public void approve(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update TransferStock set status='Approved' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	public void reject(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update TransferStock set status='Rejected' where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
	}

	public List<TransferStockDetail> getTfStockByTfStockId(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<TransferStock> searchTSByOutlet(long cari) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from TransferStock where toOutlet.id = :cari";
		List<TransferStock> tfs = session.createQuery(hql).setParameter("cari", cari).list();
		if(tfs.isEmpty()) {
			return null;
		}else {
			return tfs;
		}
	}

}
