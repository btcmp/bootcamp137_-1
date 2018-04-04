<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->
<!-- ajax here -->
<script type="text/javascript">
	jQuery(document).ready(function(){
		$('#action-po').change(function(){
			var action = $(this).val();
			var id = $(this).attr('key-id');
			if(action == 'print'){
				window.print();
			}else{
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/po/'+action+'/'+id,
					success : function(){
						console.log('Status Updated');
						window.location = '${pageContext.request.contextPath}/po/detail/'+id;
					},
					error : function(){
						console.log('Update Status Failed');
					}
				});
			}
		});
		
		$('.done').on('click', function(){
			window.location = '${pageContext.request.contextPath}/po';
		});
	});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<div class="row">
	<div class="col-xs-9">
		<h5>PURCHASE ORDER DETAIL</h5>
		<hr style="border-color: black; border-top: 1px dotted;">
	</div>
	<div class="col-xs-3">
		<script>
			if('${pr.status}' == 'Created'){
				document.write('<select id="action-pr" class="btn-primary form-control" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve">Approve</option>'
						+'<option value="reject">Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po" disabled>Create PO</option>');
			}else if('${pr.status}' == 'rejected'){
				document.write('<select id="action-pr" class="btn-primary form-control" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po" disabled>Create PO</option>');
			}else if('${pr.status}' == 'PO Created'){
				document.write('<select id="action-pr" class="btn-primary form-control" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po" disabled>Create PO</option>');
			}else if('${pr.status}' == 'Approved'){
				document.write('<select id="action-pr" class="btn-primary form-control" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po">Create PO</option>');
			}
		</script>
			
		</select>
	</div>
</div>
<hr>
<input type="text" value="PT.Supplier" disabled="disabled" style="border: none; background: none;">
<table border="1px" style="width: 100%">
			<tr>
				<td >telp</td>
				<td colspan="2">email</td>
			</tr>
			<tr>
				<td colspan="3">addres</td>
			</tr>
			<tr>
				<td>province</td>
				<td>kab</td>
				<td>noalamat</td>
			</tr>
		</table>
		
		<div class="form-group">
	<label for="input-note">Notes</label>
	<textarea class="form-control" id="input-note" rows="5" disabled="disabled">${po.notes }</textarea>
</div>

<table>
	<tr>
		<th>PO Number </th>
		<td></td>
		<td> : </td>
		<td>${po.poNo }</td>
	</tr>
	<tr>
		<th>Created By </th>
		<td></td>
		<td> : </td>
		<td>${po.createdBy }</td>
	</tr>

	<tr>
		<th>PO Status </th>
		<td></td>
		<td> : </td>
		<td>$asd{po.status }</td>
	</tr>
</table>
<h5><b>Status History</b></h5>
<hr>
<div class="row">
	<div class="col-xs-5">
		<table id="dt-history" class="table table-hover">
			<c:forEach items="$asfd{po.poHistories }" var="history">
				<tr>
					<td>On</td>
					<td>
						<script>
							var times = '$asd{history.createdOn}';
							var time = times.split('.');
							document.write(time[0]);
						</script>
						<%-- ${history.createdOn} --%>
					</td>
					<td>-</td>
					<td>${po.poNo }</td>
					<td>is</td>
					<td>${asdfhistory.status }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<h5><b>Purchase Items</b></h5>
<hr>
<table id="item-po-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
				<thead class="thead-dark">
					<th>Item</th>
					<th>In Stock</th>
					<th>Qty</th>
					<th>Unit Cost</th>
					<th>Sub Total</th>
				</thead>
				<tbody id="tbody-edit-po">
				<c:forEach var="po" items= "${pos}">
					<tr>
						<%-- <td>${po.prId }</td>
						<td><center>3</center></td>
						<td><center>3</center></td>
						<td><center>Rp. 300.000</center></td>
						<td><center>Rp. 900.000</center></td> --%>
					</tr><br/>
				</c:forEach>
				</tbody>
				<tfoot>
					<tr style=" border: none; background: none;">
						<td colspan="4">TOTAL</td>
						<td><input id="input-total" style="border: none;"/></td>
					</tr>
				</tfoot>
			</table>
<br>
<div class="row">
	<div class="col-xs-11"></div>
	<div class="col-xs-1"><a href="#" class="done btn btn-primary btn-block">Done</a></div>
</div>

<!-- ======================================================================================================================= -->
	
<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->

<!-- Call Modal -->
	
</body>
</html>