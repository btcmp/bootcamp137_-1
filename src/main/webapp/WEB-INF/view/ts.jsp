<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->

<script type="text/javascript">
	jQuery(document).ready(function(){
		$('#dt-table').DataTable( {
	        "searching":   false,
	        "info":     false
	    });

		$('#btn-create').on('click', function(){
			$('#modal-pr-input').modal();
		});
		
		$('#btn-add-item').on('click', function(){
			$('#modal-pr-add-item').modal();
		});

		$('#btn-add-item-var').on('click', function(){
			$('#modal-pr-add-item').modal('hide');
			$('#modal-pr-input').modal('show');
			$('#btn-save').prop('disabled', false);
			$('#btn-submit').show();
		});
		
		$('#btn-cancel-add').on('click', function(){
			$('#modal-pr-input').modal();
			clearFormSrc();
		});
		
		$('#btn-cancel-input').on('click', function(){
			$('#btn-submit').hide();
			clearForm();
		});
		
		$('#btn-save').prop('disabled', true);
		
		//save
		$('#btn-save').on('click', function(){
			
			if('${outlet.id}' == $('#input-to-outlet').val()){
				alert('Outlet tujuan tidak boleh sama');
			}else{
				var tsDet = [];
				
				$('#tbl-ts-add-item > tbody > tr').each(function(index, data) {
					var detail = {
							"inStock" : $(this).find('td').eq(1).text(),
							"transferQty" : $(this).find('td').eq(2).text(),
							"variant" : {
								"id" : $(this).attr('id-var')
							}
					};
					tsDet.push(detail);
					console.log('tes');
				});
				
				var ts = {
					id : $('#input-id').val(),
					fromOutlet : {
						id : '${outlet.id}'
					},
					toOutlet : {
						id : $('#input-to-outlet').val()
					},
					notes : $('#input-note').val(),
					status : "Submitted",
					tsDetails : tsDet
				};
				console.log(ts);

				if(tsDet[0] != null){
					$.ajax({
						type : 'POST',
						url : '${pageContext.request.contextPath}/t/ts/save',
						data : JSON.stringify(ts),
						contentType : 'application/json',
						success : function() {
							window.location = '${pageContext.request.contextPath}/t/ts';
						},
						error : function() {
							alert('save failed');
						}

					});
				}else{
					alert('Please add item first!');
				}
			}
		});
		
		var added = [];
		var addedQty = [];
		
		// search variant
		$('#src-item-variant').on('input',function(e){
			var word = $(this).val();
			if (word=="") {
				$('#tbl-add-item-transfer').empty();
			} else {
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/ts/search-item?search='+word,
					dataType: 'json',
					success : function(data){
						console.log(data);
						$('#tbl-add-item-transfer').empty();
						$.each(data, function(key, val) {
							var oTableItem = "<tr>"+
								'<td>'+ val.variant.item.name +'-'+ val.variant.name +'</td>' +
								'<td id="inStock'+ val.id +'">'+ val.endingQty +'</td>' +
								'<td id="td-qty'+ val.id +'"><input type="number" id="add-qty'+ val.id +'" value="1" min="1" /></td>' +
								'<td><button type="button" id="'+ val.id +'" class="btn-add-item'+val.id +' btn-add-item btn btn-primary" id-var="'+val.variant.id+'">Add</button></td>' +
								"</tr>";
							
							$('#tbl-add-item-transfer').append(oTableItem);
						});
					}, 
					error : function(){
						$('tbl-add-item-transfer').empty();
					}
				});
			}
		});
		
		//tambah tabel item ke modal create TS
		$('#tbl-add-item-transfer').on('click', '.btn-add-item', function(){
			var element = $(this).parent().parent();
			var id = $(this).attr('id');
			var idVar = $(this).attr('id-var');
			var itemVar = element.find('td').eq(0).text();
			var inStock = element.find('td').eq(1).text();
			var trfQty = $('#add-qty'+id).val();
			
			if(added.indexOf(id.toString()) == -1) {
				var oTableAddItem = '<tr id-var="'+idVar+'" id="'+id+'"><td>'+itemVar+'</td>' +
					'<td>'+inStock+'</td>' +
					'<td>'+trfQty+'</td>' +
					'<td><button type="button" class="btn-cancel-item btn btn-danger" id="btn-del'+id+'" id-var="'+id+'">&times;</button>'
					'</tr>';
				$('#tbody-add-item').append(oTableAddItem);
				added.push(id);
			}else{
				var trItem = $('#tbody-add-item > #'+id+'');
				var oldReqQty = trItem.find('td').eq(2).text();
				var newReqQty = parseInt(oldReqQty)+parseInt(trfQty);
				trItem.find('td').eq(2).text(newReqQty);
			}
			$('#div-alert-modal').fadeIn();
			setTimeout(function(){
				$('#div-alert-modal').fadeOut();
			}, 1000);
		});
		
		
		//cancel item
		$('#tbl-ts-add-item').on('click', '.btn-cancel-item', function(){
			var id = $(this).attr('id-var');
			console.log(id);
			$(this).parent().parent().remove();
			var index = added.indexOf(id.toString());
			if(index > -1){
				added.splice(index, 1);
			}
		});
		
		//view detail
		$('.view').on('click', function(){
			var id = $(this).attr('id');
			console.log(id);
			window.location = '${pageContext.request.contextPath}/t/ts/detail/' + id;
		});
		
		//export pdf
		$('#btn-export').on('click', function(){
			window.location = '${pageContext.request.contextPath}/generate/ts';
		});
		
		// Search by To Outlet
		$('#src-outlet').change(function(){
			var cari = $('#src-outlet').val();
			console.log(cari);
			if(status == 'All'){
				window.location = '${pageContext.request.contextPath}/t/ts';
			}else{
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/ts/src-outlet?search='+cari,
					success : function(data){
						$('#dt-table-ts').empty();
						console.log(data);
						$(data).each(function(key, val){
							
							var json_data = '/Date('+val.createdOn+')/';
							var asAMoment = moment(json_data);
							var tanggal = asAMoment.format('DD-MM-YYYY HH:mm:ss');
							
							$('#dt-table-ts').append('<tr><td>'+tanggal+'</td>'
								+'<td>'+val.fromOutlet.name+'</td>'
								+'<td>'+val.toOutlet.name+'</td>'
								+'<td>'+val.status+'</td>'
								+'<td><input type="button" class="update btn btn-success btn-sm" value="Edit" id="'+val.id+'" ts-status="'+val.status+'"> | '
								+'<a href="${pageContext.request.contextPath}/t/ts/detail/'+val.id+'" class="view btn btn-success btn-sm" key-id="'+val.id+'">View</a></td>');
						})
						
					},
					error : function(){
						$('#dt-table-ts').empty();
						console.log('search failed');
					}
				});
			}
		});
		
		function clearForm() {
			$('#input-note').val('');
			$('#tbody-add-item').empty();
		}
		
		function clearFormSrc() {
			$('#src-item-variant').val('');
			$('#tbl-add-item-transfer').empty();
		}
	});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<h6><b>TRANSFER STOCK</b></h6>
<hr>
	<div class="row">
	  <div class="col-md-2">
	  	<div class="form-group">
		   <select name="outlet" id="src-outlet" class="form-control">
		   		<option selected disabled>To Outlet</option>
				<c:forEach var="out" items="${outlets }">
					<option value="${out.id }">${out.name }</option>
				</c:forEach>
			</select>
		</div>
	  </div>
	  <div class="col-md-3">
	  </div>
	  <div class="col-md-2">
	  	
	  </div>
	  <div class="col-md-1">
	  </div>
	  <div class="col-md-2">
	  	<div class="form-group">
			<button type="button" id="btn-export" class="btn btn-primary btn-block">Export</button>
		</div>
	  </div>
	  <div class="col-md-2">
	  	<div class="form-group">
		    <button type="button" id="btn-create" class="btn btn-primary btn-block">Create</button>
		</div>
	  </div>
	</div>
	<hr>
	<table id="dt-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead class="thead-dark">
			<th><center>Transfer Date</center></th>
			<th><center>From Outlet</center></th>
			<th><center>To Outlet</center></th>
			<th><center>Status</center></th>
			<th><center>#</center></th>
		</thead>
		<tbody id="dt-table-ts">
			<c:forEach items="${tss }" var="ts">
				<tr>
					<td>
						<script>
							var times = '${ts.createdOn }';
							var time = times.split(':');
							document.write(time[0]+':'+time[1]);
						</script>
					</td>
					<td>${ts.fromOutlet.name }</td>
					<td>${ts.toOutlet.name }</td>
					<td>${ts.status }</td>
					<td>
						<a id="${ts.id }" class="view btn btn-success btn-sm" href="#">View</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

<!-- Call modal -->

<!------------------------------------------------------ Modal Transfer Input --------------------------------------------------->

<div class="modal fade" id="modal-pr-input" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel"><b>Transfer Stock</b></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<div class="row" id="div-alert" style="display:none;">
						<div class="col-xs-12">
							<div class="alert alert-success alert-dismissible" role="alert" id="show-alert1" style="padding: 5px">
			                <p><i class="icon fa fa-check"></i> Data saved!</p>
			              </div>
						</div>
					</div>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<label for="input-from">CREATE NEW TRANSFER STOCK FROM : </label> ${outlet.name}
					</div>
					<div class="form-group">
						
					</div>
					<div class="form-group">
						<label for="input-to">To : </label>
						<select name="role" id="input-to-outlet" class="form-control">
							<c:forEach var="out" items="${outlets }">
								<option value="${out.id }">${out.name }</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="form-group">
						<label for="input-note">Notes</label>
						<textarea class="form-control" id="input-note" rows="5"></textarea>
					</div>
					<div class="form-group">
						<label for="input-name">Purchase Request</label>
						<hr>
						
						<table id="tbl-ts-add-item" class="table table-striped table-bordered" cellspacing="0" width="100%">
							<thead>
								<th>Item</th>
								<th>In Stock</th>
								<th>Req Qty</th>
								<th></th>
							</thead>
							<tbody id="tbody-add-item">
							</tbody>
						</table>
						
						<button type="button" id="btn-add-item" class="btn btn-primary btn-block">Add Item</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="row">
					<div class="col-md-3">
					
					</div>
					<div class="col-md-3" >
					</div>
					<div class="col-md-3">
						<button type="button" id="btn-cancel-input" class="btn btn-primary btn-block" data-dismiss="modal">Cancel</button>
					</div>
					<div class="col-md-3">
						<button type="button" id="btn-save" class="btn btn-primary btn-block">Save & Submit</button>
					</div>
				</div>				
			</div>
		</div>
	</div>
</div>

<!----------------------------------------------------- Modal Add Item ------------------------------------------------------------>

<div class="modal fade" id="modal-pr-add-item" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel"><b>Add Purchase Item</b></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<div class="row" id="div-alert-modal" style="display:none;">
						<div class="col-xs-12">
							<div class="alert alert-info alert-dismissible" role="alert" id="show-alert2" style="padding: 5px">
			                <p><i class="icon fa fa-check"></i> Item added!</p>
			              </div>
						</div>
					</div>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<input type="text" id="src-item-variant" class="form-control" placeholder="Search Item Name - Variant Name" />
					</div>
				</form>
			</div>
			<div class=modal-body>
				<table class="table table-striped table-bordered" cellspacing="0" width="100%">
					<thead>
						<th>Item</th>
						<th>Stock</th>
						<th>Trans. Qty</th>
						<th>Action</th>
					</thead>
					<tbody id="tbl-add-item-transfer">
					</tbody>
				</table>
				<div class="row">
					<div class="col-md-5">
						<button type="button" id="btn-cancel-add" class="btn btn-primary btn-block" data-dismiss="modal">Cancel</button>
					</div>
					<div class="col-md-2">
					
					</div>
					<div class="col-md-5">
						<button type="button" id="btn-add-item-var" class="btn btn-primary btn-block">Next</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- ======================================================================================================================= -->

<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->

<!-- Call Modal -->
	
</body>
</html>