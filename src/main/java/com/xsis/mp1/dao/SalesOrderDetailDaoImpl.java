package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.SalesOrder;
import com.xsis.mp1.model.SalesOrderDetail;

@Repository
public class SalesOrderDetailDaoImpl implements SalesOrderDetailDao{
	
	@Autowired
	SessionFactory sessionFactory; 
	public void save(SalesOrderDetail salesOrderDetails) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.save(salesOrderDetails);
		session.flush(); 
	}

	public List<SalesOrderDetail> selectAll(long salesOrder) {
		// TODO Auto-generated method stub
//		return session.createCriteria(SalesOrderDetail.class).list();
		Session session = sessionFactory.getCurrentSession();
		String hql = "from SalesOrderDetail sod where sod.salesOrder.id = :idso";
		List<SalesOrderDetail> sods = session.createQuery(hql).setParameter("idso", salesOrder).list();
		if(sods.isEmpty()) {
			return null;
		}else {
			return sods;
		}
	}

}
