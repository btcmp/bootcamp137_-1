package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.VariantDao;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Variant;

@Service
@Transactional
public class VariantService {
	@Autowired
	VariantDao variantDao;

	public void save(Variant variant) {
		variantDao.save(variant);
	}

	public List<Variant> selectAll() {
		return variantDao.selectAll();
	}

	public Variant getOne(Long id, Item item) {
		Variant variant = new Variant();
		variant.setId(id);
		variant.setItem(item);
		variant.setName("0");
		variant.setSku("0");;
		variant.setPrice(0);
		variant.setActive(false);
		return variantDao.getOne(variant);
	}
 
	public void update(Variant variant) {
		variantDao.update(variant);
	}

	public void delete(Variant variant) {
		variantDao.delete(variant);
	}
	
	public void saveOrUpdate(Variant variant) {
		variantDao.saveOrUpdate(variant);
	}
	
	

}
