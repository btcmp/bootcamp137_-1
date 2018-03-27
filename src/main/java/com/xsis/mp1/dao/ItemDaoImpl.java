package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Employee;
import com.xsis.mp1.model.Item;

@Repository
public class ItemDaoImpl implements ItemDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void save(Item item) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.save(item);
		session.flush();
	}
	
	public List<Item> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(Item.class).list();
	}

	public Item getOne(Item item) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Item.class, item.getId());
	}

	public void update(Item item) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.update(item);
		session.flush();
	}

	public void delete(Item item) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(item);
		session.flush();
	}

	public void saveOrUpdate(Item item) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(item);
		session.flush();
	}

}
