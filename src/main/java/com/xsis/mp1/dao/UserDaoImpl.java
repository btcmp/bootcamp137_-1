package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Employee;
import com.xsis.mp1.model.Inventory;
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

	public int countUser(String user) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from User where username = :user";
		List<User> users = session.createQuery(hql).setParameter("user", user).list();
		if(users.isEmpty()) {
			System.out.println(0);
			return 0;
		}
		else{
			return users.size();
		}
	}

	public User getUserByEmployee(Employee emp) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from User where employee = :emp";
		List<User> users = session.createQuery(hql).setParameter("emp", emp).list();
		if(users.isEmpty()) {
			return null;
		}else {
			return users.get(0);
		}
	}

	public void setInactive(long id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "update User set active=0 where id = :id";
		session.createQuery(hql).setParameter("id", id).executeUpdate();
		session.flush();
	}

	public List<Object> getUsernameByPrId(long id) {
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "select username from User where id=:id";
		List<Object> users = session.createQuery(hql).setParameter("id", id).list();
		if (users.isEmpty()) {
			return null; 
		} else {
			return users;
		}
	}
	
	public List<Object> getUsernameByAdjId(long id) {
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "select username from User where id=:id";
		List<Object> users = session.createQuery(hql).setParameter("id", id).list();
		if (users.isEmpty()) {
			return null; 
		} else {
			return users;
		}
	}
	public List<Object> getUsernameByPOId(long id) {
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "from Employee e where e.user.id=:id";
		List<Object> users = session.createQuery(hql).setParameter("id", id).list();
		if (users.isEmpty()) {
			return null; 
		} else {
			return users;
		}
	}

}
