package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.EmployeeOutlet;
import com.xsis.mp1.model.Outlet;

@Repository
public class OutletDaoImpl implements OutletDao {
	
	@Autowired
	SessionFactory sessionFactory; 
	public void save(Outlet outlet) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.getCurrentSession(); 
		session.save(outlet); 
		session.flush();
	}

	public List<Outlet> selectAll() {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession(); 
		String hql = "from Outlet out order by out.id desc";
		List<Outlet> outlets = session.createQuery(hql).list(); 
		return outlets;
	}

	public Outlet getOne(Outlet outlet) {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession(); 
		return session.get(Outlet.class, outlet.getId()); 
	}
 
	public void update(Outlet outlet) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.getCurrentSession(); 
		session.update(outlet);
		session.flush();
	}

	public void saveOrUpdate(Outlet outlet) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		session.saveOrUpdate(outlet);
		session.flush();
	}

	public void delete(Outlet outlet) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		session.delete(outlet);
		session.flush();
	}

	public List<Outlet> getOutletBySearchName(String search) {
		// TODO Auto-generated method stub
		String hql = "from Outlet out where lower(out.name) like :name order by out.id desc "; 
		Session session= sessionFactory.getCurrentSession(); 
		List<Outlet> outlets = session.createQuery(hql).setParameter("name", "%"+search.toLowerCase()+"%").list(); 
		if (outlets.isEmpty()) {
			return null;
		}
			return outlets; 
	}
	
}
