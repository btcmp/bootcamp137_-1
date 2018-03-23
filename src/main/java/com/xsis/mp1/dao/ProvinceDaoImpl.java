package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Province;

@Repository
public class ProvinceDaoImpl implements ProvinceDao{
	
	@Autowired
	SessionFactory sessionFactory; 
	public List<Province> selectAll() {
		// TODO Auto-generated method stub
		Session session=sessionFactory.getCurrentSession(); 
		return session.createCriteria(Province.class).list();
	}

}
