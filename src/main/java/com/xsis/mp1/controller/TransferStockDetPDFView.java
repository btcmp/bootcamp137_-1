package com.xsis.mp1.controller;

import java.io.StringReader;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.html.simpleparser.HTMLWorker;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.xsis.mp1.model.TransferStock;
import com.xsis.mp1.model.TransferStockDetail;
import com.xsis.mp1.model.TransferStockHistory;
import com.xsis.mp1.model.User;

public class TransferStockDetPDFView extends AbstractPdfView{

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		TransferStock pr = (TransferStock) model.get("pr");
		
		PdfPTable tabHistory = new PdfPTable(1);
		tabHistory.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
		tabHistory.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		for (TransferStockHistory prh : pr.getTsHistories()) {
			tabHistory.addCell("On " + prh.getCreatedOn() + " - " + prh.getStatus());
		}
		
		PdfPTable tabDetail = new PdfPTable(2);
		tabHistory.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		tabHistory.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		
		tabDetail.addCell("Item");
		tabDetail.addCell("Transfer Quantity");
		for (TransferStockDetail prd: pr.getTsDetails()) {
			tabDetail.addCell(prd.getVariant().getItem().getName() + " - " + prd.getVariant().getName());
			tabDetail.addCell(prd.getTransferQty()+"");
		}
		
		HTMLWorker htmlWorker = new HTMLWorker(document);
		String head = "<html><head></head>"
				+ "<body><h2 style='text-align:center'>Purchase Request Detail</h2><hr>"
				//+ "<p>PR Number : "+ pr.getPrNo() +"</p>"
				//+ "<p>Created By : "+ usr.getUsername() +"</p>"
				//+ "<p>Target Waktu Item Ready : "+ pr.getReadyTime() +"</p>"
				+ "<p>PR Status : "+ pr.getStatus() +"</p>"
				+ "<p>Notes :</p>"
				+ "<textarea id='view-notes' style='height:100px; width:100%; border: #000 1px solid;'>"+ pr.getNotes() +"</textarea>"
				+ "<br><br><br>"
				+ "</body></html>";
		htmlWorker.parse(new StringReader(head));
		
		String headHistory = "<html><body><br><h3>Purchase History</h3><br></body></html>";
		htmlWorker.parse(new StringReader(headHistory));
		document.add(tabHistory);
		
		
		String headDetail = "<html><body><br><h3>Item List</h3><br></body></html>";
		htmlWorker.parse(new StringReader(headDetail));
		document.add(tabDetail);
	}
}
