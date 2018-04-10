package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Employee;
import com.xsis.mp1.model.User;

public interface UserDao {

	// save or update
	public void saveOrUpdate(User user);

	public int countUser(String user);

	public User getUserByEmployee(Employee emp);

	public void setInactive(long id);

	public List<Object> getUsernameByPrId(long id);
}
