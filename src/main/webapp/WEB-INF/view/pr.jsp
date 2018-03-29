<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->

<script type="text/javascript">
	jQuery(document).ready(function(){
		$('#dt-table').DataTable( {
	        "searching":   false,
	        "info":     false
	    });
		
		$(function() {
		    $('input[name="daterange"]').daterangepicker();
		});
		
		$(function() {
		    $('#insert-target').daterangepicker({
		        singleDatePicker: true,
		        showDropdowns: true,
		        dateFormat: 'dd-mm-yyyy'
		    });
		});
		
		$('#btn-create').on('click', function(){
			$('#modal-pr-input').modal();
		});
		
		$('#btn-add-item').on('click', function(){
			$('#modal-pr-input').modal('hide');
			$('#modal-pr-add-item').modal();
		});
		
		$('#btn-add-2').on('click', function(){
			$('#modal-pr-add-item').modal('hide');
			$('#modal-pr-input').modal('show');
			$('#btn-submit').show();
		});
		
		$('#btn-cancel-add').on('click', function(){
			$('#modal-pr-input').modal();
			$('#btn-submit').hide();
		});
		
		$('#btn-cancel-input').on('click', function(){
			$('#btn-submit').hide();
		});
		
		
		var CHAR_SETS = {
			    d: '0123456789',
			    A: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
			    w: '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
			};

		function randChar(charType) {
		    var chars = CHAR_SETS[charType];
		    return chars.charAt(parseInt(Math.random() * chars.length));
		};
		var code = 'PR'+'AddwwwwAAAddd'.replace(/[Adw]/g, randChar)
			
		
		//save
		$('#btn-save').on('click', function(){
			
			var matriks = $('#insert-target').val().split('/');
			console.log(matriks);
			var ready = matriks[2]+'-'+matriks[0]+'-'+matriks[1];
			console.log(ready);
			
			var genCode = code;
			console.log(code);
			var pr = {
				readyTime : ready,
				prNo : genCode,
				notes : $('#input-note').val(),
				status : "created",
				outletId : {
					id : 2273
				}
			};
			console.log(pr);

			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/pr/save',
				data : JSON.stringify(pr),
				contentType : 'application/json',
				success : function() {
					window.location = '${pageContext.request.contextPath}/pr';
				},
				error : function() {
					alert('save failed');
				}

			});
		});
		
		//view detail
		$('.view').on('click', function(){
			var id = $(this).attr('id');
			console.log(id);
			window.location = '${pageContext.request.contextPath}/pr/detail?id=' + id;
		});
		
		var added = [];
		var addedQty = [];
		$('.btn-added-item').hide();
		
		// search variant
		$('#src-item-variant').on('input',function(e){
			var word = $(this).val();
			if (word=="") {
				$('#tbl-add-item-purchase').empty();
			} else {
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/pr/search-item?search='+word,
					dataType: 'json',
					success : function(data){
						console.log(data);
						$('#tbl-add-item-purchase').empty();
						$.each(data, function(key, val) {
							if(added.indexOf(val.id.toString()) == -1) {
								$('#tbl-add-item-purchase').append(
										'<tr><td>'+ val.variant.item.name +'-'+ val.variant.name +'</td><td id="inStock'+ val.id +'">'
										+ val.beginning +'</td><td id="td-qty'+ val.id +'"><input type="number" class="add-transfer-stock-qty'+ val.id +'" value="1" /></td><td><button type="button" id="'+ val.id +'" class="btn-add-item'
										+ val.id +' btn-add-item btn btn-primary">Add</button><button type="button" id="'+ val.id +'" class="btn-added-item'
										+ val.id +' btn-added-item btn">Added</button></td></tr>');
								$('.btn-added-item'+val.id).hide();
							} else {
								var a = added.indexOf(val.id.toString());
								$('#tbl-add-item-purchase').append('<tr><td>'+ val.variant.item.name +'-'+ val.variant.name +'</td><td>'
										+ val.endingQty +'</td><td id="td-qty'+ val.id +'">'+addedQty[a]+'</td><td><button type="button" id="'+ val.id +'" class="btn-add-item'
										+ val.id +' btn-add-item btn btn-primary">Add</button><button type="button" id="'+ val.id +'" class="btn-added-item'
										+ val.id +' btn-added-item btn">Added</button></td></tr>');
								$('.btn-add-item'+val.id).hide();
							}
						});
					}, 
					error : function(){
						$('tbl-add-item-purchase').empty();
					}
				});
			}
		});
	});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<h6>PURCHASE REQUEST</h6>
<hr>
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
		<tbody>
			<c:forEach items="${prs }" var="pr">
				<tr>
					<td>${pr.createdOn }</td>
					<td>${pr.prNo }</td>
					<td>${pr.notes }</td>
					<td>${pr.status }</td>
					<td>
						<a id="${pr.id }" class="update btn btn-success btn-sm" href="#">Edit</a> |
						<a id="${pr.id }" class="view btn btn-success btn-sm" href="#">View</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

<!-- Call modal -->
<!-- Modal Purchase Input -->
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
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<label for="input-name">CREATE NEW PR : </label>
						<select name="role" id="insert-role">
							<c:forEach var="out" items="${outlets }">
								<option value="${out.id }">${out.name }</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						
					</div>
					<div class="form-group">
						<label for="input-name">Target Waktu Item Ready</label>
						<input type="text" class="form-control" id="insert-target" name="target-pr" value="03/18/2018">
					</div>
					
					<div class="form-group">
						<label for="input-note">Notes</label>
						<textarea class="form-control" id="input-note" rows="5"></textarea>
					</div>
					<div class="form-group">
						<label for="input-name">Purchase Request</label>
						<hr>
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

<!-- Modal Add Item -->
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
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<input type="text" id="src-item-variant" class="form-control" placeholder="Item Name - Variant Name" />
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
						<button type="button" id="btn-add-2" class="btn btn-primary btn-block">Add</button>
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