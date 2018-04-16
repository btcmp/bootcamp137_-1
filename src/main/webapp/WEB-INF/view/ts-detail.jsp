<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->
<!-- ajax here -->
<script type="text/javascript">
	jQuery(document).ready(function(){
		$('#action-ts').change(function(){
			var action = $(this).val();
			var id = $(this).attr('key-id');
			if(action == 'print'){
				$('#action-ts').hide();
				$('.done').hide();
				window.print();
			}else{
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/ts/'+action+'/'+id,
					success : function(){
						console.log('Status Updated');
						window.location = '${pageContext.request.contextPath}/t/ts/detail/'+id;
					},
					error : function(){
						console.log('Update Status Failed');
					}
				});
			}
		});
		
		$('.done').on('click', function(){
			window.location = '${pageContext.request.contextPath}/ts';
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
			if('${ts.status}' == 'Submitted'){
				document.write('<select id="action-ts" class="btn-primary form-control adm-show" key-id="${ts.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve">Approve</option>'
						+'<option value="reject">Reject</option>'
						+'<option value="print">Print</option>');
			}else if('${ts.status}' == 'rejected'){
				document.write('<select id="action-ts" class="btn-primary form-control adm-show" key-id="${ts.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>');
			}else if('${ts.status}' == 'Approved'){
				document.write('<select id="action-ts" class="btn-primary form-control adm-show" key-id="${ts.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled>Approve</option>'
						+'<option value="reject" disabled>Reject</option>'
						+'<option value="print">Print</option>');
			}
		</script>
			
		</select>
	</div>
</div>
<hr>
<table>
	<tr>
		<th>Created By </th>
		<td></td>
		<td> : </td>
		<td id="td-create">
			<script type="text/javascript">
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/ts/get-created-by?id='+${ts.createdBy },
					dataType: 'json',
					success : function(data){
						console.log(data);
						$('#td-create').append(data[0]);
					}
				});
			</script>
		</td>
	</tr>
	<tr>
		<th>Transfer Status </th>
		<td></td>
		<td> : </td>
		<td>${ts.status }</td>
	</tr>
</table>
<div class="form-group">
	<label for="input-note">Notes</label>
	<textarea class="form-control" id="input-note" rows="5" disabled="disabled">${ts.notes }</textarea>
</div>
<h5><b>Status History</b></h5>
<hr>
<div class="row">
	<div class="col-xs-5">
		<table id="dt-history" class="table table-hover">
			<c:forEach items="${ts.tsHistories }" var="history">
				<tr>
					<td>On</td>
					<td>
						<script>
							var times = '${history.createdOn}';
							var time = times.split('.');
							document.write(time[0]);
						</script>
					</td>
					<td>-</td>
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
		<th>Transfer Qty.</th>
	</thead>
	<tbody id="tbody-add-item">
		<c:forEach items="${ts.tsDetails }" var ="tsd">
			<tr>
				<td>${tsd.variant.item.name }-${tsd.variant.name }</td>
				<td>${tsd.inStock }</td>
				<td>${tsd.transferQty }</td>
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