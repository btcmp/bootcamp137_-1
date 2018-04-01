package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.TransferStock;

public interface TransferStockDao {

	List<TransferStock> selectAll();

	void save(TransferStock ts);

	TransferStock getOne(TransferStock ts);

}
