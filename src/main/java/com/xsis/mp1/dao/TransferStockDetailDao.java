package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.model.TransferStockDetail;

public interface TransferStockDetailDao {

	void save(TransferStockDetail tsDetail);

	List<TransferStockDetail> selectTsDetailByTS(TransferStock ts);

	List<TransferStockDetail> getTfStockByTfStockId(long id);

}
