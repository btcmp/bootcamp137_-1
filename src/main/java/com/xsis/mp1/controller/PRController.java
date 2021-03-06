package com.xsis.mp1.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
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
import com.xsis.mp1.model.User;
import com.xsis.mp1.service.InventoryService;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.PRService;

@Controller
@RequestMapping("/t/pr")
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
	
	@RequestMapping(value="/detail/{id}", method = RequestMethod.GET)
	public String cari(@PathVariable long id, Model model) {
		System.out.println("search =" + id);
		PurchaseRequest pr = prService.getOne(id);
		model.addAttribute("pr", pr);
		return "pr-detail";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody PurchaseRequest pr) {
		prService.save(pr);
	}
	
	@RequestMapping("/get-all")
	@ResponseBody
	public List<PurchaseRequest> getAll(){
		return prService.selectAll();
	}
	
	@RequestMapping(value = "/get-one/{id}", method = RequestMethod.GET)
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
	
	@RequestMapping(value = "/search-item", method = RequestMethod.GET)
	@ResponseBody
	public List<Inventory> searchItem(@RequestParam(value="search", defaultValue="") String search) {
		List<Inventory> inventories = inventoryService.searchInventoryByItemNameAndOutlet(search);
		System.out.println("search"+search);
		return inventories;
	}
	
	@RequestMapping("/src-rg-date")
	@ResponseBody
	public List<PurchaseRequest> getByDate(@RequestParam(value="awal", defaultValue="") @DateTimeFormat(pattern="yyyy-MM-dd") Date awal, @RequestParam(value="akhir", defaultValue="") @DateTimeFormat(pattern="yyyy-MM-dd") Date akhir){
		return prService.getPRByDate(awal, akhir);
	}
	
	@RequestMapping(value = "/src-status", method = RequestMethod.GET)
	@ResponseBody
	public List<PurchaseRequest> getByStatus(@RequestParam(value="search", defaultValue="") String status){
		return prService.getPRByStatus(status);
	}
	
	@RequestMapping(value = "/src-global", method = RequestMethod.GET)
	@ResponseBody
	public List<PurchaseRequest> getByGlobal(@RequestParam(value="search", defaultValue="") String global){
		return prService.getPRByGlobal(global);
	}
	
	@RequestMapping(value="/submitted/{id}", method=RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void submitted(@PathVariable long id) {
		prService.submitted(id);
	}
	
	@RequestMapping(value="/approve/{id}", method=RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void approve(@PathVariable long id) {
		prService.approve(id);
	}
	
	@RequestMapping(value="/reject/{id}", method= RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void reject(@PathVariable long id) {
		prService.reject(id);
	}
	
	@RequestMapping(value="/create-po/{id}", method=RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void createPo(@PathVariable long id) {
		prService.createPo(id);
	}
	
	@RequestMapping(value="/get-inventory", method=RequestMethod.GET)
	@ResponseBody
	public List<Object> getInventory(@RequestParam(value="idPr", defaultValue="") long idPr, @RequestParam(value="idPrd", defaultValue="") long idPrd){
		return prService.getInventoryByVariantAndOutlet(idPrd, idPr);
	}
	
	@RequestMapping(value="/get-created-by", method=RequestMethod.GET)
	@ResponseBody
	public List<Object> getCreatedBy(@RequestParam(value="id", defaultValue="") long id){
		return prService.getUsernameByPrId(id);
	}
	
	@RequestMapping("/get-pr-need")
	@ResponseBody
	public int getPrNeed(){
		return prService.getPrNeedAction();
	}
	
}
