package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Category;
import com.xsis.mp1.model.Employee;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Supplier;

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

	public List<Item> getItemsByCategory(Category category) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "from Item i where i.categoryId.id =:category"; 
		List<Item> items = session.createQuery(hql).setParameter("category", category.getId()).list(); 
		if (items.isEmpty()) {
			return null; 
		}
		return items;
	}

	public void updateItemByName(Item item) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "update Item set name =:name, categoryId=:cId, image=:img where id=:id";
		
		Query query=session.createQuery(hql);
		
		query.setParameter("name", item.getName());
		query.setParameter("cId",item.getCategoryId());
		query.setParameter("id", item.getId());
		query.setParameter("img", item.getImage());
		query.executeUpdate();
		session.flush();
	}

	public List<Item> selectAllBySupplier(Supplier supplier) {
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "from Item i where i.supplier.id =:supplier"; 
		List<Item> items = session.createQuery(hql).setParameter("supplier", supplier.getId()).list(); 
		if (items.isEmpty()) {
			return null; 
		}
		return items;
	}

	public void updateStatus(Long idItem) {
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "update Item  set active=1 where id=:idit";
		System.out.println(idItem);
		session.createQuery(hql).setParameter("idit", idItem).executeUpdate(); 
		session.flush();
	} 
 
}
