package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.AdjustmentDetail;


public interface AdjustmentDetailDao {
	public void save(AdjustmentDetail adjustmentDetail);
	
	public List<AdjustmentDetail> selectAll();
}
