package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Category;

public interface CategoryDao {
	//create
	public void save(Category category); 
	//read 
	///banyak 
	public List<Category> selectAll();  
	
	///satu 
	public Category getOne(Category category);
	
	//update / edit 
	public void update(Category category); 
	
	public void saveOrUpdate(Category category); 
	
	//delete 
	public void delete(Category category);
}
