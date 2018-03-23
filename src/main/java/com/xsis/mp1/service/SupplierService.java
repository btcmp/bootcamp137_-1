package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.SupplierDao;
import com.xsis.mp1.model.Supplier;

@Service
@Transactional
public class SupplierService {
	
	@Autowired
	SupplierDao supplierDao; 
	
	public void save(Supplier supplier) {
		supplierDao.save(supplier);
	}
	
	public void update(Supplier supplier) {
		supplierDao.update(supplier);
	}
	
	public void delete(long id) {
		Supplier supplier= new Supplier(); 
		supplier.setId(id);
		supplierDao.delete(supplier);
	}
	
	public List<Supplier> selectAll(){
		return supplierDao.selectAll(); 
	}
	
	public Supplier getOne(long id) {
		Supplier supplier= new Supplier();
		supplier.setId(id);
		return supplierDao.getOne(supplier); 
	}
}
