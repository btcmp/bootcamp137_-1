package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.Variant;

@Repository
public class VariantDaoImpl implements VariantDao {
	@Autowired
	SessionFactory sessionFactory;
	
	public void save(Variant variant) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.save(variant);
		session.flush();
	}
  
	public List<Variant> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(Variant.class).list();
	}

	public Variant getOne(Variant variant) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Variant.class, variant.getId());
	}
 
	public void update(Variant variant) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.update(variant);
		session.flush();
	} 

	public void delete(Variant variant) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(variant);
		session.flush();
	}

	public void saveOrUpdate(Variant variant) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(variant);
		session.flush();
	}

	public List<Variant> getVarianByItem(Item item) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		String hql="from Variant v where v.item = :item";
		List<Variant> variants=session.createQuery(hql).setParameter("item", item).list();
		if(variants.isEmpty())
			return null;
		else
			return variants;
	}

	public List<Variant> getVariantByName(String name) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "from Variant v where lower(v.item.name) like lower(:name)";
		List<Variant> variants = session.createQuery(hql).setParameter("name", "%"+name+"%").list(); 
		if (variants.isEmpty()) {
			return null;
		}
		return variants;
	}

	public Variant getOneItem(long id) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		return session.get(Variant.class, id); 
	}

	public List<Variant> getVariantByPR(PurchaseRequest purchaseRequest) {
		Session session=sessionFactory.getCurrentSession();
		String hql="select variant from PurchaseRequestDetail prd where prd.pr =:prdpr";
		List<Variant> variants= session.createQuery(hql).setParameter("prdpr", purchaseRequest).list();
		if(variants.isEmpty()) 
			return null;
		else
			return variants;
	}
	
	

}
