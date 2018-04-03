package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.Adjustment;
import com.xsis.mp1.model.AdjustmentHistory;


public interface AdjustmentHistoryDao {

	void save(AdjustmentHistory adjh);

	List<AdjustmentHistory> selectHistoryByAdjustment(Adjustment adjustment);

}
 