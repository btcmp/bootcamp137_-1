package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.CategoryDao;
import com.xsis.mp1.model.Category;

@Service
@Transactional
public class CategoryService {
	
	@Autowired
	CategoryDao categoryDao; 
	
	public void save(Category category) {
		// TODO Auto-generated method stub
		categoryDao.save(category);
	}

	public void updateStatus(Category category) {
		// TODO Auto-generated method stub
		categoryDao.updateStatus(category);
	}
	
	public void update(Category category) {
		// TODO Auto-generated method stub
		categoryDao.update(category);
	}

	
	public void delete(long id) {
		// TODO Auto-generated method stub
		Category categories=new Category(); 
		categories.setId(id);
		categoryDao.delete(categories);
	}
	
	public List<Category> selectAll(){
		return categoryDao.selectAll(); 
	}
	
	public Category getOne(long id) {
		Category category = new Category(); 
		category.setId(id);
		return categoryDao.getOne(category); 
	}

	public List<Category> getListByStatus() {
		// TODO Auto-generated method stub
		return categoryDao.getListByStatus(); 
	}
	
	public Category getOne1(long id) {
		Category category = new Category(); 
		category.setId(id);
		return categoryDao.getOne(category); 
	}
}
