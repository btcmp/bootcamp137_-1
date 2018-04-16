package com.xsis.mp1.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.xsis.mp1.model.Adjustment;
import com.xsis.mp1.model.Category;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.SalesOrder;
import com.xsis.mp1.model.SalesOrderDetail;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.service.AdjustmentService;
import com.xsis.mp1.service.CategoryService;
import com.xsis.mp1.service.InventoryService;
import com.xsis.mp1.service.ItemService;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.POService;
import com.xsis.mp1.service.PRService;
import com.xsis.mp1.service.SalesOrderDetailService;
import com.xsis.mp1.service.SalesOrderService;
import com.xsis.mp1.service.SupplierService;
import com.xsis.mp1.service.TransferStockService;

@Controller
@RequestMapping("/generate")
public class ExportPDFController {
	
	@Autowired
	SupplierService supplierService;
	
	@Autowired
	InventoryService  inventoryService;
	
	@Autowired
	PRService prService;
	
	@Autowired
	POService poService;
	
	@Autowired
	TransferStockService tsService;
	
	@Autowired
	OutletService outletService; 
	
	@Autowired
	AdjustmentService adjustmentService;
	
	@Autowired
	CategoryService categoryService; 
	
	@Autowired
	SalesOrderDetailService salesOrderDetailService; 
	
	@RequestMapping(value = "/supplier", method = RequestMethod.GET)
	ModelAndView generatePdf(HttpServletRequest request,
	HttpServletResponse response) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"suppliers.pdf\"");
		response.setContentType("application/pdf");
		java.util.List<Supplier> suppliers = supplierService.selectAll();

	return new ModelAndView("pdfViewSupplier","suppliers",suppliers);
 	}
	
	@RequestMapping(value = "/item", method = RequestMethod.GET)
	ModelAndView itemGeneratePdf(HttpServletRequest request,
	HttpServletResponse response) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"items.pdf\"");
		response.setContentType("application/pdf");
		java.util.List<Inventory> inventories = inventoryService.selectAll();

	return new ModelAndView("pdfViewItem","inventory",inventories);
 	}
	
	@RequestMapping(value = "/pr", method = RequestMethod.GET)
	ModelAndView generatePdfPR(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"purchase_request.pdf\"");
		response.setContentType("application/pdf");
		java.util.List<PurchaseRequest> prs = prService.selectAll();

	return new ModelAndView("pdfViewPR","prs",prs);
 	}
	
	@RequestMapping(value = "/pr-detail/{id}", method = RequestMethod.GET)
	ModelAndView generatePdfPRD(HttpServletRequest request, @PathVariable long id, HttpServletResponse response) throws Exception{
		response.setHeader("Content-Disposition", "attachment; filename=\"pr_detail.pdf\"");
		response.setContentType("application/pdf");
		PurchaseRequest pr = prService.getOne(id);
		return new ModelAndView("pdfViewPRDetail", "pr", pr);
	}
	
	@RequestMapping(value = "/po", method = RequestMethod.GET)
	ModelAndView generatePdfPO(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"purchase_order.pdf\"");
		response.setContentType("application/pdf");
		java.util.List<PurchaseOrder> pos = poService.selectAll();

	return new ModelAndView("pdfViewPO","pos",pos);
 	}
	
	@RequestMapping(value = "/ts", method = RequestMethod.GET)
	ModelAndView generatePdfs(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"transfer_stock.pdf\"");
		response.setContentType("application/pdf");
		java.util.List<TransferStock> tss = tsService.selectAll();

	return new ModelAndView("pdfViewTS","tss",tss);
 	}
	
	/*@RequestMapping(value = "/ts-detail/{id}", method = RequestMethod.GET)
	ModelAndView generatePdfTSD(HttpServletRequest request, @PathVariable long id, HttpServletResponse response) throws Exception{
		response.setHeader("Content-Disposition", "attachment; filename=\"ts_detail.pdf\"");
		response.setContentType("application/pdf");
		TransferStock ts = tsService.getOne(id);
		return new ModelAndView("pdfViewTSDetail", "ts", ts);
	}*/
	
	@RequestMapping(value = "/outlet", method = RequestMethod.GET)
	ModelAndView generatePdfOutlet(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"outlet.pdf\"");
		response.setContentType("application/pdf");
		java.util.List<Outlet> outlets = outletService.selectAll();

	return new ModelAndView("pdfViewOutlet","outlets",outlets);
 	}
	
	@RequestMapping(value = "/category", method = RequestMethod.GET)
	ModelAndView generatePdfCategory(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"category.pdf\"");
		response.setContentType("application/pdf");
		java.util.List<Category> categories = categoryService.selectAll();

	return new ModelAndView("pdfViewCategory","categories",categories);
 	}
	
	@RequestMapping(value = "/sales-order/{id}", method = RequestMethod.GET)
	ModelAndView generatePdfSalesOrder(HttpServletRequest request, HttpServletResponse response, @PathVariable long id) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"sales-order.pdf\"");
		response.setContentType("application/pdf");
		List<SalesOrderDetail> salesOrderDetails = salesOrderDetailService.selectAll(id);

	return new ModelAndView("pdfViewSalesOrder","salesOrderDetails",salesOrderDetails);
 	}
	
	@RequestMapping(value = "/adjustment", method = RequestMethod.GET)
	ModelAndView generatePdfAdj(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"adjustment.pdf\"");
		response.setContentType("application/pdf");
		java.util.List<Adjustment> adjs = adjustmentService.selectAll();

	return new ModelAndView("pdfViewAdj","adjs",adjs);
 	}
}
