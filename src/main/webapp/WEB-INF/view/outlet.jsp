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
<title>Outlet</title>
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
			$('#outlet-tbl').DataTable({
				paging : false,
				searching : false, 
			});	
			
			//button-create 
			$('#btn-create').click(function(){
				$('#modal-create-outlet').modal(); 
			});
			
			/* $('.btn-edit').click(function(){
				$('#modal-edit-outlet').modal(); 
			}); */
			
			
			//btn save kaya di modal save 
			 $('#btn-save').on('click', function(evt){
				evt.preventDefault(); //ini biar gak ngeload terus setelah di klik
				
				var outlet = {
					name : $('#input-outlet-name').val(),
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
					url : '${pageContext.request.contextPath}/outlet/save',
					type : 'POST', 
					contentType : 'application/json',
					data : JSON.stringify(outlet), 
					success : function(data){
						//console.log(data); 
						window.location="${pageContext.request.contextPath}/outlet"
						//alert('berhasil'); 
					},
					error : function(){
						alert('save failed'); 
					}
				});	
			});
			
			 $('.btn-edit').on('click', function(evt){
					evt.preventDefault(); 
					var id= $(this).attr('id'); // ambil variabel id 
					console.log(id);
					$.ajax({
						url : '${pageContext.request.contextPath}/outlet/get-one/' + id, 
						type :'GET',
						success : function(outlet){
							setEditOutlet(outlet); 
							$('#modal-edit-outlet').modal(); 
						},
						error : function(){
						alert('failed getting data update')	;
						}, 
						dataType :'json'
					});
				});
				
				//set up data update 
				function setEditOutlet(outlet){
					//console.log(cust); 
					$('#edit-id').val(outlet.id); 
					$('#edit-outlet-name').val(outlet.name); 
					$('#edit-address').val(outlet.address); 
					$('#edit-postal-code').val(outlet.postalCode); 
					$('#edit-phone').val(outlet.phone); 
					$('#edit-email').val(outlet.email); 
					$('#edit-province').val(outlet.province.id); 
					$('#edit-region').val(outlet.region.id); 
					$('#edit-district').val(outlet.district.id); 
				}
				
				 //execute btn update 
				$('.btn-save-outlet').on('click', function(evt){
					evt.preventDefault(); 
					
					var outlet = {
							id : $('#edit-id').val(), 
							name : $('#edit-outlet-name').val(),
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
					console.log(outlet); 
					$.ajax({
						url : '${pageContext.request.contextPath}/outlet/update', 
						type :'PUT', 
						data : JSON.stringify(outlet), 
						contentType : 'application/json', 
						success : function(data){
							window.location = '${pageContext.request.contextPath}/outlet';
						/* 	alert ('update berhasil');  */
						}, 
						error : function(){
							alert ('update failed');
						}
					}); 
					/* $.ajax({
						url : '${pageContext.request.contextPath}/outlet/update', 
						type : 'PUT', 
						data : JSON.stringify(outlet2), 
						contentType : 'application/json', 
						success : function(data){
							alert('update berhasil'); 
							//window.location = '${pageContext.request.contextPath}/outlet'; 
						}, error : function(){
							alert ('update failed'); 
						}
					});  */
				}); 
				
		});
	//});
</script>
</head>
<body>
<div class="container">
	<div>
		<b>Outlet</b>
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<input type="text" id="search" placeholder="Search" />
			<button type="button" id="btn-create" class="btn btn-primary" style="float:right; margin-right: 0px; width:150px;">Create</button>
			<button type="button" id="btn-export" class="btn btn-primary" style="float:right; margin-right: 50px; width: 150px;">Export</button>
		</form>
	</div>
	<hr>
	<table id="outlet-tbl" class="table table-sm table-striped table-bordered" width="100%" cellspacing="0">
		<thead class="thead-dark">
			<th><center>Name</center></th>
			<th><center>Address</center></th>
			<th><center>Phone</center></th>
			<th><center>Email</center></th>
			<th><center>#</center></th>
		</thead>
		<tbody>
			<%-- <tr>
				<td>Outlet 1</td>
				<td>Jakarta</td>
				<td>021-5557777</td>
				<td>mail@mail.com</td>
				<td><center>
					<a id="${rooms.id }" class="btn-edit btn btn-info btn-sm" href="#">Edit</a>   
					</center>
				</td>
			</tr> --%>
			<c:forEach items="${outlets}" var="outs">
				<tr>
					<td>${outs.name}</td>
					<td>${outs.address}</td>
					<td>${outs.phone}</td>
					<td>${outs.email}</td>
					<td><a id="${outs.id }" class="btn-edit btn btn-info btn-sm" href="#">Edit</a>   
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
 	<!-- panggil modal dari folder modal -->
	<%@ include file="modal/outlet/create-outlet.jsp" %>
	 <%@ include file="modal/outlet/edit-outlet.jsp" %>
	<%-- <%@ include file="modal/room/delete-room.jsp" %> --%> 
</div>
</body>
</html>