package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.InventoryDao;
import com.xsis.mp1.model.Inventory;
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

	public Inventory getOne(int id, Variant variant) {
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

}
