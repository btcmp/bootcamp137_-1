package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Variant;

public interface VariantDao {
	//save
	public void save(Variant variant);

	// read
	// Varian-- list
	public List<Variant> selectAll();

	/// single employee
	public Variant getOne(Variant variant);

	// update
	public void update(Variant variant);

	// delete
	public void delete(Variant variant);

	// save or update
	public void saveOrUpdate(Variant variant);
 
	public List<Variant> getVarianByItem(Item item);

	public List<Variant> getVariantByName(String name);

	public Variant getOneItem(long id);
	 
}
