package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.ItemDao;
import com.xsis.mp1.model.Item;

@Transactional
@Service
public class ItemService {
	@Autowired
	ItemDao itemDao;

	public void save(Item item) {
		itemDao.save(item);
	}

	public List<Item> selectAll() {
		return itemDao.selectAll();
	}

	public Item getOne(int id) {
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
		itemDao.saveOrUpdate(item);
	}
}
