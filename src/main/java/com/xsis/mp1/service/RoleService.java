package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.RoleDao;
import com.xsis.mp1.model.Role;

@Service
@Transactional
public class RoleService {

	@Autowired
	RoleDao roleDao;

	public List<Role> selectAll() {
		// TODO Auto-generated method stub
		return roleDao.selectAll();
	}
	
	
}
