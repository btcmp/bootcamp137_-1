package com.xsis.mp1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.model.Variant;
import com.xsis.mp1.service.ItemService;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.POService;
import com.xsis.mp1.service.SupplierService;
import com.xsis.mp1.service.VariantService;



@Controller
@RequestMapping("/po")
public class PurchaseOrderController {

	@Autowired
	ItemService itemService;
	
	@Autowired
	POService poService;
	 
	@Autowired
	SupplierService supplierService;
	
	@Autowired
	VariantService variantService;
	
	@RequestMapping
	public String index(Model model) {
		List<PurchaseOrder> pos = poService.selectAll();
		List<Supplier> suppliers = supplierService.selectAll();
		model.addAttribute("pos", pos);
		model.addAttribute("suppliers", suppliers);
		return "po";
	}
	
	@RequestMapping(value="/get-one/{id}", method=RequestMethod.GET)
	@ResponseBody
	public List<Variant> getOne(@PathVariable long id, Model model, PurchaseRequest purchaseRequest){
		List<Variant> variants=variantService.getVariantByPR(purchaseRequest);
		System.out.println("dapat");
		model.addAttribute("variants", variants);
		return variants;
	}
	
	@RequestMapping(value="/detail-po")
	public String indexDetailPO(Model model) {
		List<PurchaseOrder> pos = poService.selectAll();
		model.addAttribute("pos", pos);
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

