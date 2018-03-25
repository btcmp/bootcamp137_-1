package com.xsis.mp1.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.User;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	SessionFactory sessionFactory;
	
	public void saveOrUpdate(User user) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(user);
		session.flush();
	}

}
