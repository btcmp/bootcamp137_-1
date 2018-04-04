package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.InventoryDao;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.model.Variant;



@Service
@Transactional
public class InventoryService {
	@Autowired
	InventoryDao inventoryDao;

	public void save(Inventory inventory) {
		inventoryDao.save(inventory);
	}

	public List<Inventory> selectAll() {
		return inventoryDao.selectAll();
	}

	public Inventory getOne(Long id, Variant variant) {
		Inventory inventory = new Inventory();
		inventory.setVariant(variant);
		inventory.setId(id);
		inventory.setAlertAtQty(0);;
		inventory.setBeginning(0);
		inventory.getEndingQty();
		return inventoryDao.getOne(inventory);
	}

	public void update(Inventory inventory) {
		inventoryDao.update(inventory);
	}

	public void delete(Inventory inventory) {
		inventoryDao.delete(inventory);
	}
	
	public void saveOrUpdate(Inventory inventory) {
		inventoryDao.saveOrUpdate(inventory);
	}
	
	public List<Inventory> selectAllByItem(Item item) {
		return inventoryDao.selectAllByItem(item);
	}

	public List<Inventory> searchInventoryByItemName(String search) {
		return inventoryDao.searchInventoryByItemName(search);
	}


	public List<Inventory> selectAllByItemOulet(Outlet outlet) {
		return inventoryDao.selectAllByItemOutlet(outlet);
	}

	public List<Inventory> selectAllByItemSupplierByPo(Supplier supplier) {
		// TODO Auto-generated method stub
		return inventoryDao.selectAllByItemPo(supplier);
	}

	public Inventory getOneInventory(long id) {
		// TODO Auto-generated method stub
		return inventoryDao.getOneInvetory(id);
	}

	
	public List<Object[]> searchInventoryByItemAndVariantName(String search) {
		// TODO Auto-generated method stub
		return inventoryDao.searchInventoryByItemAndVariantName(search);
	}

	 

}
