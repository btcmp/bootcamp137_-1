package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.Supplier;

public interface InventoryDao {
	//save
	public void save(Inventory inventory);

	// read
	// Varian-- list
	public List<Inventory> selectAll();

	/// single employee
	public Inventory getOne(Inventory inventory);

	// update
	public void update(Inventory inventory);

	// delete
	public void delete(Inventory inventory);
 
	// save or update
	public void saveOrUpdate(Inventory inventory);
	
	public List<Inventory> selectAllByItem(Item item);

	public List<Inventory> searchInventoryByItemName(String search);


	public List<Inventory> selectAllByItemOutlet(Outlet outlet);

	public List<Inventory> selectAllByItemPo(Supplier supplier);
}
