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

import com.xsis.mp1.model.Category;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.service.CategoryService;
import com.xsis.mp1.service.ItemService;



@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	ItemService itemService;
	
	@Autowired
	CategoryService CategoryService;
	
	@RequestMapping
	public String index(Model model) {
		List<Item> items = itemService.selectAll();
		model.addAttribute("items", items);
		List<Category> categories=CategoryService.selectAll();
		model.addAttribute("categories", categories);
		return "item";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody Item item) {
		itemService.save(item);
	}

	
}

