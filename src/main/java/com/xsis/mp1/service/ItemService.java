package com.xsis.mp1.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.InventoryDao;
import com.xsis.mp1.dao.ItemDao;
import com.xsis.mp1.dao.VariantDao;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.model.User;
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
	
	@Autowired
	HttpSession httpSession;
 
	public void save(Item item) {
		Outlet outlet = (Outlet) httpSession.getAttribute("outlet");
		List<Variant> variants = item.getVariants();
		item.setVariants(null);
		item.setCreatedBy(outlet.getId());
		itemDao.save(item);
		
		//objek variant
		for(Variant variant : variants) {
			List<Inventory> inventories= variant.getInventories();
			variant.setInventories(null);
			variant.setItem(item);
			variant.setCreatedBy(outlet.getId());
			variantDao.save(variant);
			
			
			//objek inventory
			for(Inventory inventory:inventories) {
				inventory.setVariant(variant);
				inventory.setCreatedBy(outlet.getId());
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
		User user = (User) httpSession.getAttribute("usernya");
		
		itemDao.updateItemByName(item);
		List<Variant> variant2 = item.getVariants();
		List<Variant> variants=variantDao.getVarianByItem(item);
		if(variants != null) {
			for(Variant variant: variants) {
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
			variant3.setCreatedBy(variant.getCreatedBy());
			variant3.setCreatedOn(variant.getCreatedOn());
			variant3.setModifiedBy(user.getId());
			variantDao.save(variant3);
			Inventory inventory=variant.getInventories().get(0);
			
			if(inventory!=null) {
				
					Inventory inventory3=new Inventory();
					inventory3.setVariant(variant3);
					inventory3.setAlertAtQty(inventory.getAlertAtQty());
					inventory3.setBeginning(inventory.getBeginning());
					inventory3.setEndingQty(inventory.getEndingQty());
					inventory3.setOutlet(inventory.getOutlet());
					System.out.println(inventory.getCreatedBy());
					inventory3.setCreatedBy(inventory.getCreatedBy());
					inventory3.setCreatedOn(inventory.getCreatedOn());
					inventory3.setModifiedBy(user.getId());
					//System.out.println(user.getName());
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
