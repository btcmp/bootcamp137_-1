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

import com.xsis.mp1.model.Customer;
import com.xsis.mp1.model.District;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Province;
import com.xsis.mp1.model.Region;
import com.xsis.mp1.model.SalesOrder;
import com.xsis.mp1.model.SalesOrderDetail;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.model.Variant;
import com.xsis.mp1.service.CustomerService;
import com.xsis.mp1.service.DistrictService;
import com.xsis.mp1.service.InventoryService;
import com.xsis.mp1.service.ProvinceService;
import com.xsis.mp1.service.RegionService;
import com.xsis.mp1.service.SalesOrderService;
import com.xsis.mp1.service.VariantService;

@Controller
@RequestMapping("/t/payment/sales-order")
public class SalesOrderController {
	
	@Autowired
	ProvinceService provinceService; 
	
	@Autowired
	RegionService regionService; 
	
	@Autowired
	DistrictService districtService; 
	
	@Autowired
	CustomerService customerService; 
	
	@Autowired
	VariantService variantService;
	
	@Autowired
	SalesOrderService salesOrderService; 
	
	@Autowired
	InventoryService inventoryService; 
	
	@RequestMapping
	public String index(Model model) {
		List<Customer> customers = customerService.selectAll();
		List<Province> provinces = provinceService.selectAll(); 
		List<Region> regions = regionService.selectAll(); 
		List<District> districts = districtService.selectAll(); 
		model.addAttribute("customers", customers); 
		model.addAttribute("provinces", provinces); 
		model.addAttribute("regions", regions); 
		model.addAttribute("districts", districts ); 
		return "sales-order"; 
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void saveSalesOrder(@RequestBody SalesOrder salesOrder) {
		salesOrderService.save(salesOrder); 
	}
	
	@RequestMapping(value="/update-stock", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public void updateStock (@RequestBody SalesOrder salesOrder) {
		salesOrderService.updateStock(salesOrder); 
	}
	
	@RequestMapping(value="/get-region", method=RequestMethod.GET)
	@ResponseBody
	public List<Region> getRegion(Model model, @RequestParam(value="id", defaultValue="") long id){
		List<Region> regions = regionService.getRegion(id); 
		return regions; 
	}
	
	@RequestMapping(value="/get-district", method=RequestMethod.GET)
	@ResponseBody
	public List<District> getDistrict(Model model, @RequestParam(value="id", defaultValue="")long id){
		List<District> districts = districtService.getDistrict(id); 
		return districts; 
	}
	
	@RequestMapping(value="/customer", method=RequestMethod.GET)
	public String listCustomer(Model model) {
		List<Customer> customers = customerService.selectAll(); 
		model.addAttribute("customers", customers); 
		return "choose-cust"; 
	}
	
	@RequestMapping(value="/get-all-customer", method=RequestMethod.GET)
	@ResponseBody
	public List<Customer> getAll(){
		return customerService.selectAll(); 
	}
	
	@RequestMapping(value="/save-customer", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void saveCustomer(@RequestBody Customer customer) {
		customerService.save(customer); 
	}
	
	@RequestMapping(value="/search-cust", method=RequestMethod.GET)
	@ResponseBody
	public List<Customer> getCustomerByName(@RequestParam (value="customer", defaultValue="") String name) {
		//System.out.println("search =" + name);
		List<Customer> customers = customerService.getCustomerByName(name); 
		return customers; 
	}
	
	@RequestMapping(value="/search-variant", method=RequestMethod.GET)
	@ResponseBody
	public List<Variant> getItemByName(@RequestParam(value="variant", defaultValue="") String name){
		System.out.println("search = " + name);
		List<Variant> variants = variantService.getVariantByName(name); 
		return variants; 
	}
	
	@RequestMapping(value="/search-item", method=RequestMethod.GET)
	@ResponseBody
	public List<Object[]> getInventoryByItemAndVariantName(@RequestParam(value="inventory", defaultValue="")String search){
		//System.out.println("search = " + search);
		List<Object[]> inventories = inventoryService.searchInventoryByItemAndVariantName(search); 
		return inventories; 
	}
	
	@RequestMapping (value= "/get-item/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Inventory getOneInventory(@PathVariable long id) {
		return inventoryService.getOneInventory(id); 
	}
}
