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
<title>Sales Order</title>
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
			/* $('#category-tbl').DataTable({
				paging : false,
				searching : false, 
			});	 */
			
			//button-create 
			$('#btn-choosecust').click(function(){
				$('#modal-choose-cust').modal(); 
			});
			
			$('.btn-create-cust').click(function(){
				$('#modal-create-cust').modal(); 
			});
			$('#btn-charge').click(function(){
				$('#modal-charge').modal(); 
			});
			$('.btn-done-order').click(function(){
				$('#modal-done-order').modal(); 
			});
		});
	//});
</script>
</head>
<body>
<div class="container">
	<div>
		<b>Sales Order</b>
	</div>
	
	<div class="form-group">	
		<div class="row show-grid">
			<div class ="col-md-6">
				<div class="col-lg-12"> 
					<input type="text" id="search" placeholder="Search" style="width:100%; margin-top: 10px; "/>
				</div>		
			</div>
			<div class="col-md-6">
				<div class="form-group" >
					<div class="col-lg-12"> 
						<button type="button" id="btn-choosecust" class="btn btn-primary" 
						style="width : 100% ; margin-top:10px; ">Choose Customer</button>
					</div>	
				</div >
				<div class="col-lg-12">
                    <div class="panel panel-default">
                                  <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                           
                                            <th>Item</th>
                                            <th>Qty</th>
                                            <th>Subtotal</th>
                                             <th>#</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td><a id="${rooms.id }" class="update btn btn-danger" href="#">X</a></td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                    	<tr>
                                    		<th>Total</th>
                                    		<th></th>
                                    		<th>Rp</th>
                                    		<th></th>
                                    	</tr>
                                    </tfoot>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <div class="form-group">
                <div class="row show-grid">
                      <div class="col-md-6">
                              <button type="button" id="btn-clear-sale" class="btn btn-primary" 
						style="width : 100% ; margin-top:10px; ">CLEAR SALE</button>
                                        </div>
                      <div class="col-md-6">
                            <button type="button" id="btn-charge" class="btn btn-primary" 
						style="width : 100% ; margin-top:10px; ">Charge Rp.0</button>
                                        </div>
                                    </div>
                                    </div>
			
			</div>
		</div>	
	</div>
	
	<!-- -----------------------------Customer Input Form ------------------------------------------- -->
	
	
	
		<!-- ---------------------------BATAS-------------------- -->
		
		
	<!-- ------------------------------BATAS---------------------------- -->
	
	
	
	<!-- ------------------------------------BATAS-------------------------- -->
	</div>
 	<!-- panggil modal dari folder modal -->
 	<%@ include file="modal/sales-order/choose-cust.jsp" %>
	<%@ include file="modal/sales-order/create-cust.jsp" %>
	<%@ include file="modal/sales-order/charge.jsp" %>
	<%@ include file="modal/sales-order/done-order.jsp" %>
</div>
</body>
</html>