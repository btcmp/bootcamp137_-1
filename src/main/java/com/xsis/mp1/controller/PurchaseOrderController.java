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

import com.xsis.mp1.model.Category;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.model.Variant;
import com.xsis.mp1.service.ItemService;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.POService;
import com.xsis.mp1.service.PRService;
import com.xsis.mp1.service.SupplierService;
import com.xsis.mp1.service.VariantService;



@Controller
@RequestMapping("/t/po")
public class PurchaseOrderController {

	@Autowired
	ItemService itemService;
	
	@Autowired
	POService poService;
	 
	@Autowired
	SupplierService supplierService;
	
	@Autowired
	VariantService variantService;
	
	@Autowired
	PRService prService;
	
	@Autowired
	OutletService outletService;
	
	@RequestMapping
	public String index(Model model) {
		List<PurchaseOrder> pos = poService.selectAll();
		List<Supplier> suppliers = supplierService.selectAll();
		model.addAttribute("pos", pos);
		model.addAttribute("suppliers", suppliers);
		return "po";
	}
	
	
	@RequestMapping(value = "/get-one/{id}", method = RequestMethod.GET)
	@ResponseBody
	public PurchaseRequest getOne(@PathVariable long id) {
		return prService.getOne(id);
	}
	
	
	@RequestMapping(value = "/get-onepo/{id}", method = RequestMethod.GET)
	@ResponseBody
	public PurchaseOrder getOnePO(@PathVariable long id) {
		return poService.getOne(id);
	}
	
	@RequestMapping(value="/submit", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public void submit(@RequestBody PurchaseOrder po) {
		poService.update(po);
	}
	
	@RequestMapping(value="/update", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public void update(@RequestBody PurchaseOrder po) {
		poService.update(po);
	}
	
	@RequestMapping(value="/detail-po")
	public String indexDetailPO(Model model) {
		List<PurchaseOrder> pos = poService.selectAll();
		model.addAttribute("pos", pos);
		return "po-detail";
	}
	
	@RequestMapping(value="/detail/{id}", method = RequestMethod.GET)
	public String cari(@PathVariable long id, Model model) {
		System.out.println("search =" + id);
		PurchaseOrder po = poService.getOne(id);
		model.addAttribute("po", po);
		return "po-detail";
	}
	
	@RequestMapping(value="/get-inventory", method=RequestMethod.GET)
	@ResponseBody
	public List<Object> getInventory(@RequestParam(value="idPo", defaultValue="") long idPo, @RequestParam(value="idPod", defaultValue="") long idPod){
		return poService.getInventoryByVariantAndOutlet(idPod, idPo);
	}
	
	@RequestMapping(value="/get-supplier", method=RequestMethod.GET)
	@ResponseBody
	public Supplier getSupplierByPo(@RequestParam(value="idPo", defaultValue="") long idPo, @RequestParam(value="idSup", defaultValue="") long idSup){
		return poService.getSupplierByPo(idSup, idPo);
	}
	
	
//	status PO
	
	@RequestMapping(value="/approve/{id}", method=RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void approve(@PathVariable long id) {
		poService.approve(id);
	}
	
	@RequestMapping(value="/reject/{id}", method= RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void reject(@PathVariable long id) {
		poService.reject(id);
	}
	
	@RequestMapping(value="/process/{id}", method=RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	public void Process(@PathVariable long id) {
		poService.process(id);
	}
	
	@RequestMapping("/src-rg-date")
	@ResponseBody
	public List<PurchaseOrder> getByDate(@RequestParam(value="awal", defaultValue="") @DateTimeFormat(pattern="yyyy-MM-dd") Date awal, @RequestParam(value="akhir", defaultValue="") @DateTimeFormat(pattern="yyyy-MM-dd") Date akhir){
		return poService.getPOByDate(awal, akhir);
	}
	
	@RequestMapping(value = "/src-status", method = RequestMethod.GET)
	@ResponseBody
	public List<PurchaseOrder> getByStatus(@RequestParam(value="search", defaultValue="") String status){
		List<PurchaseOrder> po= poService.getPOByStatus(status);
		List<PurchaseOrder> po2=poService.selectAll();
		if(status.equals("all"))
			return po2;
		else
			return po;
	}
	
	@RequestMapping(value = "/src-global", method = RequestMethod.GET)
	@ResponseBody
	public List<PurchaseOrder> getByGlobal(@RequestParam(value="search", defaultValue="") String global){
		return poService.getPOByGlobal(global);
	}
	
	@RequestMapping(value="/get-created-by", method=RequestMethod.GET)
	@ResponseBody
	public List<Object> getCreatedBy(@RequestParam(value="id", defaultValue="") long id){
		return poService.getUsernameByPOId(id);
	}
	
	@RequestMapping("/get-po-need")
	@ResponseBody
	public int getPoNeed(){
		return poService.getPoNeedAction();
	}
	
}

