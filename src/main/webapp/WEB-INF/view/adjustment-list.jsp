<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<script type="text/javascript">
	jQuery(document).ready(function(){
		$('#dt-table').DataTable( {
	    });
		
		$(function() {
		    $('input[name="daterange"]').daterangepicker();
		});
		
		$(function() {
		    $('input[name="target-pr"]').daterangepicker({
		        singleDatePicker: true,
		        showDropdowns: true
		    });
		});
		
		$('#btn-create').on('click', function(){
			$('#modal-adj-input').modal();
		});
		
		$('#btn-add-item').on('click', function(){
			$('#modal-adj-input').modal('hide');
			$('#modal-adj-add-item').modal();
		});
		
		$('#btn-add-2').on('click', function(){
			$('#modal-adj-add-item').modal('hide');
			$('#modal-adj-input').modal('show');
		});
		
		$('#btn-cancel-add').on('click', function(){
			$('#modal-adj-input').modal();
		});
		
		$('.btn-view').on('click', function(){
			window.location.assign("${pageContext.request.contextPath}/po/detail-adjustment");
		});
	});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->
	<div class="row">
		<div><h4 style="margin-left: 2%;">Adjustment</h4></div>
	</div>
	<div class="row">
	  <div class="col-md-5">
	  	<div class="form-group">
			<input type="text" class="form-control" id="insert-date" name="daterange" value="01/01/2018 - 01/31/2018">
		</div>
	  </div>
	  <div class="col-md-3">
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
			<th>Adjustment Date</th>
			<th>Notes</th>
			<th>Status</th>
			<th>#</th>
		</thead>
		<tbody>
			<%-- <c:forEach items="" var="emp"> --%>
				<tr>
					<td>01/01/2016 10:30</td>
					<td>-</td>
					<td>Submitted</td>
					<td>
						<a id="" class="btn-view btn btn-info btn-sm" href="#">view</a>
					</td>
				</tr>
			<%-- </c:forEach> --%>
		</tbody>
	</table>
</div>

<!-- Call modal -->
<!-- Modal Purchase Input -->
<div class="modal fade" id="modal-adj-input" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Adjustment</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<div class="form-group">
						<label for="input-name">CREATE NEW ADJUSTMENT : Outlet Login</label>
					</div>
					
					<div class="form-group">
						<label for="input-note">Notes</label>
						<textarea class="form-control" id="input-note" rows="5"></textarea>
					</div>
					<div class="form-group">
						<label for="input-name">Adjustment Stock</label>
						<hr>
						<div>
						<table id="dt-add-item" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
							<thead class="thead-dark" style="text-align: center;">
								<th>Item</th>
								<th>In Stock</th>
								<th>Adj. Qty.</th>
								<th>#</th>
							</thead>
							<tbody>
								<tr>
									<td>Baju</td>
									<td><center>2</center></td>
									<td><center>3</center></td>
									<td><center><button class="btn-remove btn btn-danger">X</button></center></td>
								</tr>
							</tbody>
						</table>
					</div>
						<button type="button" id="btn-add-item" class="btn btn-primary btn-block">Add Item</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
				<button type="button" id="btn-save" class="btn btn-primary">Save & Submit</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal Add Item -->
<div class="modal fade" id="modal-adj-add-item" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Add Item</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<label for="input-name">Item Name - Variant Name</label>
					</div>
					<div>
						<table id="dt-add-item" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
							<thead class="thead-dark">
								<th>Item</th>
								<th>In Stock</th>
								<th>Adj. Qty.</th>
							</thead>
							<tbody>
								<tr>
									<td>Baju</td>
									<td><center>2</center></td>
									<td><center>3</center></td>
								</tr>
							</tbody>
						</table>
					</div>
				</form>
			</div>
			<div class=modal-body>
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
</body>
</html>