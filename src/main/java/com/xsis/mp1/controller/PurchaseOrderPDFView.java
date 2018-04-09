package com.xsis.mp1.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.xsis.mp1.model.PurchaseOrder;
import com.xsis.mp1.model.PurchaseRequest;

public class PurchaseOrderPDFView extends AbstractPdfView {

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document doc, PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		List<PurchaseOrder> pos = (List<PurchaseOrder>) model.get("pos");
		   
		   PdfPTable table = new PdfPTable(5);
			table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
			table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

			table.addCell("Created Date");
			table.addCell("Supplier");
			table.addCell("PO No");
			table.addCell("Total");
			table.addCell("Status");

			for (PurchaseOrder poss : pos) {
				table.addCell(String.valueOf(poss.getCreatedOn()));
				table.addCell(poss.getSupplierId().getName());
				table.addCell(poss.getPoNo());
				table.addCell(poss.getNotes());
				table.addCell(poss.getStatus());
			}
			doc.add(table);
	}
}
