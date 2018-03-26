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

import com.xsis.mp1.model.Category;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.service.CategoryService;

@Controller
@RequestMapping("/category")
public class CategoryController {
	
	@Autowired
	CategoryService categoryService; 
	
	@RequestMapping
	public String index(Model model) {
		List<Category> categories = categoryService.selectAll(); 
		model.addAttribute("categories", categories); 
		return "category";
	}
	
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String indexMainSearch(Model model, @RequestParam(value="search", defaultValue="")String search) {
		List<Category> categoryStatus = categoryService.getListByStatus(); 
		List<Category> categories =categoryService.getCategoryBySearchName(search); 
		model.addAttribute("categoryStatus", categoryStatus); 
		model.addAttribute("categories", categories); 
		return "category"; 
	}
	/*@RequestMapping(value="/get-one/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Category getOne(@PathVariable long id) {
		return categoryService.getOne(id); 
	}*/
	
	@RequestMapping(value="/get-one/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Category getOne1(@PathVariable long id) {
		return categoryService.getOne(id); 
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody Category category) {
		categoryService.save(category); 
	}
	
	@RequestMapping(value="/update", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public void edit(@RequestBody Category category) {
		categoryService.update(category); 
	}
	
	@RequestMapping(value="/update-status", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public void updateStatus(@RequestBody Category category) {
		categoryService.updateStatus(category); 
	}
	
	@RequestMapping(value="delete/{id}", method=RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.OK)
	public void delete(@PathVariable long id) {
		categoryService.delete(id); 
	}
}
