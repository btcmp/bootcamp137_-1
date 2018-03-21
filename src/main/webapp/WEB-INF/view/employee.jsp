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
</style>

<script type="text/javascript">
	jQuery(document).ready(function(){
		$('#btn-save').on('click', function(){
			
			var customer = {
				name : $('#name').val(),
				email : $('#email').val(),
				contact : $('#contact').val(),
				address : $('#address').val()
			};
			console.log(customer);
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/customer/save',
				data : JSON.stringify(customer),
				contentType : 'application/json',
				success : function(){
					window.location = '${pageContext.request.contextPath}/customer';
				}, error : function(){
					alert('save failed');
				}
				
			});
		});
	});
</script>
</head>
<body>
<div class="container">
	<div>
		ADD EMPLOYEE
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<input type="text" id="name" placeholder="Name" /><br>
			<input type="text" id="contact" placeholder="Contact" /><br>
			<input type="text" id="email" placeholder="Email" /><br>
			<input type="text" id="address" placeholder="Address" /><br>
			<button type="button" id="btn-save" class="btn btn-primary">Save</button>
		</form>
	</div>
	
	<table id="emp-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead class="thead-dark">
			<th>Name</th>
			<th>Address</th>
			<th>Email</th>
			<th>Contact</th>
			<th>Action</th>
		</thead>
		<tbody>
			<c:forEach items="${customers }" var="customer">
				<tr>
					<td>${customer.name }</td>
					<td>${customer.address }</td>
					<td>${customer.email }</td>
					<td>${customer.contact }</td>
					<td>
						<a id="${customer.id }" class="update btn btn-info btn-sm" href="#">Edit</a> |
						<a id="${customer.id }" class="delete btn btn-danger btn-sm" href="#">Delete</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<!-- call modal -->

</body>
</html>