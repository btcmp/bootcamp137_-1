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
import com.xsis.mp1.model.PurchaseRequest;

public class PurchaseReqPDFView extends AbstractPdfView {

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document doc, PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		List<PurchaseRequest> prs = (List<PurchaseRequest>) model.get("prs");
		   
		   PdfPTable table = new PdfPTable(4);
			table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
			table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

			table.addCell("Created Date");
			table.addCell("PR No");
			table.addCell("Notes");
			table.addCell("Status");

			for (PurchaseRequest prss : prs) {
				table.addCell(String.valueOf(prss.getCreatedOn()));
				table.addCell(prss.getPrNo());
				table.addCell(prss.getNotes());
				table.addCell(prss.getStatus());
			}
			doc.add(table);
	}
}
