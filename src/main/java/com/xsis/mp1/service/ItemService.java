package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.InventoryDao;
import com.xsis.mp1.dao.ItemDao;
import com.xsis.mp1.dao.VariantDao;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Variant;

@Transactional
@Service
public class ItemService {
	@Autowired
	ItemDao itemDao;
	
	@Autowired
	VariantDao variantDao;
	
	@Autowired
	InventoryDao inventoryDao;

	public void save(Item item) {
		List<Variant> variants = item.getVariants();
		item.setVariants(null);
		itemDao.save(item);
		
		//objek variant
		for(Variant variant : variants) {
			List<Inventory> inventories= variant.getInventories();
			variant.setInventories(null);
			variant.setItem(item);
			variantDao.save(variant);
			
			
			//objek inventory
			for(Inventory inventory:inventories) {
				inventory.setVariant(variant);
				inventoryDao.save(inventory);
			}
		}
	}

	public List<Item> selectAll() {
		return itemDao.selectAll();
	}

	public Item getOne(long id) {
		Item item = new Item();
		item.setId(id);
		item.setActive(false);
		return itemDao.getOne(item);
	}

	public void update(Item item) {
		itemDao.update(item);
	}

	public void delete(Item item) {
		itemDao.delete(item);
	}
	
	public void saveOrUpdate(Item item) {
		List<Variant> variant = item.getVariants();
		item.setVariants(null);
		itemDao.update(item);
		
		//objek variant
		for(Variant var : variant) {
			////////
			var.setItem(item);
			variantDao.saveOrUpdate(var);
		}
	}
}
