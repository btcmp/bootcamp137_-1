<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->
<!-- ajax here -->
<script type="text/javascript">
	jQuery(document).ready(function(){
		$('#action-pr').change(function(){
			var action = $(this).val();
			var id = $(this).attr('key-id');
			if(action == 'print'){
				$('#action-pr').hide();
				$('.done').hide();
				window.print();
			}else{
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/pr/'+action+'/'+id,
					success : function(){
						console.log('Status Updated');
						window.location = '${pageContext.request.contextPath}/t/pr/detail/'+id;
					},
					error : function(){
						console.log('Update Status Failed');
					}
				});
			}
		});
		
		$('.done').on('click', function(){
			window.location = '${pageContext.request.contextPath}/t/pr';
		});
	});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<div class="row">
	<div class="col-xs-9">
		<h5>PURCHASE REQUEST DETAIL</h5>
		<hr style="border-color: black; border-top: 1px dotted;">
	</div>
	<div class="col-xs-3">
		<script>
			if('${pr.status}' == 'Created'){
				document.write('<select id="action-pr" class="btn-primary form-control adm-show" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="submitted">Submitted</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po" disabled>Create PO</option>');
			}else if('${pr.status}' == 'Submitted'){
				document.write('<select id="action-pr" class="btn-primary form-control adm-show" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="submitted" disabled>Submitted</option>'
						+'<option value="approve">Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po" disabled>Create PO</option>');
			}else if('${pr.status}' == 'Approved'){
				document.write('<select id="action-pr" class="btn-primary form-control adm-show" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po">Create PO</option>');
			}else if('${pr.status}' == 'Rejected'){
				document.write('<select id="action-pr" class="btn-primary form-control adm-show" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="submitted" disabled>Submitted</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po" disabled>Create PO</option>');
			}else if('${pr.status}' == 'PO Created'){
				document.write('<select id="action-pr" class="btn-primary form-control adm-show" key-id="${pr.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="submitted" disabled>Submitted</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>'
						+'<option value="create-po" disabled>Create PO</option>');
			}
		</script>
		
		</select>
	</div>
</div>
<hr>
<table>
	<tr>
		<th>PR Number </th>
		<td></td>
		<td> : </td>
		<td>${pr.prNo }</td>
	</tr>
	<tr>
		<th>Created By </th>
		<td></td>
		<td> : </td>
		<td id="td-create">
			<script type="text/javascript">
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/pr/get-created-by?id='+${pr.createdBy },
					dataType: 'json',
					success : function(data){
						console.log(data);
						$('#td-create').append(data[0]);
						//document.write('${data.username}');
					}
				});
			</script>
		</td>
	</tr>
	<tr>
		<th>Target Waktu Item Ready </th>
		<td></td>
		<td> : </td>
		<td>
			<script>
				var dates = '${pr.readyTime}';
				var date = dates.split('-');
				document.write(date[2]+'-'+date[1]+'-'+date[0]);
			</script>
		</td>
	</tr>
	<tr>
		<th>PR Status </th>
		<td></td>
		<td> : </td>
		<td>${pr.status }</td>
	</tr>
</table>
<div class="form-group">
	<label for="input-note">Notes</label>
	<textarea class="form-control" id="input-note" rows="5" disabled="disabled">${pr.notes }</textarea>
</div>
<h5><b>Status History</b></h5>
<hr>
<div class="row">
	<div class="col-xs-5">
		<table id="dt-history" class="table table-hover">
			<c:forEach items="${pr.prHistories }" var="history">
				<tr>
					<td>On</td>
					<td>
						<script>
							var times = '${history.createdOn}';
							var time = times.split('.');
							document.write(time[0]);
						</script>
						<%-- ${history.createdOn} --%>
					</td>
					<td>-</td>
					<td>${pr.prNo }</td>
					<td>is</td>
					<td>${history.status }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<h5><b>Purchase Items</b></h5>
<hr>
<table id="data-purchase-item" class="table table-striped table-bordered table-hover">
	<thead>
		<th>Item</th>
		<th>In Stock</th>
		<th>Request Qty.</th>
	</thead>
	<tbody id="tbody-add-item">
		<c:forEach items="${pr.prDetails }" var ="prd">
			<tr>
				<td>${prd.variant.item.name }-${prd.variant.name }</td>
				<td id="td${prd.id}">
					<script type="text/javascript">
					$.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath}/t/pr/get-inventory?idPr='+${pr.id}+'&idPrd='+${prd.id},
						dataType: 'json',
						success : function(inventory){
							$('#td${prd.id}').append(inventory[0]);
						}
					});
					</script>
				</td>
				<td>${prd.requestQty }</td>
			</tr>
		</c:forEach>
	</tbody>
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