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
					<h5>Purchase Order Detail</h5>
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
					<p>${po.supplierId.name }</p>
				</c:forEach>
						<p>PT.MAJU JAYA SEKALI</p>			
						<table border="1px" style="width: 100%">
							<tr>
								<td>021-12345678</td>
								<td colspan="2">mjs@mail.com</td>
							</tr>
							<tr>
								<td colspan="3">Jl.Bangun Nusa Indah</td>
							</tr>
							<tr>
								<td>Jawa Barat</td>
								<td>Bandung</td>
								<td>1234</td>
							</tr>
						</table>
					<div>
						<h5>Notes</h5>
						<textarea rows="" cols="" style="width: 100%; height: 110px;" ></textarea>
					</div><br/>
					
					PO Number: PO0000001z <br/>
					Created By: Pandji  <br/>
					Email: mail@mail.com <br/>
					Outlet: Outlet Satu <br/>
					Phone: 021-12345678<br/>
					Address: Jl. Jalan <br/>
					PO Status : Approved <br/><br/>
					
					<b>Status History</b><hr/>
					On 01/01/2016 09:00 - PO001206 is Created <br/>
					On 02/01/2016 09:00 - PO001206 is Approved
					<br/><br/>
					<b>Purchase Items</b><hr/>
			<table id="emp-table" class="" cellspacing="0" width="90%">
				<thead>
					<th>Item</th>
					<th>In Stock</th>
					<th>Qty</th>
					<th>Unit Cost</th>
					<th>Sub Total</th>
				</thead>
				<tbody class="table-bordered">
					<tr>
						<td>Baju-Merah</td>
						<td><center>3</center></td>
						<td><center>3</center></td>
						<td><center>Rp. 300.000</center></td>
						<td><center>Rp. 900.000</center></td>
					</tr><br/>
					
				</tbody>
				<tr>
						<td colspan="4"><h5>TOTAL</h5></td>
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