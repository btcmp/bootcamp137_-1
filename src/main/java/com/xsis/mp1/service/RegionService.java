package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.RegionDao;
import com.xsis.mp1.model.Region;

@Service
@Transactional
public class RegionService {
		
	@Autowired
	RegionDao regionDao;
	
	public List<Region> selectAll(){
		return regionDao.selectAll(); 
	}

	public List<Region> getRegion(long id) {
		// TODO Auto-generated method stub
		return regionDao.getRegion(id);
	}
}
