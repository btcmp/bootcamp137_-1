package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.model.TransferStockHistory;

public interface TransferStockHistoryDao {

	void save(TransferStockHistory tsh);

	List<TransferStockHistory> selectHistoryByTS(TransferStock ts);

}
