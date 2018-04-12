package com.xsis.mp1.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

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
import org.springframework.web.multipart.MultipartFile;

import com.xsis.mp1.dao.VariantDao;
import com.xsis.mp1.model.Category;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.model.Variant;
import com.xsis.mp1.service.CategoryService;
import com.xsis.mp1.service.InventoryService;
import com.xsis.mp1.service.ItemService;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.SupplierService;
import com.xsis.mp1.service.VariantService;



@Controller
@RequestMapping("/mst/item-outlet")
public class ItemOutletController {

	@Autowired
	ServletContext servletContext;
	
	@Autowired
	ItemService itemService;
	 
	@Autowired
	CategoryService CategoryService;
	
	@Autowired
	VariantService variantService;
	 
	@Autowired
	InventoryService inventoryService;
	
	@Autowired
	OutletService outletService;
	
	@RequestMapping
	public String index(Model model) {
		List<Item> items = itemService.selectAll();
		model.addAttribute("items", items);
		List<Category> categories=CategoryService.selectAll();
		model.addAttribute("categories", categories);
		List<Variant> variants =variantService.selectAll();
		model.addAttribute("variants", variants);
		List<Inventory> inventories=inventoryService.selectAllItemByOutlet();
		model.addAttribute("inventories", inventories);

		return "item-outlet";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody Item item) {
		itemService.save(item);
	}
	
	@RequestMapping(value="/getOne/{id}", method=RequestMethod.PUT)
	@ResponseBody
	public List<Inventory> getOne(@PathVariable long id, Model model, Item item) {
		List<Inventory> inventory=inventoryService.selectAllByItem(item);
		model.addAttribute("inventory", inventory);
		return inventory;
	}
	@RequestMapping(value="/edit", method=RequestMethod.PUT)
	//@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public Item edit(@RequestBody Item item) {
		itemService.saveOrUpdate(item);
		return item;
	}
	
	@RequestMapping(value="/get-item/{id}", method=RequestMethod.PUT)
	@ResponseBody
	public List<Inventory> geItem(@PathVariable long id, Model model,Outlet outlet) {
		List<Inventory> inventories=inventoryService.selectAllByItemOulet(outlet);
		model.addAttribute("inventories", inventories);
		return inventories;
	}
	
	@RequestMapping(value="/get-item-by-po/{id}", method=RequestMethod.PUT)
	@ResponseBody
	public List<Inventory> geItemByPo(@PathVariable long id, Model model, Supplier supplier) {
		List<Inventory> inventories=inventoryService.selectAllByItemSupplierByPo(supplier);
		model.addAttribute("inventories", inventories);
		return inventories;
	}
	
	@RequestMapping(value = "/search-item", method = RequestMethod.GET)
	@ResponseBody
	public List<Inventory> searchItemByOutlet(@RequestParam(value="search", defaultValue="") String search, @RequestParam(value="idOut", defaultValue="") long idOut) {
		List<Inventory> inventories = inventoryService.searchInventoryByItemNameAndOutLet(search, idOut);
		List<Inventory> inventories2 = inventoryService.selectAll();
		if(inventories.isEmpty())
			return inventories2;
		else
			return inventories;
	}
	
	@RequestMapping(value="/update-status/{idItem}", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public void updateStatus(@PathVariable Long idItem) {
		itemService.updateStatus(idItem); 
	}
	
	@RequestMapping(value="/upload", method=RequestMethod.POST)
	@ResponseBody
	public String upload(@RequestParam("image") MultipartFile file) {
		String name="";
		try {
			String tamp = file.getOriginalFilename().toString();
			String[] type = tamp.split("\\.");
			int len = type.length;
			name = (System.currentTimeMillis())+"."+type[len-1];
			BufferedImage src = ImageIO.read(new ByteArrayInputStream(file.getBytes()));
		    File destination = new File(servletContext.getRealPath("/resources/img/"+name));
		    ImageIO.write(src, type[len-1], destination);
		    
		    } catch(Exception e) {
		        e.printStackTrace();
		        
		    }
		return name;
	}
}