package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.SalesOrder;

@Repository
public class SalesOrderDaoImpl implements SalesOrderDao{

	
	@Autowired
	SessionFactory sessionFactory; 
	public void save(SalesOrder salesOrder) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		session.save(salesOrder); 
		session.flush();
	}
	public List<SalesOrder> selectAll() {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		return session.createCriteria(SalesOrder.class).list();
	}
	@Override
	public long getIdSalesOrder(long idCustomer) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		String hql = "select so.id from SalesOrder so where so.customer.id = :id order by so.modifiedOn desc";
		List<Long> id =  session.createQuery(hql).setParameter("id", idCustomer).list();
		long idSo = id.get(0);
		if(id.isEmpty()) {
			return 0;
		}else {
			return idSo;
		}
	}
}
