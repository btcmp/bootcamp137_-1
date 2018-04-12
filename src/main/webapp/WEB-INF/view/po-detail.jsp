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
					url : '${pageContext.request.contextPath}/t/po/'+action+'/'+id,
					success : function(){
						console.log('Status Updated');
						console.log(action);
						window.location = '${pageContext.request.contextPath}/t/po/detail/'+id;
					},
					error : function(){
						console.log('Update Status Failed');
					}
				});
			}
		});
		
		$('.done').on('click', function(){
			window.location = '${pageContext.request.contextPath}/t/po';
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
			if('${po.status}' == 'created'){
				document.write('<select id="action-po" class="btn-primary form-control" key-id="${po.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve">Approve</option>'
						+'<option value="reject">Reject</option>'
						+'<option value="process" disabled selected>Process</option>'
						+'<option value="print" disabled selected>Print</option>');
			}else if('${po.status}' == 'Rejected'){
				document.write('<select id="action-po" class="btn-primary form-control" key-id="${po.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled selected>Approve</option>'
						+'<option value="reject" disabled selected>Reject</option>'
						+'<option value="process" disabled selected>Process</option>'
						+'<option value="print">Print</option>');
			}else if('${po.status}' == 'Approved'){
				document.write('<select id="action-po" class="btn-primary form-control" key-id="${po.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled selected>Approve</option>'
						+'<option value="reject" >Reject</option>'
						+'<option value="process">Process</option>'
						+'<option value="print">Print</option>');
			}else if('${po.status}' == 'Process'){
				document.write('<select id="action-po" class="btn-primary form-control" key-id="${po.id }">'
						+'<option disabled selected>More</option>'
						+'<option value="approve" disabled selected>Approve</option>'
						+'<option value="reject" disabled selected>Reject</option>'
						+'<option value="process" disabled selected>Process</option>'
						+'<option value="print" >Print</option>');
			}
		</script>
			
		</select>
	</div>
</div>
<hr>
<input type="text" value="${po.supplierId.name }" disabled="disabled" style="border: none; background: none;">
<table border="1px" style="width: 100%">
			<tr>
				<td >${po.supplierId.phone }</td>
				<td colspan="2">${po.supplierId.email}</td>
			</tr>
			<tr>
				<td colspan="3">${po.supplierId.address}</td>
			</tr>
			<tr>
				<td>${po.supplierId.province.name}</td>
				<td>${po.supplierId.region.name}</td>
				<td>${po.supplierId.postalCode}</td>
			</tr>
		</table>
		
		<div class="form-group">
	<label for="input-note">Notes</label>
	<textarea class="form-control" id="input-note" rows="5" disabled="disabled">${po.notes }</textarea>
</div>



<table id="item-poe" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
				<thead class="thead-dark">
					<th>Item</th>
					<th>In Stock</th>
				</thead>
				<tbody id="tbody-detail-po">
					<c:forEach items="${pos}" var ="po">
						<tr>
							<td>iasdf</td>
							<td id="td${pod.id}">
								 <script type="text/javascript">
									var i=0;
									$.ajax({
										type : 'GET',
										url : '${pageContext.request.contextPath}/mst/po/get-inventory?idPo='+${po.id}+'&idPod='+${po.supplierId.id},
										dataType: 'json',
										success : function(data){
											//$('#td${pod.id}').append(inventory[0]);
											console.log("test");
										}
									});
								</script>
							</td>
							
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
				
				</tfoot>
			</table>


<h5><b>Status History</b></h5>
<hr>
<div class="row">
	<div class="col-xs-5">
		<table id="dt-history" class="table table-hover">
			<c:forEach items="${po.purchaseOrderHistories }" var="history">
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
					<td>${po.poNo }</td>
					<td>is</td>
					<td>${history.status }</td>
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
				<tbody id="tbody-detail-po">
					<c:forEach items="${po.purchaseOrderDetails }" var ="pod">
						<tr>
							<td>${pod.variant.item.name }-${pod.variant.name }</td>
							<td id="td${pod.id}">
								 <script type="text/javascript">
									var i=0;
									$.ajax({
										type : 'GET',
										url : '${pageContext.request.contextPath}/mst/po/get-inventory?idPo='+${po.id}+'&idPod='+${pod.id},
										dataType: 'json',
										success : function(inventory){
											$('#td${pod.id}').append(inventory[0]);
											//console.log("test");
										}
									});
								</script>
							</td>
							<td>${pod.requestQty }</td>
							<td>${pod.unitCost }</td>
							<td>${pod.subTotal }</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr style=" border: none; background: none;">
						<td colspan="4">TOTAL</td>
						<td id="total">
							<script type="text/javascript">
								var total=[];
								var j= $("#tbody-detail-po > tr").length;
								for (var i = 0; i < j; i++) {
									var l=parseInt($("#tbody-detail-po > tr").parent().find('td').eq(4).text());
									total.push(l);
								}
								var gTotal=total.reduce(function(a,b){return a+b},0);
								//console.log(gTotal);
								$('#total').append(gTotal);
							</script>
						</td>
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