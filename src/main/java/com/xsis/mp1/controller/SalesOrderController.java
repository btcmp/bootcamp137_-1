package com.xsis.mp1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.xsis.mp1.model.Customer;
import com.xsis.mp1.model.District;
import com.xsis.mp1.model.Province;
import com.xsis.mp1.model.Region;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.service.CustomerService;
import com.xsis.mp1.service.DistrictService;
import com.xsis.mp1.service.ProvinceService;
import com.xsis.mp1.service.RegionService;

@Controller
@RequestMapping("/sales-order")
public class SalesOrderController {
	
	@Autowired
	ProvinceService provinceService; 
	
	@Autowired
	RegionService regionService; 
	
	@Autowired
	DistrictService districtService; 
	
	@Autowired
	CustomerService customerService; 
	
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
	@RequestMapping(value="/save-customer", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void saveCustomer(@RequestBody Customer customer) {
		customerService.save(customer); 
	}
	
	@RequestMapping(value="/search-cust", method=RequestMethod.GET)
	@ResponseBody
	public List<Customer> getCustomerByName(@RequestParam (value="customer", defaultValue="") String name) {
		System.out.println("search =" + name);
		List<Customer> customers = customerService.getCustomerByName(name); 
		return customers; 
	}
}
