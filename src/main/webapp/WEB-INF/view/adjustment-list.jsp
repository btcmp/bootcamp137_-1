<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/js/jquery-3.3.1.min.js" var="jq"></spring:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adjusment List</title>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="../resources/css/bootstrap.css" />
<link rel="stylesheet" href="../resources/css/dataTables.bootstrap4.min.css" />
<link rel="stylesheet" href="../https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="../resources/css/daterangepicker.css" />
<script type="text/javascript" src="${jq }"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/parsley.js"/>"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/parsley.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/dataTables.bootstrap4.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/moment.js"/>"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/daterangepicker.js"/>"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>


<style type="text/css">
	input.parsley-error
		{
		  color: #B94A48 !important;
		  background-color: #F2DEDE !important;
		  border: 1px solid #EED3D7 !important;
		}
</style>

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
</head>
<body>
<h6>Adjustment</h6>
<hr>
<div class="container">
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
</div>

</body>
</html>