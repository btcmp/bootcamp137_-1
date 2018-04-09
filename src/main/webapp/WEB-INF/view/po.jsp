<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<script type="text/javascript">
	jQuery(document).ready(function(){		
		/* =================export pdf============= */
		$('#btn-export').on('click', function(){
			window.location = '${pageContext.request.contextPath}/generate/po';
		});
	 
		
		
		$('.btn-edit-po').on('click', function(evt){
			evt.preventDefault();
			var id = $(this).attr('id');
			var po = $(this).attr('name');
			var poNo = $(this).attr('poNo');
			$.ajax({
				url:'${pageContext.request.contextPath}/mst/po/get-onepo/'+po,
				type:'GET',
				contentType:'application/json',
				success : function(data){
					//console.log(data);
					//console.log(data.supplierId.id);
					$("#input-notes").val(data.notes);
					
					$("#input-supplier").val(data.supplierId.id);
				}
			});
			//console.log(poNo);
			/* ajax get pr  */
			  $.ajax({
				url:'${pageContext.request.contextPath}/mst/po/get-one/'+id,
				type:'GET',
				contentType:'application/json',
				success : function(data){
					$('#modal-edit-po').modal('show');
					var beginnings=[];
					var out=data.outletId.name;
					var outId=data.outletId.id
					var total=[];
					//console.log(outId);
					$('#input-pr-id').val(id);
					$('#input-outlet').val(out);
					$('#input-outlet-id').val(outId)
					$('#input-po-id').val(po);
					$('#input-po-no').val(poNo);
					
					/* looping pr-detail  */
					$(data.prDetails).each(function(key, val){
						//console.log(val.id);
						var varId=val.variant.id;
						var itemName=val.variant.item.name;
						var itemId=val.variant.item.id;
						var outIdItem=val.variant.item.outlet.id;
						var qty=val.requestQty;
						var price=val.variant.price;
						var subTotal=qty*price;
						total.push(subTotal);
						var idInv=0;
						$.ajax({
							type : 'GET',
							url : '${pageContext.request.contextPath}/pr/get-inventory?idPr='+data.id+'&idPrd='+val.id,
							dataType: 'json',
							success : function(inventory){
								console.log(inventory[0]);
								$('#quantity'+val.id).append(inventory[0]);
							}
						});
						
						
   						 //if(outId==outIdItem){
						 $('#tbody-edit-po').append(
							'<tr id-var="'+val.variant.id+'" class="item"><td>'+val.variant.item.name+'-'+val.variant.name+
							'</td><td id="quantity'+val.id+'"></td><td>'+val.requestQty+
							'</td><td>'+val.variant.price+ 
							'</td><td>'+subTotal+'</td></tr>');
						//}
						 
					});
					var gTotal=total.reduce(function(a,b){return a+b},0);
					$("#input-total").val(gTotal);
				}
			}); 
		});
		
		/* btn save */
		$('#btn-save').on('click',function(evt){
			evt.preventDefault;
			var id=$("#input-po-id").val();
			var poNo=$("#input-po-no").val();
			var outid=$("#input-outlet-id").val();
			var prid=$('#input-pr-id').val();
			//console.log(outid);
			$('#modal-edit-po').modal('hide');
			var supplier=$("#input-supplier").val();

			var total=$("#input-total").val();
			var poDet=[];
			$('#tbody-edit-po > .item').each(function(index, data) {
				var detail = {
						requestQty : parseInt($(this).find('td').eq(2).text()),
						variant : {
							id : parseInt($(this).attr('id-var'))
						},
						subTotal : parseInt($(this).find('td').eq(4).text()),
						unitCost :  parseInt($(this).find('td').eq(3).text())
				};
				poDet.push(detail);
				
			});
			var po = {
					id : parseInt(id),
					notes : $('#input-notes').val(),
					status : "created",
					outletId : {
						id : parseInt(outid),
					},
					purchaseOrderDetails : poDet,
					poNo:poNo,
					grandTotal:parseInt(total),
					prId:{
						id:parseInt(prid)
					},
					supplierId:{
						id:parseInt(supplier)
					}
				};
				console.log(po);
			
			  $.ajax({
				url:'${pageContext.request.contextPath}/mst/po/update',
				type:'PUT',
				contentType:'application/json',
				data : JSON.stringify(po),
				success : function(){
					console.log("save")
					window.location = '${pageContext.request.contextPath}/mst/po';
				},error:function(){
					alert("error");
				}
			});  
		});
		
		/* date picker*/
		$(function() {
		    $('input[name="daterange"]').daterangepicker();
		});
		
		/* view detail-po */
		$('.btn-view-po').on('click', function(){
			
				var id = $(this).attr('id');
				console.log(id);
				window.location = '${pageContext.request.contextPath}/mst/po/detail/'+ id;
				console.log(data);
		});
		
		
		
	});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

	<div>
		<b> Purchase Order</b>
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<div class="row">
			  <div class="col-md-3">
			  	<div class="form-group">
					<!-- <input type="text" class="form-control" id="insert-date" name="daterange" value="01/01/2018 - 01/31/2018"> -->
					<div class="input-group">
		              <div class="input-group-addon">
		                <i class="fa fa-calendar"></i>
		              </div>
		              <input type="text" class="form-control pull-right" name="daterange" id="reservation">
		            </div>
				</div>
			  </div>
			  <div class="col-md-2">
			  	<div class="form-group">
				    <select name="title" id="insert-title" class="form-control custom-select custom-select-md">
				    	<option selected>Status</option>
				    		<option value="">Submitted</option>
				    		<option value="">Approved</option>
				    		<option value="">Rejected</option>
				    </select>
				</div>
			  </div>
			  <div class="col-md-2">
			  	<div class="form-group">
					<input type="text" class="form-control" id="insert-search" placeholder="Search">
				</div>
			  </div>
			  <div class="col-md-3">
			  </div>
			  <div class="col-md-2">
			  	<div class="form-group">
					<button type="button" id="btn-export" class="btn btn-primary btn-block" style="float: right;">Export</button>
				</div>
			  </div>
			</div>
		</form>
	</div>
	
	<table id="po-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead style="text-align: center">
			<th style="display: none">Id</th>
			<th>Create Date</th>
			<th>Supplier</th>
			<th>PO No.</th>
			<th>Total</th>
			<th>Status</th>
			<th><center>#</center></th>
		</thead>
		<tbody id="tbody-po">
		<c:forEach items="${pos}" var="po">
			<tr id="${po.prId }">
				<td style="display: none">${po.id }</td>
				<td><center>${po.createdOn }</center></td>
				<td>${po.supplierId.name }</td>
				<td>${po.poNo }</td>
				<td>${po.grandTotal}</td>
				<td>${po.status}</td>
				<td><center>
					<a id="${po.prId.id }" class="btn-edit-po btn btn-info btn-sm" name="${po.id}" poNo="${po.poNo }" href="#">Edit</a>
					<a id="${po.id}" class="btn-view-po btn btn-info btn-sm" href="#">View</a></center>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

<!-- ======================================================================================================================= -->
	
	<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>
	
	<!-- ======================================================================================================================= -->
	
<!-- call modal -->
	<%@ include file="modal/purchase-order/form-edit-po.jsp" %>
	
	
</body>
</html>