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
<title>Entry Employee</title>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="../resources/css/bootstrap.css" />
<link rel="stylesheet" href="../resources/css/dataTables.bootstrap4.min.css" />
<script type="text/javascript" src="${jq }"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/parsley.js"/>"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/parsley.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="../resources/js/dataTables.bootstrap4.min.js"/>"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>


<style type="text/css">
	input.parsley-error
		{
		  color: #B94A48 !important;
		  background-color: #F2DEDE !important;
		  border: 1px solid #EED3D7 !important;
		}
		th{
			text-align: center;
		}
</style>

<script type="text/javascript">
	jQuery(document).ready(function(){
		/* create new item */
		$('#btn-create').on('click', function(){
			$('#modal-input-transfer-stock').modal('show');
		});
		
		 $(document).on('click','#btn-save', function(){		 	
			 
		});
		 
		
		 
		 /* create add variant */
		 $('#btn-add-item').on('click', function(){
			 $('#modal-input-transfer-stock').modal('hide');
				$('#modal-add-item').modal();
			});
		
		 $('#btn-add-2').on('click', function(){
				$('#modal-add-item').modal('hide');
				$('#modal-input-transfer-stock').modal('show');
			});
		 
		 $('#btn-add-cancel').on('click', function(){
				$('#modal-add-item').modal('hide');
				$('#modal-input-transfer-stock').modal('show');
			});
		
	});
</script>
</head>
<body>
<div class="container">
	<div>
		<b>Transfer Stock</b>
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<input type="text" id="search" placeholder="Search" />
			<button type="button" id="btn-create" class="btn btn-primary" style="float:right; margin-right: 0px; width:150px;">Create</button>
			<button type="button" id="btn-export" class="btn btn-primary" style="float:right; margin-right: 50px; width: 150px;">Export</button>
			
		</form>
	</div>
	
	<table id="emp-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead class="thead-dark">
			<th>Transfer Data</th>
			<th>From Outlet</th>
			<th>To Outlet</th>
			<th>Status</th>
			<th>#</th>
		</thead>
		<tbody>
			<%-- <c:forEach items="${items}" var="item"> --%>
				<tr>
				<td>01/01/2016</td>
				<td><center>Outlet 1</center></td>
				<td><center>Outlet 2</center></td>
				<td><center>Created</center></td>
				<td><center>
					<a id="${item.id}" class="btn-view btn btn-info btn-sm" href="#">View</a></center>
				</td>
			</tr>
			<%-- </c:forEach> --%>	
		</tbody>
	</table>
</div>

<!-- call modal -->
<!-- Modal Input -->
<div class="modal fade" id="modal-input-transfer-stock" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Transfer Stock</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<div class="form-group">
						<label for="input-name">CREATE NEW TRANSFER STOCK FROM : Outlet Login</label>
					</div>
					<div class="form-group">
						<select style="width: 100%;">
							<option>Outlet 2</option>
						</select>
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
<div class="modal fade" id="modal-add-item" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Add m</h5>
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