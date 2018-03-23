<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!-- taglib untuk form spring -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- ambil javascript -->
<spring:url value="/resources/js/jquery-3.3.1.min.js" var="jq"></spring:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Category</title>
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
//jQuery(document).ready(function(){ --> dijalankan setelah DOM nya telah selesai diload
		$(function(){
			//setup data untuk datatable
			$('#category-tbl').DataTable({
				paging : false,
				searching : false, 
			});	
			
			//button-create // modal 
			$('#btn-create').click(function(){
				$('#modal-create-category').modal(); 
			});
			
			/* $('#btn-view').click(function(){
				$('#modal-edit-category').modal(); 
			}); */
			
			//untuk ngesave 
			//btn save kaya di modal save 
			$('#btn-save-cat').on('click', function(evt){
				evt.preventDefault(); 
				var category = {
					name : $('#input-category-name').val(),
				}
				console.log(category); 
				 $.ajax({
					url : '${pageContext.request.contextPath}/category/save',
					type : 'POST', 
					contentType : 'application/json',
					data : JSON.stringify(category), 
					success : function(data){
						//console.log(data); 
						window.location="${pageContext.request.contextPath}/category"
						//alert('berhasil'); 
					},
					error : function(){
						alert('save failed'); 
					}
				});	
			});
			
			
			//btn view untuk mengedit atau update 
			$('.btn-view').click(function(evt){
				evt.preventDefault(); 
				//ambil id
				var id=  $(this).attr('id'); 
				//console.log(id); 
				$.ajax({
					url : '${pageContext.request.contextPath}/category/get-one/' + id,
					type :'GET',
					success : function(category){
						setEditCategory(category); 
						$('#modal-edit-category').modal(); 
					}, 
					error : function(){
						alert('gabisa ambil data');
					},
					dataType :'json'
				});
			});
			function setEditCategory(category){
				$('#edit-id').val(category.id); 
				$('#edit-category-name').val(category.name); 
			};
			//execute btn update 
			$('#btn-save-edit').click(function(){
				var category={
						id : $('#edit-id').val(), 
						name : $('#edit-category-name').val(),
				}
				$.ajax({
					url : '${pageContext.request.contextPath}/category/update', 
					type : 'PUT', 
					data : JSON.stringify(category), 
					contentType : 'application/json', 
					success : function(data){
						window.location = '${pageContext.request.contextPath}/category'; 
					}, error : function(){
						alert ('update failed'); 
					}
				});
			}); 
			
			//btn-X
			$('#btn-X').click(function(){
				var category={
						id : $('#edit-id').val(), 
						name : $('#edit-category-name').val(),
				}
				$.ajax({
					url : '${pageContext.request.contextPath}/category/update-status', 
					type : 'PUT', 
					data : JSON.stringify(category), 
					contentType : 'application/json', 
					success : function(data){
						window.location = '${pageContext.request.contextPath}/category'; 
					}, error : function(){
						alert ('update failed'); 
					}
				});
			}); 
			
			
		});
		/* function clearText() {
		    document.getElementById("input-category-name").value=""
		} */
	//});
</script>
</head>
<body>
<div class="container">
	<div>
		<b>Category</b>
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<input type="text" id="search" placeholder="Search" />
			<button type="button" id="btn-create" class="btn btn-primary" style="float:right; margin-right: 0px; width:150px;">Create</button>
			<button type="button" id="btn-export" class="btn btn-primary" style="float:right; margin-right: 50px; width: 150px;">Export</button>
			
		</form>
	</div>
	<table id="category-tbl" class="table table-sm table-striped table-bordered" width="100%" cellspacing="0">
		<thead class="thead-dark">
			<th><center>Category Name</center></th>
			<th><center>Items Stock</center></th>
			<th><center>#</center></th>
		</thead>
		<tbody>
			<c:forEach items="${categories}" var="ctg">
				<tr>
					<td>${ctg.name}</td>
					<td>-</td>
					<td><center><a id="${ctg.id }" class="btn-view btn btn-info" href="#">View</a>   
					</center></td>
				</tr>
			</c:forEach> 
		</tbody>
	</table>
	
 	<!-- panggil modal dari folder modal -->
 	<%@ include file="modal/category/create-category.jsp" %>
	<%@ include file="modal/category/edit-category.jsp" %>
</div>
</body>
</html>