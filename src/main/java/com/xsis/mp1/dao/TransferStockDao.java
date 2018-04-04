package com.xsis.mp1.dao;

import java.util.List;

import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.model.TransferStockDetail;

public interface TransferStockDao {

	List<TransferStock> selectAll();

	void save(TransferStock ts);

	TransferStock getOne(long id);

	void approve(long id);

	void reject(long id);

	List<TransferStockDetail> getTfStockByTfStockId(long id);

	List<TransferStock> searchTSByOutlet(long cari);

}
