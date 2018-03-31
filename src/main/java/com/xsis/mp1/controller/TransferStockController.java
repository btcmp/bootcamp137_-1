package com.xsis.mp1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.TransferStockService;

@Controller
@RequestMapping("/ts")
public class TransferStockController {

	@Autowired
	TransferStockService tsService;
	
	@Autowired
	OutletService outletService;
	
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
		tsService.save(ts);
	}
}
