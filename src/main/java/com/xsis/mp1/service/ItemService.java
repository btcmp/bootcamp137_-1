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
import com.xsis.mp1.model.Supplier;
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
		//List<Variant> variants = item.getVariants();
		//item.setVariants(null);
		itemDao.updateItemByName(item);
		List<Variant> variant2 = item.getVariants();
		List<Variant> variants=variantDao.getVarianByItem(item);
		if(variants != null) {
			for(Variant variant: variants) {
				System.out.println("delete");
				variantDao.delete(variant);
			}
		}
		 
	
		for(Variant variant: variant2) {
			variant.setId(null);
			Variant variant3=new Variant();
			variant3.setName(variant.getName());
			variant3.setItem(item);
			variant3.setPrice(variant.getPrice());
			variant3.setSku(variant.getSku());
			System.out.println(variant.getName());
			variantDao.save(variant3);
			Inventory inventory=variant.getInventories().get(0);
			
			if(inventory!=null) {
				
					Inventory inventory3=new Inventory();
					inventory3.setVariant(variant3);
					inventory3.setAlertAtQty(inventory.getAlertAtQty());
					inventory3.setBeginning(inventory.getBeginning());
					inventory3.setEndingQty(inventory.getEndingQty());
					inventory3.setOutlet(inventory.getOutlet());
					inventory3.setCreatedBy(inventory.getCreatedBy());
					inventory3.setCreatedOn(inventory.getCreatedOn());
					//System.out.println(inventory2.getOutlet().getId());
					inventoryDao.save(inventory3);
				
			}
		}
	}

	public List<Item> selectAllBySupplier(Supplier supplier) {
		// TODO Auto-generated method stub
		return itemDao.selectAllBySupplier(supplier);
	}

	public void updateStatus(Long idItem) {
		itemDao.updateStatus(idItem);
		
	}
}
