package com.xsis.mp1.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.itextpdf.text.Paragraph;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.xsis.mp1.model.Inventory;
import com.xsis.mp1.model.Item;
import com.xsis.mp1.model.Outlet;

public class ItemPDFView extends AbstractPdfView{
	
	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document doc,
            PdfWriter writer, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
		// TODO Auto-generated method stub
			List<Inventory> ivt = (List<Inventory>) model.get("inventory");
		   
			
			//p.setAlignment(Element.ALIGN_CENTER);
			


		   PdfPTable table = new PdfPTable(5);
			table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
			table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

			table.addCell("Name");
			table.addCell("Category");
			table.addCell("Unit Price");
			table.addCell("In Stock");
			table.addCell("Stock Alert");

			for (Inventory ivts : ivt) {
				table.addCell(ivts.getVariant().getItem().getName()+"-"+ivts.getVariant().getName());
				table.addCell(ivts.getVariant().getItem().getCategoryId().getName());
				table.addCell(String.valueOf(ivts.getVariant().getPrice()));
				table.addCell(String.valueOf(ivts.getEndingQty()));
				table.addCell(String.valueOf(ivts.getAlertAtQty()));
			}
			doc.add(table);
	}
}
