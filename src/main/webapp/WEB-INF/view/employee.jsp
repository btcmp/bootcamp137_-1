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
		
		$('#cb-have-account').val('false');
		$('#cb-have-account').change(function(){
	        if(this.checked){
	            $('#row-user').fadeIn('slow');
	            $('#cb-have-account').val('true');
	        }
	        else{
	            $('#row-user').fadeOut('slow');
	            $('#cb-have-account').val('false');
	        }
	    });
		
		//save
		$('#btn-save').on('click', function(){
			
			var employee = {
				firstName : $('#insert-first-name').val(),
				lastName : $('#insert-last-name').val(),
				email : $('#insert-email').val(),
				title : $('#insert-title').val(),
				haveAccount : $('#cb-have-account').val(),
				active : 1
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
		
		//delete
		$('.delete').on('click',function(evt){
			evt.preventDefault();
			var id = $(this).attr('id');
			
			$('#btn-delete').attr('del-id', id);
			$('#delete-data').modal();
			console.log(id);
		});
		
		//eksekusi delete
		$('#btn-delete').on('click', function(){
			var id = $('#btn-delete').attr('del-id');
			console.log(id);
			$.ajax({
				url : '${pageContext.request.contextPath}/employee/delete/'+id,
				type : 'DELETE',
				success : function(data){
					window.location = '${pageContext.request.contextPath}/employee';
				},
				error : function(){
					alert('gagal');
				}
			})
		})//end delete
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
		  <input type="checkbox" class="custom-control-input" id="cb-have-account" value="cbaccount">
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
		<thead class="thead-dark">
			<th>Name</th>
			<th>Email</th>
			<th>Have Account ?</th>
			<th>#</th>
		</thead>
		<tbody>
			<c:forEach items="${employees }" var="emp">
				<tr>
					<td>${emp.firstName }</td>
					<td>${emp.email }</td>
					<td><%
						if( "${emp.haveAccount }" == "false" )
		           			 out.write("aaaaaa");
				         else {
				            out.write("&#10004");
				        }
					 %>
						
					</td>
					<td>
						<a id="${emp.id }" class="update btn btn-info btn-sm" href="#">Edit</a> |
						<a id="${emp.id }" class="delete btn btn-danger btn-sm" href="#">Delete</a>
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
				<form id="target" data-parsley-validate>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<input type="text"
							class="form-control" id="input-supp-name" aria-describedby="emailHelp" placeholder="Supplier Name">
					</div>
					<div class="form-group">
						<input type="text"
							class="form-control" id="input-address" aria-describedby="emailHelp" placeholder="Address">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-save" class="btn btn-primary">Select</button>
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