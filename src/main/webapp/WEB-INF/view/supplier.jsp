<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!-- taglib untuk form spring -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- ambil javascript -->
<spring:url value="/resources/js/jquery-3.3.1.min.js" var="jq"></spring:url>
<spring:url value="/resources/css/bootstrap.min.css" var="bootmin"></spring:url>
<spring:url value="/resources/css/bootstrap.css" var="boot"></spring:url>
<spring:url value="/resources/css/dataTables.bootstrap4.min.css" var="dt"></spring:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Supplier</title>
<link rel="stylesheet" href="${bootmin }" />
<link rel="stylesheet" href="${boot }" />
<link rel="stylesheet" href="${dt }" />
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
//jQuery(document).ready(function(){ --> dijalankan setelah DOM nya telah selesai diload
		$(function(){
			//setup data untuk datatable
			$('#supplier-tbl').DataTable({
				paging : false,
				searching : false, 
			});	
			
			
			//button-create 
			$('#btn-create').click(function(){
				$('#modal-create-supp').modal(); 
			});
			
			//btn save kaya di modal save 
			 $('#btn-save').on('click', function(evt){
				evt.preventDefault(); //ini biar gak ngeload terus setelah di klik
				
				var supplier = {
					name : $('#input-supp-name').val(),
					address : $('#input-address').val(), 
					postalCode : $('#input-postal-code').val(), 
					email : $('#input-email').val(), 
					phone : $('#input-phone').val(), 
					province : {
						id : $('#input-province').val()
					}, 
					region : {
						id : $('#input-region').val()
					},
					district : {
						id : $('#input-district').val()
					}
				}
				//console.log(supplier); 
				 $.ajax({
					url : '${pageContext.request.contextPath}/supplier/save',
					type : 'POST', 
					contentType : 'application/json',
					data : JSON.stringify(supplier), 
					success : function(data){
						//console.log(data); 
						window.location="${pageContext.request.contextPath}/supplier"
						//alert('berhasil'); 
					},
					error : function(){
						alert('save failed'); 
					}
				});	
			});
			
			function setEditSupplier(supplier){
				$('#edit-id').val(supplier.id); 
				$('#edit-supp-name').val(supplier.name); 
				$('#edit-address').val(supplier.address); 
				$('#edit-phone').val(supplier.phone); 
				$('#edit-email').val(supplier.email); 
				$('#edit-postal-code').val(supplier.postalCode); 
				$('#edit-province').val(supplier.province.id); 
				$('#edit-region').val(supplier.region.id); 
				$('#edit-district').val(supplier.district.id); 
				//console.log(supplier); 
			}
			
			
			//btn view untuk mengedit atau update 
			$('.btn-edit').click(function(evt){
				evt.preventDefault(); 
				//ambil id
				var id=  $(this).attr('id'); 
				//console.log(id); 
				$.ajax({
					url : '${pageContext.request.contextPath}/supplier/get-one/' + id,
					type :'GET',
					dataType :'json', 
					success : function(supplier){
						setEditSupplier(supplier); 
						 $('#modal-edit-supp').modal(); 
					}, 
					error : function(){}
				});
			}); 
			
			//execute btn update 
			$('#btn-save-edit').on('click' , function(evt){
				evt.preventDefault();
				
				var supplier = {
						id : $('#edit-id').val(), 
						name : $('#edit-supp-name').val(),
						address : $('#edit-address').val(), 
						postalCode : $('#edit-postal-code').val(), 
						email : $('#edit-email').val(), 
						phone : $('#edit-phone').val(), 
						province : {
							id : $('#edit-province').val()
						}, 
						region : {
							id : $('#edit-region').val()
						},
						district : {
							id : $('#edit-district').val()
						}
					}
				
				console.log(supplier); 
					 
				$.ajax({
					url : '${pageContext.request.contextPath}/supplier/update', 
					type : 'PUT', 
					data : JSON.stringify(supplier), 
					contentType : 'application/json', 
					success : function(data){
						//alert ('yeay berhasil'); 
						window.location = '${pageContext.request.contextPath}/supplier'; 
					}, error : function(){
						alert ('update failed'); 
					}
				});
			});  
			
			 $('#input-province').change(function(){
			var id = $(this).val(); 
			if (id !== ""){
				$.ajax({
					url : '${pageContext.request.contextPath}/supplier/get-region?id=' + id, 
					type : 'GET', 
					success : function (data){
						var region = []; 
						var reg = "<option value=\"\">Choose Region</option>";
						region.push(reg); 
						$(data).each(function(index, data2){
							reg = "<option value=\""+data2.id+"\">"+data2.name+"</option>";
							region.push(reg); 
						})
						$('#input-region').html(region); 
					}, error : function(){
						alert ('get failed'); 
					}
				})
			}
		}); 
			 
			 $('#input-region').change(function(){
				 var id = $(this).val(); 
				 if ( id !== ""){
					 $.ajax ({
						 url :'${pageContext.request.contextPath}/supplier/get-district?id=' + id, 
						 type : 'GET', 
						 success : function(data){
							 var district = []; 
							 var dis = "<option value=\"\">Choose District</option>"; 
							 district.push(dis); 
							 $(data).each(function (index, data2){
								 dis = "<option value=\""+data2.id+"\">"+data2.name+"</option>";
								 district.push(dis); 
							 })
							 $('#input-district').html(district); 
						 },
						 error : function (){
							 alert ('get-failed'); 
						 }
					 })
				 }
			 });
			
			 
			 $('#edit-province').change(function(){
					var id = $('#edit-province').val(); 
					if (id !== ""){
						$.ajax({
							url : '${pageContext.request.contextPath}/supplier/get-region?id=' + id, 
							type : 'GET', 
							success : function (data){
								var region = []; 
								var reg = "<option value=\"\">Choose Region</option>";
								region.push(reg); 
								$(data).each(function(index, data2){
									reg = "<option value=\""+data2.id+"\">"+data2.name+"</option>";
									region.push(reg); 
								})
								$('#edit-region').html(region); 
							}, error : function(){
								alert ('get failed'); 
							}
						})
					}
				}); 
					 
					 $('#edit-region').change(function(){
						 var id = $('#edit-region').val(); 
						 if ( id !== ""){
							 $.ajax ({
								 url :'${pageContext.request.contextPath}/supplier/get-district?id=' + id, 
								 type : 'GET', 
								 success : function(data){
									 var district = []; 
									 var dis = "<option value=\"\">Choose District</option>"; 
									 district.push(dis); 
									 $(data).each(function (index, data2){
										 dis = "<option value=\""+data2.id+"\">"+data2.name+"</option>";
										 district.push(dis); 
									 })
									 $('#edit-district').html(district); 
								 },
								 error : function (){
									 alert ('get-failed'); 
								 }
							 })
						 }
					 });
				
					//button-search
					 $('#btn-search').on('click',function() {
							var word = $('#search').val();
							window.location = '${pageContext.request.contextPath}/supplier/search?search='+ word;
						}); 	
					
		});
	//});
</script>
</head>
<body>
<div class="container">
	<div>
		<b>Supplier</b>
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<div id="search-box" style="margin-top: 20px; margin-botton: 20px">
				<span><input type="text" id="search" placeholder = "search"/></span> <span><a
				id="btn-search" href="#" class="btn btn-primary">Search</a></span>
				<button type="button" id="btn-create" class="btn btn-primary" style="float:right; margin-right: 0px; width:150px;">Create</button>
			<button type="button" id="btn-export" class="btn btn-primary" style="float:right; margin-right: 50px; width: 150px;">Export</button>
			</div>
			<!-- <input type="text" id="search" placeholder="Search" /> -->
		</form>
	</div>
	<table id="supplier-tbl" class="table table-sm table-striped table-bordered" width="100%" cellspacing="0">
		<thead class="thead-dark">
			<th>Name</th>
			<th>Address</th>
			<th>Phone</th>
			<th>Email</th>
			<th>#</th>
		</thead>
		<tbody>
			<c:forEach items="${suppliers}" var="supp">
				<tr>
					<td>${supp.name}</td>
					<td>${supp.address}</td>
					<td>${supp.phone}</td>
					<td>${supp.email}</td>
					<td><center>
					<a id="${supp.id }" class="btn-edit btn btn-info btn-sm" href="#">Edit</a>   
					</center>
					</td>
				</tr>
			</c:forEach> 
		</tbody>
	</table>
	
	<!-- panggil modal dari folder modal -->
	<%@ include file="modal/supplier/create-supp.jsp" %>
	<%@ include file="modal/supplier/edit-supp.jsp" %>
	<%-- <%@ include file="modal/room/delete-room.jsp" %> --%> 
</div>
</body>
</html>