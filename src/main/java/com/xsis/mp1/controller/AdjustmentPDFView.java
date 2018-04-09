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
import com.xsis.mp1.model.Adjustment;
import com.xsis.mp1.model.PurchaseRequest;

public class AdjustmentPDFView extends AbstractPdfView {

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document doc, PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		List<Adjustment> adjs = (List<Adjustment>) model.get("adjs");
		   
		   PdfPTable table = new PdfPTable(3);
			table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
			table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

			table.addCell("Adjustment Date");
			table.addCell("Notes");
			table.addCell("Status");

			for (Adjustment adj : adjs) {
				table.addCell(String.valueOf(adj.getCreatedOn()));
				table.addCell(adj.getNotes());
				table.addCell(adj.getStatus());
			}
			doc.add(table);
	}
}
