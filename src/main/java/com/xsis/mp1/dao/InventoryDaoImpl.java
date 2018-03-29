package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Item;

@Repository
public class InventoryDaoImpl implements InventoryDao {
	@Autowired
	SessionFactory sessionFactory;
	
	public void save(Inventory inventory) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.save(inventory);
		session.flush();
	}

	public List<Inventory> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(Inventory.class).list();
	}

	public Inventory getOne(Inventory inventory) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Inventory.class, inventory.getId());
	}

	public void update(Inventory inventory) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.update(inventory);
		session.flush();
	}

	public void delete(Inventory inventory) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(inventory);
		session.flush();
	}

	public void saveOrUpdate(Inventory inventory) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(inventory);
		session.flush();
	}
	
	public List<Inventory> selectAllByItem(Item item) {
		Session session = sessionFactory.getCurrentSession();
		String hql="from Inventory i where i.variant.item = :item";
		List<Inventory> inventories=session.createQuery(hql).setParameter("item", item).list();
		if(inventories.isEmpty())
			return null;
		else
			return inventories;
	}

	public List<Inventory> searchInventoryByItemName(String search) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from Inventory i where lower(i.variant.item.name) like :itemName or lower(i.variant.name) like :itemName";
		List<Inventory> inventories = session.createQuery(hql).setParameter("itemName", "%"+search.toLowerCase()+"%").list();
		if (inventories.isEmpty()) {
			return null;
		} else {
			return inventories;
		}
	}

}
