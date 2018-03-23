package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.District;

@Repository
public class DistrictDaoImpl implements DistrictDao{
	
	@Autowired 
	SessionFactory sessionFactory; 
	public List<District> selectAll() {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession(); 
		return session.createCriteria(District.class).list();
	}

}