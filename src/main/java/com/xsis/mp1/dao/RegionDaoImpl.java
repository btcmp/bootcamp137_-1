package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Region;

@Repository
public class RegionDaoImpl implements RegionDao{
	
	@Autowired
	SessionFactory sessionFactory; 
	public List<Region> selectAll() {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession(); 
		return session.createCriteria(Region.class).list();
	}
	public List<Region> getRegion(long id) {
		// TODO Auto-generated method stub
		String hql = "from Region r where r.province.id = :id"; 
		Session session = sessionFactory.getCurrentSession(); 
		List<Region> regions = session.createQuery(hql).setParameter("id", id).list(); 
		if (regions.isEmpty()) {
			return null;
		} else {
			return regions; 
		}
		
	}

}
