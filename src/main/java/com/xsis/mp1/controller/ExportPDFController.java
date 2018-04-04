package com.xsis.mp1.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.Supplier;
import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.service.PRService;
import com.xsis.mp1.service.SupplierService;
import com.xsis.mp1.service.TransferStockService;

@Controller
@RequestMapping("/generate")
public class ExportPDFController {
	
	@Autowired
	SupplierService supplierService;
	
	@Autowired
	PRService prService;
	
	@Autowired
	TransferStockService tsService;
	
	@RequestMapping(value = "/supplier", method = RequestMethod.GET)
	ModelAndView generatePdf(HttpServletRequest request,
	HttpServletResponse response) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"suppliers.pdf\"");
		response.setContentType("application/pdf");
		java.util.List<Supplier> suppliers = supplierService.selectAll();

	return new ModelAndView("pdfView","suppliers",suppliers);
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
	
	@RequestMapping(value = "/ts", method = RequestMethod.GET)
	ModelAndView generatePdfs(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("Calling generatePdf()...");
		//user data
		response.setHeader("Content-Disposition", "attachment; filename=\"transfer_stock.pdf\"");
		response.setContentType("application/pdf");
		java.util.List<TransferStock> tss = tsService.selectAll();

	return new ModelAndView("pdfViewTS","tss",tss);
 	}
}
