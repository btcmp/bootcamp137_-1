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
		$('#btn-edit-po').on('click', function(){
			$('#modal-edit-po').modal('show');
		});
		
		$('#btn-view-po').on('click', function(){
			$('#modal-detail-po').modal('show');
		});
		
	});
</script>
</head>
<body>
	<div class="container">
		<form id="target" data-parsley-validate>
		<div class="row">
				<div class="col-md-10">
					<h5>Adjustment Detail</h5>
				</div>
				<div class="col-md-2">
				<select data-parsley-required="true" class="btn-primary" name="countries" id="input-province" style="width: 100%; height:120% ">
					<option value="" >Approve</option>
					<option value="" >Reject</option>
					<option value="" >Print</option>
					<option value="" selected="selected" >More</option>
					<%-- <c:forEach var="loc" items= "${locations}">
					<option value="${loc.id}">${loc.streetAddress}</option>
					</c:forEach> --%>
				</select>
				</div>
			</div>
			<hr style="float: left; width: 83%"/><br/><br/>
						<p>Created By: Rai <br/>
							Adjustment Status : Submitted<br/>				
						</p>			
					<div>
						<h5>Notes</h5>
						<textarea rows="" cols="" style="width: 100%; height: 110px;" ></textarea>
					</div><br/>
					
					<b>Status History</b><hr/>
					On 01/01/2016 09:00 - PO001206 is Created <br/>
					On 02/01/2016 09:00 - PO001206 is Approved
					<br/><br/>
					<b>Adjustment Items</b><hr/>
			<table id="emp-table" class="" cellspacing="0" width="100%">
				<thead>
					<th>Item</th>
					<th>In Stock</th>
					<th>Qty</th>
				</thead>
				<tbody class="table-bordered">
					<tr>
						<td>Baju-Merah</td>
						<td><center>3</center></td>
						<td><center>3</center></td>
					</tr><br/>
					
				</tbody>
			</table>
			<hr/>
			<button type="button" id="btn-cancel" class="btn btn-primary" style="width: 10%; float: right;"  data-dismiss="modal">Done</button>
					
</form>
</div>

</body>
</html>