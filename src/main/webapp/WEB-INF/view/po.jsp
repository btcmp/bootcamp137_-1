<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<script type="text/javascript">
	jQuery(document).ready(function(){	
//////////////////========================search-=================////
		
		$('input[name="daterange"]').daterangepicker(
			      {
			        ranges   : {
			          'Today'       : [moment(), moment()],
			          'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
			          'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
			          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
			          'This Month'  : [moment().startOf('month'), moment().endOf('month')],
			          'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
			        },
			        startDate: moment().subtract(29, 'days'),
			        endDate  : moment()
			      },
			      function (start, end) {
			        $('input[name="daterange"]').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
			        awal = start.format('YYYY-MM-DD');
			        akhir = end.format('YYYY-MM-DD');
			        $.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath}/t/po/src-rg-date?awal='+awal+'&akhir='+akhir,
						success : function(data){
							$('#tbody-po').empty();
							console.log(data);
							$(data).each(function(key, val){
								
								var json_data = '/Date('+val.createdOn+')/';
								var asAMoment = moment(json_data);
								var tanggal = asAMoment.format('DD-MM-YYYY HH:mm:ss');
								
								$('#tbody-po').append('<tr><td>'+tanggal+'</td>'
									+'<td>'+val.supplierId.name+'</td>'	
									+'<td>'+val.poNo+'</td>'
									+'<td>'+val.total+'</td>'
									+'<td>'+val.status+'</td>'
									+'<td><input type="button" class="update btn btn-success btn-sm" value="Edit" id="'+val.id+'" pr-status="'+val.status+'"> | '
									+'<a href="${pageContext.request.contextPath}/t/pr/detail/'+val.id+'" class="view btn btn-success btn-sm" key-id="'+val.id+'">View</a></td>');
							})
						},
						error : function(){
							$('#tbody-po').empty();
							console.log('search failed');
						}
					});
			      }
			    )
				
				$(function() {
					var today = new Date();
					var dd = today.getDate();
					var mm = today.getMonth()+1; //January is 0!
					var yyyy = today.getFullYear();

					if(dd<10) {
					    dd = '0'+dd
					} 
					if(mm<10) {
					    mm = '0'+mm
					} 
					today = yyyy + '-' + mm + '-' + dd;
					
					$('#insert-target').daterangepicker({
				        singleDatePicker: true,
				        minDate: new Date(today),
				        showDropdowns: true
				    });
				});
		
	
		// Search by Status
		$('#src-status').change(function(){
			var status = $('#src-status').val();
			//console.log(status);
			var keyword = '';
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/po/src-status?search='+status,
					success : function(data){
						$('#tbody-po').empty();
						console.log(data);
						$(data).each(function(key, val){
							
							var json_data = '/Date('+val.createdOn+')/';
							var asAMoment = moment(json_data);
							var tanggal = asAMoment.format('DD-MM-YYYY HH:mm:ss');
							
							$('#tbody-po').append('<tr><td>'+tanggal+'</td>'
								+'<td>'+val.supplierId.name+'</td>'	
								+'<td>'+val.poNo+'</td>'
								+'<td>'+val.total+'</td>'
								+'<td>'+val.status+'</td>'
								+'<td><input type="button" class="update btn btn-success btn-sm" value="Edit" id="'+val.id+'" pr-status="'+val.status+'"> | '
								+'<a href="${pageContext.request.contextPath}/t/pr/detail/'+val.id+'" class="view btn btn-success btn-sm" key-id="'+val.id+'">View</a></td>');
						})
					},
					error : function(){
						$('#tbody-po').empty();
						console.log('search failed');
					}
				});
			
		});
		
		// Search Global
		$('#src-global').on('input', function(){
			var global = $('#src-global').val();
			if(global == ''){
				$('#tbody-po').empty();
			}else{
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/po/src-global?search='+global,
					success : function(data){
						$('#tbody-po').empty();
						console.log(data);
						$(data).each(function(key, val){
						
						var json_data = '/Date('+val.createdOn+')/';
						var asAMoment = moment(json_data);
						var tanggal = asAMoment.format('DD-MM-YYYY HH:mm:ss');
						
						$('#tbody-po').append('<tr><td>'+tanggal+'</td>'
							+'<td>'+val.supplierId.name+'</td>'	
							+'<td>'+val.poNo+'</td>'
							+'<td>'+val.total+'</td>'
							+'<td>'+val.status+'</td>'
							+'<td><input type="button" class="update btn btn-success btn-sm" value="Edit" id="'+val.id+'" pr-status="'+val.status+'"> | '
							+'<a href="${pageContext.request.contextPath}/t/pr/detail/'+val.id+'" class="view btn btn-success btn-sm" key-id="'+val.id+'">View</a></td>');
					})
						
					},
					error : function(){
						$('#dtbody-po').empty();
						console.log('search failed');
					}
				});
			}
		});
		
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
				url:'${pageContext.request.contextPath}/t/po/get-onepo/'+po,
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
				url:'${pageContext.request.contextPath}/t/po/get-one/'+id,
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
							'</td><td>Rp. '+val.variant.price+ 
							'</td><td>Rp. '+subTotal+'</td></tr>');
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
			
			
			
			$('#modal-edit-po').modal('hide');
			var supplier=$("#input-supplier").val();

			var total=$("#input-total").val();
			var poDet=[];
			$('#tbody-edit-po > .item').each(function(index, data) {
				var unitCost=parseInt($(this).find('td').eq(3).text());
				var subTotal=parseInt($(this).find('td').eq(4).text());
				console.log(unitCost);
				//var unit=unitCost.split(".");
				//console.log(unit[0]);
				var detail = {
						requestQty : parseInt($(this).find('td').eq(2).text()),
						variant : {
							id : parseInt($(this).attr('id-var'))
						},
						subTotal : subTotal,
						unitCost :  unitCost
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
				url:'${pageContext.request.contextPath}/t/po/update',
				type:'PUT',
				contentType:'application/json',
				data : JSON.stringify(po),
				success : function(){
					console.log("save")
					//window.location = '${pageContext.request.contextPath}/t/po';
				},error:function(){
					alert("error");
				}
			});  
		});
		
	
		
		/* view detail-po */
		$('.btn-view-po').on('click', function(){
			
				var id = $(this).attr('id');
				console.log(id);
				window.location = '${pageContext.request.contextPath}/t/po/detail/'+ id;
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
		              <input type="text" class="form-control pull-right" name="daterange" id="src-date">
		            </div>
				</div>
			  </div>
			  <div class="col-md-2">
			  	<div class="form-group">
				    <select name="title" id="src-status" class="form-control custom-select custom-select-md" id="src-status" >
				    	<option selected value="all">Status</option>
				    		<option value="Approved">Approved</option>
				    		<option value="Rejected">Rejected</option>
				    		<option value="Process">Process</option>
				    </select>
				</div>
			  </div>
			  <div class="col-md-2">
			  	<div class="form-group">
					<input type="text" class="form-control" id="src-global" placeholder="Search">
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