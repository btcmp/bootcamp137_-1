package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Category;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Supplier;


public interface ItemDao {
	// create
		public void save(Item item);

		// read
		// Item-- list
		public List<Item> selectAll();

		/// single employee
		public Item getOne(Item item);

		// update
		public void update(Item item);

		// delete
		public void delete(Item item);
 
		// save or update
		public void saveOrUpdate(Item item);

		public List<Item> getItemsByCategory(Category category);
 
		public void updateItemByName(Item item);

		public List<Item> selectAllBySupplier(Supplier supplier);

		public void updateStatus(Long idItem);
}
 