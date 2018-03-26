package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.ItemDao;
import com.xsis.mp1.dao.VariantDao;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Variant;

@Transactional
@Service
public class ItemService {
	@Autowired
	ItemDao itemDao;
	
	@Autowired
	VariantDao variantDao;

	public void save(Item item) {
		//objek item
		Item it= new Item();
		it.setName(it.getName());
		it.setActive(it.isActive());
		it.setCategoryId(it.getCategoryId());
		itemDao.save(it);
		
		//objek variant
		for(Variant var : item.getVariants()) {
			////////
			Variant variant=new Variant();
			variant.setName(variant.getName());
			variant.setActive(variant.isActive());
			variant.setPrice(variant.getPrice());
			variant.setSku(variant.getSku());
			variant.setItem(it);
			variantDao.save(variant);
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
		
		Item it= new Item();
		it.setName(it.getName());
		it.setActive(it.isActive());
		it.setCategoryId(it.getCategoryId());
		itemDao.update(it);
		
		//objek variant
		for(Variant var : item.getVariants()) {
			////////
			Variant variant=new Variant();
			variant.setName(variant.getName());
			variant.setActive(variant.isActive());
			variant.setPrice(variant.getPrice());
			variant.setSku(variant.getSku());
			variant.setItem(it);
			variantDao.saveOrUpdate(variant);
		}
	}
}
