package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Role;

@Repository
public class RoleDaoImpl implements RoleDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public List<Role> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(Role.class).list();
	}

}
