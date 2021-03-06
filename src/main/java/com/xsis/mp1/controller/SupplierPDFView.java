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
import com.xsis.mp1.model.Supplier;


public class SupplierPDFView extends AbstractPdfView{

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document doc, PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		List<Supplier> suppliers = (List<Supplier>) model.get("suppliers");
		   
		   PdfPTable table = new PdfPTable(4);
			table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
			table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

			table.addCell("Name");
			table.addCell("Address");
			table.addCell("Phone");
			table.addCell("Email");

			for (Supplier supp : suppliers) {
				table.addCell(supp.getName());
				table.addCell(supp.getAddress()); 
				table.addCell(supp.getPhone()); 
				table.addCell(supp.getEmail()); 
			}
			doc.add(table);
	}

}
