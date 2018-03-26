package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.CustomerDao;
import com.xsis.mp1.model.Customer;

@Service
@Transactional
public class CustomerService {
	
	@Autowired
	CustomerDao customerDao; 
	
	public void save(Customer customer) {
		// TODO Auto-generated method stub
		customerDao.save(customer); 
	}

	public List<Customer> selectAll() {
		// TODO Auto-generated method stub
		return customerDao.selectAll();
	}

	public List<Customer> getCustomerByName(String name) {
		// TODO Auto-generated method stub
		return customerDao.getCustomerByName(name);
	}

}
