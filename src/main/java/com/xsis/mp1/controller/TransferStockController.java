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
import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.service.InventoryService;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.TransferStockService;

@Controller
@RequestMapping("/ts")
public class TransferStockController {

	@Autowired
	TransferStockService tsService;
	
	@Autowired
	OutletService outletService;
	
	@Autowired
	InventoryService inventoryService;
	
	@RequestMapping
	public String index(Model model) {
		List<TransferStock> tss = tsService.selectAll();
		List<Outlet> outlets = outletService.selectAll();
		model.addAttribute("tss", tss);
		model.addAttribute("outlets", outlets);
		return "ts";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody TransferStock ts) {
		System.out.println("ok");
		tsService.save(ts);
	}
	
	@RequestMapping(value="/get-one/{id}", method=RequestMethod.GET)
	@ResponseBody
	public TransferStock getOne(@PathVariable long id) {
		return tsService.getOne(id);
	}
	
	/*@RequestMapping(value = "/approve/{id}", method = RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public void updateStatusAndStock(@RequestBody String newStatus, @PathVariable long id) {
		TransferStock ts = tsService.getOne(id);
		ts.setStatus(newStatus);
		tsService.updateStock(ts);
	}*/

	@RequestMapping(value="/detail/{id}", method = RequestMethod.GET)
	public String cari(@PathVariable long id, Model model) {
		System.out.println("search =" + id);
		TransferStock ts = tsService.getOne(id);
		model.addAttribute("ts", ts);
		return "ts-detail";
	}
	
	@RequestMapping(value = "/search-item", method = RequestMethod.GET)
	@ResponseBody
	public List<Inventory> searchItem(@RequestParam(value="search", defaultValue="") String search) {
		List<Inventory> inventories = inventoryService.searchInventoryByItemName(search);
		System.out.println("search"+search);
		return inventories;
	}
	
	@RequestMapping(value = "/src-outlet", method = RequestMethod.GET)
	@ResponseBody
	public List<TransferStock> getByStatus(@RequestParam(value="search", defaultValue="") long cari){
		return tsService.getTSByOutlet(cari);
	}
	
	@RequestMapping(value="/approve/{id}", method=RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void approve(@PathVariable long id) {
		tsService.approve(id);
	}
	
	@RequestMapping(value="/reject/{id}", method= RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void reject(@PathVariable long id) {
		tsService.reject(id);
	}
}
