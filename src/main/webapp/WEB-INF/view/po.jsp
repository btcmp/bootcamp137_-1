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
<title>Purchase Order</title>
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
		$('#btn-edit-po').on('click', function(){
			$('#modal-edit-po').modal('show');
		});
		
		
		/* view detail-po */
		$('.btn-view-po').on('click', function(){
			window.location.assign("${pageContext.request.contextPath}/po/detail-po")
		});
	});
</script>
</head>
<body>
<div class="container">
	<div>
		<b> Purchase Order</b>
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<div class=row>
				<div class="col-md-3">
					<input type="text" id="search" style="width: 84%;" placeholder="1/4/2016-3/6/2016" />
				</div>
				<div class="col-md-4">
					<select data-parsley-required="true" name="countries" id="input-province" style="width: 55%; height: 79%;"">
							<option value="" selected="selected">Status</option>
							<%-- <c:forEach var="loc" items= "${locations}">
								<option value="${loc.id}">${loc.streetAddress}</option>
							</c:forEach> --%>
					</select>
				</div>
				<div class="col-md-3">
					<input type="text" id="search" style="margin-left: -51%;" placeholder="Search" />
				</div>
				
				<div class="col-md-2">
					<button type="button" id="btn-create" class="btn btn-primary" style="width: 100%">Export</button>
				</div>
			</div>
			
		</form>
	</div>
	
	<table id="emp-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead class="thead-dark">
			<th>Create Date</th>
			<th>Supplier</th>
			<th>PO No.</th>
			<th>Total</th>
			<th>Status</th>
			<th>#</th>
		</thead>
		<tbody>
			<tr>
				<td><center>01/01/2016</center></td>
				<td>PT.Mobil Nusantara</td>
				<td>PO001</td>
				<td>Rp.200000</td>
				<td>Approve</td>
				<td><center>
					<a id="btn-edit-po" class="btn btn-info btn-sm" href="#">Edit</a>
					<a id="btn-view-po" class="btn-view-po btn btn-info btn-sm" href="#">View</a></center>
				</td>
			</tr>
			
			<tr>
				<td><center>01/02/2016</center></td>
				<td>PT.Mobil Nusantara</td>
				<td>PO002</td>
				<td>Rp.1.000.000</td>
				<td>Rejected</td>
				<td><center>
					<a id="btn-edit-po" class="btn btn-info btn-sm" href="#">Edit</a>
					<a id="btn-view-po" class=" btn-view-po btn btn-info btn-sm" href="#">View</a></center>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<!-- call modal -->
	<%@ include file="modal/purchase-order/form-edit-po.jsp" %>

</body>
</html>