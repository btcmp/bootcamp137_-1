package com.xsis.mp1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.xsis.mp1.model.Adjustment;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.service.AdjustmentService;
import com.xsis.mp1.service.InventoryService;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.PRService;

@Controller
@RequestMapping("/adjustment")
public class AdjustmentController {

	@Autowired
	AdjustmentService adjustmentService;
	
	@Autowired
	OutletService outletService;
	 
	@Autowired
	InventoryService inventoryService;
	
	@RequestMapping
	public String index(Model model) {
		List<Adjustment> adj = adjustmentService.selectAll();
		List<Outlet> outlets = outletService.selectAll();
		List<Inventory> inventories=inventoryService.selectAll();
		model.addAttribute("inventories", inventories);
		model.addAttribute("adj", adj);
		model.addAttribute("outlets", outlets);
		return "adjustment";
	}
	
	@RequestMapping(value="/detail/{id}", method = RequestMethod.GET)
	public String cari(@PathVariable long id, Model model) {
		System.out.println("search =" + id);
		Adjustment adj = adjustmentService.getOne(id);
		model.addAttribute("adj", adj);
		return "adjustment-detail";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody Adjustment adjustment) {
		adjustmentService.save(adjustment);
	}
	
	@RequestMapping(value = "/get-one/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Adjustment getOne(@PathVariable long id) {
		return adjustmentService.getOne(id);
	}
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.OK)
	public void delete(@PathVariable long id) {
		Adjustment adj = new Adjustment();
		adj.setId(id);
		adj.setStatus("0");
		adjustmentService.delete(adj);
	}
	
	@RequestMapping(value = "/search-item", method = RequestMethod.GET)
	@ResponseBody
	public List<Inventory> searchItem(@RequestParam(value="search", defaultValue="") String search) {
		List<Inventory> inventories = inventoryService.searchInventoryByItemName(search);
		System.out.println("search"+search);
		return inventories;
	}
	
	@RequestMapping(value="/approve/{id}", method=RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void approve(@PathVariable long id) {
		adjustmentService.approve(id);
	}
	
	@RequestMapping(value="/reject/{id}", method= RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void reject(@PathVariable long id) {
		adjustmentService.reject(id);
	}
	
	@RequestMapping(value="/create-po/{id}", method=RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void createPo(@PathVariable long id) {
		adjustmentService.createPo(id);
	}
}
