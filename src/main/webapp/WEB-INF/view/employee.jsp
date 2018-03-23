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
<link rel="stylesheet" href="resources/css/fontawesome.min.css" />
<link rel="stylesheet" href="resources/css/funkyradio.min.css" />
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
		$('#dt-table').DataTable( {
	        "searching":   false,
	        "info":     false
	    });
		
		$('#btn-assign-outlet').on('click', function(){
			$('#modal-assign-outlet').modal();
		});
		
		$('#btn-select-outlet').on('click', function(){
			$('#modal-assign-outlet').modal('hide');
		});
		
		$('#cb-have-account').val('false');
		$('#cb-have-account').change(function(){
	        if(this.checked){
	            $('#row-user').show(1000);
	            $('#cb-have-account').val('true');
	        }
	        else{
	            $('#row-user').hide(1000);
	            $('#cb-have-account').val('false');
	        }
	    });
		
		//save
		$('#btn-save').on('click', function(){
			
			var empOut = [];
			
			$('.select-outlet:checked').each(function(){
				var eo = {
					outlet : {
						id : $(this).val()
					}
				};
				empOut.push(eo);
			});
			
			console.log(empOut);
			
			var employee = {
				id : $('#insert-emp-id').val(),
				firstName : $('#insert-first-name').val(),
				lastName : $('#insert-last-name').val(),
				email : $('#insert-email').val(),
				title : $('#insert-title').val(), 
				empouts : empOut,
				haveAccount : $('#cb-have-account').val(),
				active : 0
			};
			console.log(employee);

			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/employee/save',
				data : JSON.stringify(employee),
				contentType : 'application/json',
				success : function(){
					window.location = '${pageContext.request.contextPath}/employee';
				}, error : function(){
					alert('save failed');
				}
				
			});
		});
		
		//edit
		$('.update').on('click', function(evt){
			evt.preventDefault();
			var id = $(this).attr('id');
			console.log(id);
			
			//ajax ambil data
			$.ajax({
				url : '${pageContext.request.contextPath}/employee/get-one/'+id,
				type : 'GET',
				dataType : 'json',
				success : function(emp){
					setEditEmployee(emp);
					$('input[name="cb-have-account"]').prop('checked', false);
					if(emp.haveAccount!=0){
						$('input[name="cb-have-account"]').prop('checked', true);
					}
				},
				error : function(){
					alert('fail ambil data');
				}
			});
		});
		
		//set edit mahasiswa
		function setEditEmployee(emp){
			$('#insert-emp-id').val(emp.id);
			$('#insert-first-name').val(emp.firstName);
			$('#insert-last-name').val(emp.lastName);
			$('#insert-email').val(emp.email);
			$('#insert-title').val(emp.title);
		}
		
		$('.btn-x').on('click',function(evt){
			evt.preventDefault();
			var id = $(this).attr('id');
			
			console.log(id);
			
			//ajax ambil data
			$.ajax({
				url : '${pageContext.request.contextPath}/employee/get-one/'+id,
				type : 'GET',
				dataType : 'json',
				success : function(emp){
					setEditEmployee(emp);
					$('input[name="cb-have-account"]').prop('checked', false);
					if(emp.haveAccount!=0){
						$('input[name="cb-have-account"]').prop('checked', true);
					}
					$('#delete-data').modal();
				},
				error : function(){
					alert('fail ambil data');
				}
			});
		});
		
		$('#btn-delete').click(function(){
			var emp = {
					id : $('#insert-emp-id').val(),
					firstName : $('#insert-first-name').val(),
					lastName : $('#insert-last-name').val(),
					email : $('#insert-email').val(),
					title : $('#insert-title').val(),
					haveAccount : $('#cb-have-account').val()
				};
			
			$.ajax({
				url : '${pageContext.request.contextPath}/employee/update-status', 
				type : 'PUT',
				data : JSON.stringify(emp), 
				contentType : 'application/json', 
				success : function(data){
					window.location = '${pageContext.request.contextPath}/employee'; 
				}, error : function(){
					alert ('update failed'); 
				}
			});
		});
		
		$('#btn-cancel').on('click', function(){
			clearForm();	
		});
		
		function clearForm() {
			$('#insert-first-name').val('');
			$('#insert-last-name').val('');
			$('#insert-email').val('');
			$('#insert-title').val('');
			$('input[name="cb-have-account"]').prop('checked', false);
		}
	});
</script>
</head>
<body>
<hr>
<h6>ADD EMPLOYEE</h6>
<hr>
<div class="container">
	<div class="row">
	  <div class="col-md-3">
	  <input type="hidden" id="insert-emp-id" name="insert-emp-id" />
	  	<div class="form-group">
			<input type="text" class="form-control" id="insert-first-name" placeholder="First Name">
		</div>
	  </div>
	  <div class="col-md-3">
	  	<div class="form-group">
			<input type="text" class="form-control" id="insert-last-name" placeholder="Last Name">
		</div>
	  </div>
	  <div class="col-md-3">
	  	<div class="form-group">
			<input type="text" class="form-control" id="insert-email" placeholder="Email">
		</div>
	  </div>
	  <div class="col-md-3">
	  	<div class="form-group">
		    <select name="title" id="insert-title" class="custom-select custom-select-md">
		    	<option selected>Title</option>
		    	<option value="Mr.">Mr.</option>
		    	<option value="Ms.">Ms.</option>
		    </select>
		</div>
	  </div>
	</div>
	<div class="row">
	  <div class="col-md-3">
	  	<div class="form-group">
			<button type="button" id="btn-assign-outlet" class="btn btn-primary btn-block">Assign Outlet</button>
		</div>
	  </div>
	  <div class="col-md-8" style="padding-top:8px;">
        <div class="custom-control custom-checkbox">
		  <input type="checkbox" class="custom-control-input" id="cb-have-account" name="cb-have-account" value="cbaccount">
		  <label class="custom-control-label" for="cb-have-account">Create Account?</label>
		</div>
	</div>
	  </div>
	  
	<hr>
	<div class="row" id="row-user" style="display: none">
	  <div class="col-md-3">
	  	<div class="form-group">
		    <select name="role" id="insert-role" class="custom-select custom-select-md" placeholder="Role">
		    	<option selected>Role</option>
		    	<c:forEach var="role" items="${roles }">
		    		<option value="${role.id }">${role.name }</option>
		    	</c:forEach>
		    </select>
		</div>
	  </div>
	  <div class="col-md-3">
	  	<div class="form-group">
			<input type="text" class="form-control" id="insert-user" placeholder="Username">
		</div>
	  </div>
	  <div class="col-md-3">
	  	<div class="form-group">
			<input type="text" class="form-control" id="insert-pass" placeholder="Password">
		</div>
	  </div>
	</div>
	<div class="row">
	  <div class="col-md-8">
	  </div>
	  <div class="col-md-2">
	  	<div class="form-group">
			<button type="button" id="btn-cancel" class="btn btn-primary btn-block">Cancel</button>
		</div>
	  </div>
	  <div class="col-md-2">
	  	<div class="form-group">
	  		<button type="button" id="btn-save" class="btn btn-primary btn-block">Save</button>
		</div>
	  </div>
	</div>
	Staff List
	<hr>
	<table id="dt-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead class="thead-dark" style="text-align: center;">
			<th>Name</th>
			<th>Email</th>
			<th>Have Account ?</th>
			<th>Outlet Access</th>
			<th>#</th>
		</thead>
		<tbody>
			<c:forEach items="${employees }" var="emp">
				<tr>
					<td>${emp.firstName }</td>
					<td>${emp.email }</td>
					<td><center>
						 <script type="text/javascript">
					        if( "${emp.haveAccount }" === "false" ) {
					            document.write("&times;");
					        } else {
					            document.write("&#10004;");
					        }
					    </script>
					    </center>
					</td>
					<td>${emp.email }</td>
					<td>
						<a id="${emp.id }" class="update btn btn-info btn-sm" href="#">Edit</a> |
						<a id="${emp.id }" class="btn-x btn btn-danger btn-sm" href="#">Delete</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<!-- call modal -->
<div class="modal fade" id="modal-assign-outlet" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog " role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Assign Outlet to Employee</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<form id="target">
					<input type="hidden" id="insert-outlet-id" name="insert-outlet-id" />
		        	<div id="pilih-outlet">
		        		<c:forEach var="outlet" items="${outlets }">
		        		<!-- <div class="funkyradio">
		        			<div class="funkyradio-primary"> -->
				        		<input type="checkbox" value="${outlet.id }" class="select-outlet"/>
				            	<label for="checkbox1">${outlet.name }</label>
					        <!-- </div>
					    </div> -->
		        	</c:forEach> 
		        	</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-select-outlet" class="btn btn-primary">Select</button>
			</div>
		</div>
	</div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="delete-data" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Delete Data</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<div class="form-group">
		  	<input type="hidden" class="form-control" id="delete-id" placeholder="Enter Name">
		</div>
        Change status to inactive?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
        <button type="button" id="btn-delete" class="btn btn-primary">Change</button>
      </div>
    </div>
  </div>
</div>


</body>
</html>