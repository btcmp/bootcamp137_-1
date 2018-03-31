<%@ include file="../view/template/master-header.jsp"%>

<script type="text/javascript">
	jQuery(document).ready(function(){		
		$('#btn-edit-po').on('click', function(){
			$('#modal-edit-po').modal('show');
		});
		
		$('#btn-view-po').on('click', function(){
			$('#modal-detail-po').modal('show');
		});
		
	});
</script>
<!-- =================================================================================================================== -->

<%@ include file="../view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->
		<form id="target" data-parsley-validate>
		<div class="row">
				<div class="col-md-10">
					<h4>Purchase Order Detail</h4>
				</div>
				<div class="col-md-2">
				<select data-parsley-required="true" class="btn-primary" name="countries" id="input-province" style="width: 100%; height:120% ">
					<option value="" selected="selected">Approve</option>
					<option value="" selected="selected">Reject</option>
					<option value="" selected="selected">Process</option>
					<option value="" selected="selected">Print</option>
					<option value="" selected="selected" >More</option>
					<%-- <c:forEach var="loc" items= "${locations}">
					<option value="${loc.id}">${loc.streetAddress}</option>
					</c:forEach> --%>
				</select>
				</div>
			</div>
			<hr style="float: left; width: 83%"/><br/><br/><br/>
				<c:forEach items="${pos}" var="po">
					<p>${po.supplierId.name}</p>	
						<table border="1px" style="width: 100%">
							<tr>
								<td>${po.supplierId.phone}</td>
								<td colspan="2">${po.supplierId.email}</td>
							</tr>
							<tr>
								<td colspan="3">${po.supplierId.district.name}</td>
							</tr>
							<tr>
								<td>${po.supplierId.province.name}</td>
								<td>${po.supplierId.region.name}</td>
								<td>1234</td>
							</tr>
						</table>
					<div>
					<br/>
						<h4>Notes</h4>
						<textarea rows="" cols="" style="width: 100%; height: 110px;" ></textarea>
					</div><br/>
					
					PO Number: ${po.poNo} <br/>
					Created By: Pandji  <br/>
					Email: mail@mail.com <br/>
					Outlet: ${po.outletId.name} <br/>
					Phone: ${po.outletId.phone}<br/>
					Address: ${po.outletId.address}<br/>
					PO Status : Approved <br/><br/>
					
					<b>Status History</b><hr/>
					On ${po.createdOn} - ${po.poNo} is Created <br/>
					On ${po.modifiedOn} - ${po.poNo} is Approved
					<br/><br/>
				</c:forEach>
					<b>Purchase Items</b><hr/>
			<table id="emp-table" class="" cellspacing="0" width="90%">
				<thead style="text-align: center">
					<th>Item</th>
					<th><center>In Stock</th>
					<th><center>Qty</th>
					<th><center>Unit Cost</th>
					<th><center>Sub Total</th>
				</thead>
				<tbody border="1px"class="table-bordered">
					<tr>
						<td>Baju-Merah</td>
						<td><center>3</center></td>
						<td><center>3</center></td>
						<td><center>Rp. 300.000</center></td>
						<td><center>Rp. 900.000</center></td>
					</tr><br/>
					
				</tbody>
				<tr>
						<td colspan="4"><h4>TOTAL</h4></td>
						<td><h5>Rp. 900.000</h5></td>
					</tr>
			</table>
			<hr/>
			<button type="button" id="btn-cancel" class="btn btn-primary" style="width: 10%; float: right;"  data-dismiss="modal">Done</button>
					
</form>
<!-- ======================================================================================================================= -->
	
<%@ include file="../view/template/master-body-bottom.jsp"%>
	
<!-- ======================================================================================================================= -->
	
</body>
</html>