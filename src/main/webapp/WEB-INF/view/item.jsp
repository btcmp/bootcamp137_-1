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
<link rel="stylesheet" href="resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="resources/css/bootstrap.css" />
<link rel="stylesheet" href="resources/css/dataTables.bootstrap4.min.css" />
<script type="text/javascript" src="${jq }"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/parsley.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/parsley.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/dataTables.bootstrap4.min.js"/>"></script>

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
		 $('#btn-save').on('click', function(){
		 	var item = {
				name: $('#input-item-name').val(),
				categoryId : {
					Id: $('#input-item-category').val()
				},
		 		active: 0
			};
			console.log(item);
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/item/save',
				data : JSON.stringify(item),
				contentType : 'application/json',
				success : function(){
					//window.location = '${pageContext.request.contextPath}/customer';
				}, error : function(){
					alert('save failed');
				}
				
			});
		});
		
		$('#btn-create').on('click', function(){
			$('#modal-create-item').modal('show');
		});
		
		$('#btn-add-variant').on('click', function(){
			$('#modal-add-variant').modal('show');
		});
		
	});
</script>
</head>
<body>
<div class="container">
	<div>
		<b>Items</b>
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
			<th>Name</th>
			<th>Category</th>
			<th>Unit Price</th>
			<th>In Stock</th>
			<th>Stock Alert</th>
			<th>#</th>
		</thead>
		<tbody>
			<tr>
				<td>Toyota</td>
				<td><center>Transportation</center></td>
				<td><center>Rp.200000</center></td>
				<td><center>10</center></td>
				<td><center>Low</center></td>
				<td><center>
					<a id="btn-create" class="btn btn-info btn-sm" href="#">Edit</a></center>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<!-- call modal -->
	<%@ include file="modal/item/create-edit-item.jsp" %>

</body>
</html>