package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Customer;

public interface CustomerDao {

	void save(Customer customer);

	List<Customer> selectAll();

	List<Customer> getCustomerByName(String name);

}
