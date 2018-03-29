package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Category;

@Repository
public class CategoryDaoImpl implements CategoryDao{
	
	@Autowired
	SessionFactory sessionFactory; 
	
	public void save(Category category) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.getCurrentSession(); 
		session.save(category); 
		session.flush();
	}

	public List<Category> selectAll() {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "from Category c where c.active = 0";
		List<Category> categories = session.createQuery(hql).list();
		if (categories.isEmpty()) {
			return null;
		}else {
			return categories; 
		}
	}

	public Category getOne1(Category category) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "from Category c where c.id = :idcatt";
		List<Category> cats = session.createQuery(hql).setParameter("idcatt", category.getId()).list();
		Category cat = cats.get(0);
		if(cats.isEmpty()) {
			return null;
		}else {
			return cat;
		}
	}
	
	public Category getOne(Category category) {
		Session session = sessionFactory.getCurrentSession(); 
		return session.get(Category.class, category.getId());
	}
	public void update(Category category) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		session.update(category);
		session.flush();
	}

	public void saveOrUpdate(Category category) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		session.saveOrUpdate(category);
		session.flush();
	}

	public void delete(Category category) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		session.delete(category);
		session.flush(); 
	}

	public List<Category> getListByStatus() {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession(); 
		String hql = "from Category c where c.active = 0"; 
		List<Category> categories = session.createQuery(hql).list();
		if (categories.isEmpty()) {
			return null;
		}else {
			return categories; 
		}
	}

	public void updateStatus(Category category) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "update Category c set c.active= 1 where c.id = :idcat"; 
		session.createQuery(hql).setParameter("idcat", category.getId()).executeUpdate(); 
		session.flush();
	}

	public List<Category> getCategoryBySearchName(String search) {
		// TODO Auto-generated method stub
		String hql = "from Category c where lower(c.name) like :name and c.active = 0" ; 
		Session session = sessionFactory.getCurrentSession(); 
		List<Category> categories = session.createQuery(hql).setParameter("name", "%"+search.toLowerCase()+"%").list(); 
		if (categories.isEmpty()) {
			return null;
		}
		return categories; 
	}

}
