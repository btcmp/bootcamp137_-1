package com.xsis.mp1.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xsis.mp1.service.OutletService;

@Controller
@RequestMapping("/outlet")
public class OutletController {
	
	@Autowired
	OutletService outletService;
	
	@RequestMapping
	public String index(Model model) {
		return "outlet"; 
	}
}
