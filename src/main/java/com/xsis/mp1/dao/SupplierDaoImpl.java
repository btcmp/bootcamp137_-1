package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Supplier;

@Repository
public class SupplierDaoImpl implements SupplierDao{
	
	@Autowired
	SessionFactory sessionFactory; 
	public void save(Supplier supplier) {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession(); 
		session.save(supplier); 
		session.flush();
	}

	public List<Supplier> selectAll() {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		return session.createCriteria(Supplier.class).list();
	}

	public Supplier getOne(Supplier supplier) {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession(); 
		return session.get(Supplier.class, supplier.getId());
	}

	public void update(Supplier supplier) {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession(); 
		session.update(supplier); 
		session.flush();
	}

	public void saveOrUpdate(Supplier supplier) {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession(); 
		session.saveOrUpdate(supplier);
		session.flush();
	}

	public void delete(Supplier supplier) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.getCurrentSession(); 
		session.delete(supplier);
		session.flush();
	}
	
	
}
