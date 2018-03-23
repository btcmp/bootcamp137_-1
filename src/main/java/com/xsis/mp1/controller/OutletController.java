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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.xsis.mp1.model.District;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.Province;
import com.xsis.mp1.model.Region;
import com.xsis.mp1.service.DistrictService;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.ProvinceService;
import com.xsis.mp1.service.RegionService;

@Controller
@RequestMapping("/outlet")
public class OutletController {
	
	@Autowired
	OutletService outletService;
	
	@Autowired
	ProvinceService provinceService; 
	
	@Autowired
	RegionService regionService; 
	
	@Autowired
	DistrictService distrcitService; 
	
	
	@RequestMapping
	public String index(Model model) {
		List< Outlet> outlets = outletService.selectAll(); 
		List<Province> provinces = provinceService.selectAll(); 
		List<Region> regions = regionService.selectAll(); 
		List<District> districts = distrcitService.selectAll(); 
		model.addAttribute("outlets", outlets); 
		model.addAttribute("provinces", provinces); 
		model.addAttribute("regions", regions); 
		model.addAttribute("districts",districts);
		return "outlet"; 
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody Outlet outlet) {
		outletService.save(outlet);
	}
	
	@RequestMapping(value="/get-one/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Outlet getOne(@PathVariable long id) {
		return outletService.getOne(id); 
	}
	
	@RequestMapping(value="/update", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public void update(@RequestBody Outlet outlet) {
		outletService.update(outlet); 
	}
}
