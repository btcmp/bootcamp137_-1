<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->
<style>
	.modal-content {
	  overflow: scroll;
	}
</style>

<script type="text/javascript">
	jQuery(document).ready(function(){
		$('#dt-table').DataTable( {
	        "searching":   false,
	        "info":     false
	    });
		
		$('#btn-save').prop('disabled', true);
		
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
	        console.log(awal);
		    console.log(akhir);
	        $.ajax({
				type : 'GET',
				url : '${pageContext.request.contextPath}/t/pr/src-rg-date?awal='+awal+'&akhir='+akhir,
				success : function(data){
					$('#dt-table-pr').empty();
					console.log(data);
					$(data).each(function(key, val){
						
						var json_data = '/Date('+val.createdOn+')/';
						var asAMoment = moment(json_data);
						var tanggal = asAMoment.format('DD-MM-YYYY HH:mm:ss');
						
						$('#dt-table-pr').append('<tr><td>'+tanggal+'</td>'
							+'<td>'+val.prNo+'</td>'
							+'<td>'+val.notes+'</td>'
							+'<td>'+val.status+'</td>'
							+'<td><input type="button" class="update btn btn-success btn-sm" value="Edit" id="'+val.id+'" pr-status="'+val.status+'"> | '
							+'<a href="${pageContext.request.contextPath}/t/pr/detail/'+val.id+'" class="view btn btn-success btn-sm" key-id="'+val.id+'">View</a></td>');
					})
				},
				error : function(){
					$('#dt-table-pr').empty();
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
		
		$('#btn-create').on('click', function(){
			$('#modal-pr-input').modal();
		});
		
		$('#btn-add-item').on('click', function(){
			$('#modal-pr-add-item').modal();
		});

		var itemnya = [];
		
		$('#btn-add-item-var').on('click', function(){
			/* if($('#tbody-add-item').empty()){
				alert('Choose item first');
			}else{ */
				$('#modal-pr-add-item').modal('hide');
				$('#modal-pr-input').modal('show');
				$('#btn-save').prop('disabled', false);
				$('#btn-submit').show();
				
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/item/get-inventory',
					dataType : 'json',
					success : function(data){
						$.each(data, function(key, val) {
							var namaItem = val.variant.item.name +'-'+ val.variant.name;
							itemnya.push(namaItem);
						});
						console.log(itemnya);
					}, error : function(){
						
					}
				});
			/* } */
		});
		
		$('#btn-cancel-add').on('click', function(){
			$('#modal-pr-input').modal();
			clearFormSrc();
			//$('#btn-submit').hide();
		});
		
		$('#btn-cancel-input').on('click', function(){
			$('#btn-submit').hide();
			clearForm();
		});
			
		var stat = '';
	    
	    $('#btn-save').on('click',function(evt) {
			evt.preventDefault();
			stat = 'Created';
			save();
		}); 
	    
	    $('#btn-submit').on('click', function(evt){
	    	evt.preventDefault();
	    	stat = 'Submitted';
	    	save();
	    });
	    
	    function save(){
			var prDet = [];
			
			$('#tbl-pr-add-item > tbody > tr').each(function(index, data) {
				var detail = {
						"requestQty" : $(this).find('td').eq(2).text(),
						"variant" : {
							"id" : $(this).attr('id-var')
						}
				};
				prDet.push(detail);
			});
			
			var matriks = $('#insert-target').val().split('/');
			var ready = matriks[2]+'-'+matriks[0]+'-'+matriks[1];
			
			var pr = {
				id : $('#input-id').val(),
				readyTime : ready,
				prNo : $('#input-prNo').val(),
				notes : $('#input-note').val(),
				status : stat,
				outletId : {
					id : '${outlet.id}'
				},
				prDetails : prDet
			};
			console.log(pr);

			if(prDet[0] != null){
				$.ajax({
					type : 'POST',
					url : '${pageContext.request.contextPath}/t/pr/save',
					data : JSON.stringify(pr),
					contentType : 'application/json',
					success : function() {
						$('#div-alert').fadeIn();
						setTimeout(function() {
							window.location = '${pageContext.request.contextPath}/t/pr';
						}, 2000);
					},
					error : function() {
						$('#show-alert1').removeClass('alert-info').addClass('alert-gagal');
						$('#show-alert1').html('<strong>Error!</strong> Save Failed!');
						$('#div-alert').fadeIn();
						setTimeout(function(){
							$('#div-alert').fadeOut();
						}, 4000);
					}

				});
			}else{
				alert('Please add item first!');
			}
	    }
		
		//view detail
		$('.view').on('click', function(){
			var id = $(this).attr('id');
			console.log(id);
			window.location = '${pageContext.request.contextPath}/t/pr/detail?id=' + id;
		});
		
		//export pdf
		$('#btn-export').on('click', function(){
			window.location = '${pageContext.request.contextPath}/generate/pr';
		});
		
		var added = [];
		var addedQty = [];
		
		// search variant
		$('#src-item-variant').on('input',function(e){
			var word = $(this).val();
			if (word=="") {
				$('#tbl-add-item-purchase').empty();
			} else {
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/pr/search-item?search='+word,
					dataType: 'json',
					success : function(data){
						console.log(data);
						$('#tbl-add-item-purchase').empty();
						$.each(data, function(key, val) {
							var oTableItem = "<tr>"+
								'<td>'+ val.variant.item.name +'-'+ val.variant.name +'</td>' +
								'<td id="inStock'+ val.id +'">'+ val.endingQty +'</td>' +
								'<td id="td-qty'+ val.id +'"><input type="number" id="add-qty'+ val.id +'" value="1" min="1" /></td>' +
								'<td><button type="button" id="'+ val.id +'" class="btn-add-item'+val.id +' btn-add-item btn btn-primary" id-var="'+val.variant.id+'">Add</button></td>' +
								"</tr>";
							
							$('#tbl-add-item-purchase').append(oTableItem);
						});
					}, 
					error : function(){
						$('#tbl-add-item-purchase').empty();
					}
				});
			}
		});
		
		//tambah tabel item ke modal create PR
		$('#tbl-add-item-purchase').on('click', '.btn-add-item', function(){
			var element = $(this).parent().parent();
			var id = $(this).attr('id');
			var idVar = $(this).attr('id-var');
			var itemVar = element.find('td').eq(0).text();
			var inStock = element.find('td').eq(1).text();
			var reqQty = $('#add-qty'+id).val();
			
			if(added.indexOf(idVar.toString()) == -1) {
				var oTableAddItem = '<tr id-var="'+idVar+'" id="'+idVar+'"><td>'+itemVar+'</td>' +
					'<td>'+inStock+'</td>' +
					'<td>'+reqQty+'</td>' +
					'<td><button type="button" class="btn-cancel-item btn btn-danger" id="btn-del'+id+'" id-var="'+id+'">&times;</button>'
					'</tr>';
				$('#tbody-add-item').append(oTableAddItem);
				added.push(idVar);
				
			}else{
				var trItem = $('#tbody-add-item > #'+idVar+'');
				var oldReqQty = trItem.find('td').eq(2).text();
				var newReqQty = parseInt(oldReqQty)+parseInt(reqQty);
				trItem.find('td').eq(2).text(newReqQty);
			}
			$('#div-alert-modal').fadeIn();
			setTimeout(function(){
				$('#div-alert-modal').fadeOut();
			}, 1000);
		});
		
		
		//cancel item
		$('#tbl-pr-add-item').on('click', '.btn-cancel-item', function(){
			var id = $(this).attr('id-var');
			console.log(id);
			$(this).parent().parent().remove();
			var index = added.indexOf(id.toString());
			if(index > -1){
				added.splice(index, 1);
			}
		});
		
		
		//edit PR
		$('#dt-table').on('click', '.update', function(){
			
			$('#btn-save').prop('disabled', false);
			var id = $(this).attr('id');
			$('#tbody-add-item').empty();
			$.ajax({
				type : 'GET',
				url : '${pageContext.request.contextPath}/t/pr/get-one/'+id,
				dataType: 'json',
				success : function(data){
					var pr = data.status;
					if(pr=='Submitted'){
						alert('PR has been Submitted');
					}else if(pr=='Approved'){
						alert('PR has been Approved');
					}else if(pr=='Rejected'){
						alert('PR has been Rejected');
					}else if(pr=='PO Created'){
						alert('PR has been PO Created');
					}else{
						$('#input-id').val(data.id);
						$('#input-note').val(data.notes);
						$('#input-prNo').val(data.prNo);
						var date = data.readyTime.split('-');
						var dates = date[1]+'/'+date[2]+'/'+date[0];
						$('#insert-target').val(dates);
						
						$(data.prDetails).each(function(key, val){
							added.push(''+val.variant.id+'');
							$('#tbody-add-item').append(
								'<tr id-var="'+val.variant.id+'" id="'+val.variant.id+'"><td>'+val.variant.item.name+'-'+val.variant.name+'</td>'
								+'<td id="td'+val.id+'"></td>'
								+'<td>'+val.requestQty+'</td>'
								+'<td><button type="button" class="btn btn-danger btn-cancel-item" id="btn-del'+id+'" id-var="'+id+'">&times;</button>'
							);
							
							// get inStock from inventory
							$.ajax({
								type : 'GET',
								url : '${pageContext.request.contextPath}/t/pr/get-inventory?idPr='+id+'&idPrd='+val.id,
								dataType: 'json',
								success : function(inventory){
									console.log(inventory);
									$('#td'+val.id).append(inventory[0]);
								}
							});
						});

						$('#modal-pr-input').modal();
					}
				},
				error : function(){
					$('#modal-failed').modal();
				}
			});
		});
		
		// Search by Status
		$('#src-status').change(function(){
			var status = $('#src-status').val();
			var keyword = '';
			if(status == 'All'){
				window.location = '${pageContext.request.contextPath}/t/pr';
			}else{
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/pr/src-status?search='+status,
					success : function(data){
						$('#dt-table-pr').empty();
						console.log(data);
						$(data).each(function(key, val){
							
							var json_data = '/Date('+val.createdOn+')/';
							var asAMoment = moment(json_data);
							var tanggal = asAMoment.format('DD-MM-YYYY HH:mm:ss');
							
							$('#dt-table-pr').append('<tr><td>'+tanggal+'</td>'
								+'<td>'+val.prNo+'</td>'
								+'<td>'+val.notes+'</td>'
								+'<td>'+val.status+'</td>'
								+'<td><input type="button" class="update btn btn-success btn-sm" value="Edit" id="'+val.id+'" pr-status="'+val.status+'"> | '
								+'<a href="${pageContext.request.contextPath}/t/pr/detail/'+val.id+'" class="view btn btn-success btn-sm" key-id="'+val.id+'">View</a></td>');
						})
					},
					error : function(){
						$('#dt-table-pr').empty();
						console.log('search failed');
					}
				});
			}
		});
		
		// Search Global
		$('#src-global').on('input', function(){
			var global = $('#src-global').val();
			if(global == ''){
				$('#dt-table-pr').empty();
			}else{
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/pr/src-global?search='+global,
					success : function(data){
						$('#dt-table-pr').empty();
						console.log(data);
						$(data).each(function(key, val){
							
							var json_data = '/Date('+val.createdOn+')/';
							var asAMoment = moment(json_data);
							var tanggal = asAMoment.format('DD-MM-YYYY HH:mm:ss');
							
							$('#dt-table-pr').append('<tr><td>'+tanggal+'</td>'
								+'<td>'+val.prNo+'</td>'
								+'<td>'+val.notes+'</td>'
								+'<td>'+val.status+'</td>'
								+'<td><input type="button" class="update btn btn-success btn-sm" value="Edit" id="'+val.id+'" pr-status="'+val.status+'"> | '
								+'<a href="${pageContext.request.contextPath}/t/pr/detail/'+val.id+'" class="view btn btn-success btn-sm" key-id="'+val.id+'">View</a></td>');
						})
						
					},
					error : function(){
						$('#dt-table-pr').empty();
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
			$('#tbl-add-item-purchase').empty();
		}
		
	});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<h6><b>PURCHASE REQUEST</b></h6>
<hr>
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
		    <select name="title" id="src-status" class="form-control custom-select custom-select-md">
		    	<option selected disabled>Status</option>
		    		<option value="All">All</option>
		    		<option value="created">Created</option>
		    		<option value="Submitted">Submitted</option>
		    		<option value="Approved">Approved</option>
		    		<option value="Rejected">Rejected</option>
		    		<option value="PO Created">PO Created</option>
		    </select>
		</div>
	  </div>
	  <div class="col-md-2">
	  	<div class="form-group">
			<input type="text" class="form-control" id="src-global" placeholder="Search">
		</div>
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
			<th><center>Create Date</center></th>
			<th><center>PR No</center></th>
			<th><center>Note</center></th>
			<th><center>Status</center></th>
			<th><center>#</center></th>
		</thead>
		<tbody id="dt-table-pr">
			<c:forEach items="${prs }" var="pr">
				<tr>
					<td>
						<script>
							var times = '${pr.createdOn }';
							var time = times.split(':');
							document.write(time[0]+':'+time[1]);
						</script>
					</td>
					<td>${pr.prNo }</td>
					<td>${pr.notes }</td>
					<td>${pr.status }</td>
					<td>
						<a id="${pr.id }" class="update btn btn-success btn-sm" href="#">Edit</a> |
						<a id="${pr.id }" class="view btn btn-success btn-sm" href="${pageContext.request.contextPath}/t/pr/detail/${pr.id}">View</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

<!------------------------------------------------------ Modal Purchase Input --------------------------------------------------->

<div class="modal fade" id="modal-pr-input" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Purchase Request</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<div class="row" id="div-alert" style="display:none;">
						<div class="col-xs-12">
							<div class="alert alert-info alert-dismissible" role="alert" id="show-alert1" style="padding: 5px">
			                <p><i class="icon fa fa-check"></i> Data saved!</p>
			              </div>
						</div>
					</div>
					<input type="hidden" id="input-id" name="input-id" />
					<input type="hidden" id="input-status" name="input-status" />
					<div class="form-group">
						<label for="input-name">CREATE NEW PR : </label> ${outlet.name}
					</div>
					<div class="form-group">
						
					</div>
					<div class="form-group">
						<label for="input-name">Target Waktu Item Ready</label>
						<input type="text" class="form-control" id="insert-target" name="target-pr" value="03/18/2018" min="04/03/2018" required>
					</div>
					
					<div class="form-group">
						<label for="input-note">Notes</label>
						<textarea class="form-control" id="input-note" rows="5"></textarea>
					</div>
					<div class="form-group">
						<input type="hidden" id="input-prNo" name="input-prNo" />
						<label for="input-name">Purchase Request</label>
						<hr>
						
						<table id="tbl-pr-add-item" class="table table-striped table-bordered" cellspacing="0" width="100%">
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
						<button type="button" id="btn-submit" class="btn btn-success btn-block" style="display: none">Submit</button>
					</div>
					<div class="col-md-3">
						<button type="button" id="btn-cancel-input" class="btn btn-primary btn-block" data-dismiss="modal">Cancel</button>
					</div>
					<div class="col-md-3">
						<button type="button" id="btn-save" class="btn btn-primary btn-block">Save</button>
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
				<h5 class="modal-title" id="exampleModalLabel">Add Purchase Item</h5>
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
					<tbody id="tbl-add-item-purchase">
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
<%@ include file="modal/modal-alert-form.jsp"%>
<%@ include file="modal/modal-alert-failed.jsp"%>
	
</body>
</html>