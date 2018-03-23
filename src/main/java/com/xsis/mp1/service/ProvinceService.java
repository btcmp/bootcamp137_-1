package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.ProvinceDao;
import com.xsis.mp1.model.Province;

@Service
@Transactional
public class ProvinceService {
	
	@Autowired
	ProvinceDao provinceDao; 
	
	public List<Province> selectAll(){
		return provinceDao.selectAll(); 
	}
}
