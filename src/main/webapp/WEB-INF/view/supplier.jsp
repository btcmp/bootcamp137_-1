<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!-- taglib untuk form spring -->
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- ambil javascript -->
<spring:url value="/resources/js/jquery-3.3.1.min.js" var ="jq"></spring:url>
<spring:url value="/resources/js/parsley.min.js" var="parsley"></spring:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Supplier</title>
<!-- <link rel="stylesheet" href="http://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css"/> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.css"/>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<script type="text/javascript" src="${jq }"></script>
<script type="text/javascript" src="${parsley }"></script>
<script type="text/javascript" src="http://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script type="text/javascript">
//jQuery(document).ready(function(){ --> dijalankan setelah DOM nya telah selesai diload
		$(function(){
			//setup data untuk datatable
			$('#supplier-tbl').DataTable({
				paging : false,
				searching : false, 
			});	
		});
	//});
</script>
</head>
<body>
<div class="container">
	<h4>Supplier</h4>
	<hr>
	<div id="box-search-add">
		<div id="button-add" style="float : right ">
			<button type="button" id="btn-add" class="btn btn-primary" >Create</button>
		 </div>
		<div id="search-box" style="margin-top: 20px; margin-botton: 20px">
			<span><input type="text" id="search" placeholder="search"/></span>
		</div>
	</div>
	<hr>
	<table id="supplier-tbl" class="table table-striped table-bordered" width="100%" cellspacing="0">
		<thead>
			<th>Name</th>
			<th>Address</th>
			<th>Phone</th>
			<th>Email</th>
			<th>#</th>
		</thead>
		<tbody>
			<c:forEach items="${rooms}" var="rooms">
				<tr>
					<td>${rooms.name}</td>
					<td>${rooms.type}</td>
					<td>${rooms.customerName}</td>
					<td>${rooms.fasilitas}</td>
					<td>${rooms.status}</td>
					<td><a id="${rooms.id }" class="update btn btn-warning" href="#">Edit</a>   
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
<%-- 	<!-- panggil modal dari folder modal -->
	<%@ include file="modal/room/edit-room.jsp" %>
	<%@ include file="modal/room/save-room.jsp" %>
	<%@ include file="modal/room/delete-room.jsp" %> --%>
</div>
</body>
</html>