package com.xsis.mp1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xsis.mp1.dao.TransferStockDao;
import com.xsis.mp1.model.TransferStock;

@Service
@Transactional
public class TransferStockService {

	@Autowired
	TransferStockDao tsDao;
	
	public List<TransferStock> selectAll() {
		// TODO Auto-generated method stub
		return tsDao.selectAll();
	}

}
