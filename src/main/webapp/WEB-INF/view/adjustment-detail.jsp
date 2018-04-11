<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->
<!-- ajax here -->
<script type="text/javascript">
	jQuery(document).ready(function(){
		$('#action-adj').change(function(){
			var action = $(this).val();
			var id = $(this).attr('key-id');
			if(action == 'print'){
				window.print();
			}
			else{
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/adjustment/'+action+'/'+id,
					success : function(){
						console.log('Status Updated');
						window.location = '${pageContext.request.contextPath}/t/adjustment/detail/'+id;
					},
					error : function(){
						console.log('Update Status Failed');
					}
				});
			}
		});
		
		$('.done').on('click', function(){
			window.location = '${pageContext.request.contextPath}/adjustment';
			//var adjQty=
		});
	});
</script>

<style>
<!--
	.btn-done{
		float: right;
	}
	.done{
		width: 100%
	}
-->
</style>
<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<div class="row">
	<div class="col-xs-9">
		<h5>ADJUSTMENT DETAIL</h5>
		<hr style="border-color: black; border-top: 1px dotted;">
	</div>
	<div class="col-xs-3">
		<script>
			if('${adj.status}' == 'Submitted'){
				document.write('<select id="action-adj" class="btn-primary form-control" key-id="${adj.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve"d>Approve</option>'
						+'<option value="reject">Reject</option>'
						+'<option value="print">Print</option>');
			}else if('${adj.status}' == 'Approved'){
				document.write('<select id="action-adj" class="btn-primary form-control" key-id="${adj.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled selected>Approve</option>'
						+'<option value="reject">Reject</option>'
						+'<option value="print">Print</option>');
			}else if('${adj.status}' == 'Rejected'){
				document.write('<select id="action-adj" class="btn-primary form-control" key-id="${adj.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve"disabled selected>Approve</option>'
						+'<option value="reject" disabled selected>Reject</option>'
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
		<td>${adj.createdBy }</td>
	</tr>
	<tr>
		<th>PR Status </th>
		<td></td>
		<td> : </td>
		<td>${adj.status }</td>
	</tr>
</table>
<div class="form-group">
	<label for="input-note">Notes</label>
	<textarea class="form-control" id="input-note" rows="5" disabled="disabled">${adj.notes }</textarea>
</div>
<h5><b>Status History</b></h5>
<hr>
<div class="row">
	<div class="col-xs-5">
		<table id="dt-history" class="table table-hover" border="0px">
			<c:forEach items="${adj.adjustmentHistory }" var="history">
				<tr>
					<td>On &nbsp;
					
						<script>
							var times = '${history.createdOn}';
							var time = times.split('.');
							document.write(time[0]);
						</script>				
					&nbsp; - &nbsp;
					is &nbsp;
					${history.status }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<h5><b>Adjustment Items</b></h5>
<hr>
<table id="data-purchase-item" class="table table-striped table-bordered table-hover">
	<thead>
		<th>Item</th>
		<th>In Stock</th>
		<th>Adjustment Qty.</th>
	</thead>
	<tbody id="tbody-add-item">
		<c:forEach items="${adj.adjustmentDetails }" var ="adjd">
			<tr>
				<td>${adjd.variant.item.name }-${adjd.variant.name }</td>
				<td>${adjd.inStock}	</td>
				<td>${adjd.actualStock}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<br>
<div class="row">
	<div class="col-md-10"></div>
	<div class="btn-done col-xs-2" "><a href="#" class="done btn btn-primary btn-block">Done</a></div>
</div>

<!-- ======================================================================================================================= -->
	
<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->

<!-- Call Modal -->
	
</body>
</html>