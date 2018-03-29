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

import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.service.InventoryService;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.PRService;

@Controller
@RequestMapping("/pr")
public class PRController {

	@Autowired
	PRService prService;
	
	@Autowired
	OutletService outletService;
	
	@Autowired
	InventoryService inventoryService;
	
	@RequestMapping
	public String index(Model model) {
		List<PurchaseRequest> prs = prService.selectAll();
		List<Outlet> outlets = outletService.selectAll();
		List<Inventory> inventories=inventoryService.selectAll();
		model.addAttribute("inventories", inventories);
		model.addAttribute("prs", prs);
		model.addAttribute("outlets", outlets);
		return "pr";
	}
	
	@RequestMapping(value="/detail", method = RequestMethod.GET)
	@ResponseBody
	public PurchaseRequest cari(@RequestParam("id") long id, Model model) {
		System.out.println("search =" + id);
		return prService.getOne(id);
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody PurchaseRequest pr) {
		prService.save(pr);
	}
	
	@RequestMapping(value = "/get-one/{id}")
	@ResponseBody
	public PurchaseRequest getOne(@PathVariable long id) {
		return prService.getOne(id);
	}
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.OK)
	public void delete(@PathVariable long id) {
		PurchaseRequest pr = new PurchaseRequest();
		pr.setId(id);
		pr.setStatus("0");
		pr.setPrNo("0");
		prService.delete(pr);
	}
	
	/*@RequestMapping(value = "/search-item", method = RequestMethod.GET)
	@ResponseBody
	public List<Inventory> searchItem(@RequestParam(value="search", defaultValue="") String search) {
		List<Inventory> inventories = inventoryService.searchInventoryByItemName(search);
		System.out.println("search"+search);
		return inventories;
	}*/
}
