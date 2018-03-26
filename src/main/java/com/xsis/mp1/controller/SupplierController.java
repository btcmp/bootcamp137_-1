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

import com.xsis.mp1.model.District;
import com.xsis.mp1.model.Province;
import com.xsis.mp1.model.Region;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.service.DistrictService;
import com.xsis.mp1.service.ProvinceService;
import com.xsis.mp1.service.RegionService;
import com.xsis.mp1.service.SupplierService;

@Controller
@RequestMapping("/supplier")
public class SupplierController {
	
	@Autowired
	SupplierService supplierService; 
	
	@Autowired
	ProvinceService provinceService; 
	
	@Autowired
	RegionService regionService; 
	
	@Autowired
	DistrictService districtService; 
	
	
	@RequestMapping
	public String index(Model model) {
		List<Supplier> suppliers = supplierService.selectAll(); 
		List<Province> provinces = provinceService.selectAll(); 
		List<Region> regions = regionService.selectAll();  
		List<District> districts = districtService.selectAll(); 
		model.addAttribute("suppliers", suppliers); 
		model.addAttribute("provinces", provinces); 
		model.addAttribute("regions", regions); 
		model.addAttribute("districts", districts); 
		return "supplier"; 
	}
	
	@RequestMapping(value="/get-region", method= RequestMethod.GET)
	@ResponseBody
	public List<Region> getRegion(Model model, @RequestParam(value="id", defaultValue="") long id){
		List<Region> regions = regionService.getRegion(id); 
		return regions; 
	}
	
	@RequestMapping(value="/get-district", method = RequestMethod.GET)
	@ResponseBody
	public List<District> getDistrict(Model model, @RequestParam(value="id", defaultValue="") long id){
		List<District> districts = districtService.getDistrict(id); 
		return districts; 
	}
	
	@RequestMapping(value="/search", method = RequestMethod.GET)
	public String Search(Model model, @RequestParam(value="search", defaultValue="")String search) {
		List<Supplier> supplier = supplierService.getSupplierBySearchName(search); 
//		List<Province> provinces = provinceService.selectAll(); 
//		List<Region> regions = regionService.selectAll();  
//		List<District> districts = districtService.selectAll(); 
		
		model.addAttribute("suppliers", supplier); 
//		model.addAttribute("provinces", provinces); 
//		model.addAttribute("regions", regions); 
//		model.addAttribute("districts", districts); 
		System.out.println("search:" + search);
		return "supplier"; 
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody Supplier supplier) {
		supplierService.save(supplier); 
	}
	
	@RequestMapping(value="/get-one/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Supplier getOne(@PathVariable long id) {
		return supplierService.getOne(id); 
	}
	
	@RequestMapping(value="/update", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public void update(@RequestBody Supplier supplier) {
		supplierService.update(supplier);
	}
}
