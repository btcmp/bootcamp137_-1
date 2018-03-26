package com.xsis.mp1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xsis.mp1.model.Item;
import com.xsis.mp1.service.ItemService;



@Controller
@RequestMapping("/po")
public class PurchaseOrderController {

	@Autowired
	ItemService itemService;
	
	@RequestMapping
	public String index(Model model) {
		List<Item> items = itemService.selectAll();
		model.addAttribute("items", items);
		return "po";
	}
	
	@RequestMapping(value="/detail-po")
	public String indexDetailPO(Model model) {
		List<Item> items = itemService.selectAll();
		model.addAttribute("items", items);
		return "detail-po";
	}
	
//	test adjusment di titip disini
	@RequestMapping(value="/adjustment-list")
	public String indexa(Model model) {
		
		return "adjustment-list";
	}
	
//	test adjusment-detail di titip disini
	@RequestMapping(value="/detail-adjustment")
	public String indexde(Model model) {
		
		return "detail-adjustment";
	}
	
//	test transferStrock
	@RequestMapping(value="/transfer-stock")
	public String indexts(Model model) {
		
		return "transfer-stock";
	}
	
//	test transfer-stock-detail di titip disini
	@RequestMapping(value="/transfer-stock-detail")
	public String indexTSD(Model model) {
		
		return "transfer-stock-detail";
	}

	
}

