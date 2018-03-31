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

		$('#btn-add-item-var').on('click', function(){
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
		
	});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<h6>TRANSFER STOCK</h6>
<hr>
	<div class="row">
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
		<tbody>
			<c:forEach items="${tss }" var="ts">
				<tr>
					<td>${ts.createdOn }</td>
					<td>${ts.fromOutlet }</td>
					<td>${ts.toOutlet }</td>
					<td>${ts.status }</td>
					<td>|
						<a id="${ts.id }" class="view btn btn-success btn-sm" href="#">View</a>
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
				<h5 class="modal-title" id="exampleModalLabel">Transfer Stock</h5>
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
						<button type="button" id="btn-add-item-var" class="btn btn-primary btn-block">Add</button>
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