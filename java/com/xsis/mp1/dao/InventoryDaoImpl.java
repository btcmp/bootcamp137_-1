package com.xsis.mp1.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.model.Variant;

@Repository
public class InventoryDaoImpl implements InventoryDao {
	@Autowired
	SessionFactory sessionFactory;
	
	public void save(Inventory inventory) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.save(inventory);
		session.flush();
	}

	public List<Inventory> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		return session.createCriteria(Inventory.class).list();
	}
 
	public Inventory getOne(Inventory inventory) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Inventory.class, inventory.getId());
	}

	public void update(Inventory inventory) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.update(inventory);
		session.flush();
	}

	public void delete(Inventory inventory) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(inventory);
		session.flush();
	}

	public void saveOrUpdate(Inventory inventory) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(inventory);
		session.flush();
	}
	
	public List<Inventory> selectAllByItem(Item item) {
		Session session = sessionFactory.getCurrentSession();
		String hql="from Inventory i where i.variant.item = :item";
		List<Inventory> inventories=session.createQuery(hql).setParameter("item", item).list();
		if(inventories.isEmpty())
			return null;
		else
			return inventories;
	}

	public List<Inventory> searchInventoryByItemName(String search) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from Inventory i where lower(i.variant.item.name) like :itemName or lower(i.variant.name) like :itemName";
		List<Inventory> inventories = session.createQuery(hql).setParameter("itemName", "%"+search.toLowerCase()+"%").list();
		if (inventories.isEmpty()) {
			return null;
		} else {
			return inventories;
		}
	}
	
	public List<Inventory> selectAllByItemOutlet(Outlet outlet) {
		Session session = sessionFactory.getCurrentSession();
		String hql="from Inventory i where i.variant.item.outlet = :outlet";
		List<Inventory> inventories=session.createQuery(hql).setParameter("outlet", outlet).list();
		System.out.println(outlet);
		if(inventories.isEmpty())
			return null;
		else
			return inventories;
	}

	public List<Inventory> selectAllByItemPo(Supplier supplier) {
		Session session = sessionFactory.getCurrentSession();
		String hql="from Inventory i, PurchaseRequestDetail prd where i.variant.item.supplier = :supp and prd.variant.item.supplier =:supplier ";
		List<Inventory> inventories=session.createQuery(hql).setParameter("supp", supplier).setParameter("supplier", supplier).list();
		if(inventories.isEmpty())
			return null;
		else
			return inventories;
	}

	public List<Object> searchInventoryByVariantAndOutlet(Variant variant) {
		Session session=sessionFactory.getCurrentSession();
		String hql="select beginning from Inventory where variant = :variant";
		List<Object> inventories = session.createQuery(hql).setParameter("variant", variant).list();
		if(inventories.isEmpty()) {
			return null;
		}else {
			return inventories;
		}
	}

	public Inventory getOneInvetory(long id) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		return session.get(Inventory.class, id); 
	}

	public Inventory getVariant(Long id) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession(); 
		String hql = "from Inventory inv where inv.variant.id= :var and inv.modifiedOn is not null order by inv.modifiedOn desc";
		
		List<Inventory> inventories = session.createQuery(hql).setParameter("var", id).list(); 
		 System.out.println("size nya: "+inventories.size());
		if (inventories.isEmpty()) {
			return null; 
		} else {
			Inventory inv = inventories.get(0);
			System.out.println(inv);
			return inv;
		}
		
	}
	
	public List<Object[]> searchInventoryByItemAndVariantName(String search) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "select i.variant.item.name, i.id, i.variant.name, i.variant.price,  min(i.endingQty) from Inventory i where lower(i.variant.item.name) like :itemName or lower(i.variant.name) like :itemName group by i.variant.item.name, i.id, i.variant.name, i.variant.price";
		List<Object[]> inventories = session.createQuery(hql).setParameter("itemName", "%"+search.toLowerCase()+"%").list();
		if (inventories.isEmpty()) {
			return null;
		} else {
			return inventories;
		}
	}

	
}
