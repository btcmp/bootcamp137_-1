package com.xsis.mp1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.service.PRService;

@Controller
@RequestMapping("/pr")
public class PRController {

	@Autowired
	PRService prService;
	
	public String index(Model model) {
		List<PurchaseRequest> prs = prService.selectAll();
		model.addAttribute("prs", prs);
		return "pr";
	}
}
