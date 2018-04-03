package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Adjustment;
import com.xsis.mp1.model.AdjustmentDetail;


public interface AdjustmentDetailDao {
	void save(AdjustmentDetail adjustmentDetail);

	List<AdjustmentDetail> selectAdjustmentDetailByadjustment(Adjustment adjustment);

	void delete(AdjustmentDetail adjustmentDetail);
}
 