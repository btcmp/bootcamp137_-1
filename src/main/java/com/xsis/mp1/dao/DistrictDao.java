package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.District;

public interface DistrictDao {

	public List<District> selectAll();

	public List<District> getDistrict(long id); 
}
