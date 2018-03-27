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
	var customer = {}; 	
	$(function(){
			//setup data untuk datatable
			/* $('#cust-tabel').DataTable({
				paging : false,
				searching : false, 
			});	
			 */
			 
			 //button-create 
			$('#btn-choosecust').click(function(){
				$('#modal-choose-cust').modal(); 
			}); 
			
			$('#btn-create-cust').click(function(){
				$('#modal-create-cust').modal(); 
			});
			
			$('#btn-charge').click(function(){
				$('#modal-charge').modal(); 
			});
			
			$('.btn-done-order').click(function(){
				$('#modal-done-order').modal(); 
			});
			
			$('#btn-search-cust').click(function(){
				var cust = $('#input-search-cust').val(); 
				//alert (cust); 
				//$('#modal-choose-cust').modal();
				$.ajax({
					url : "${pageContext.request.contextPath}/sales-order/search-cust?customer=" + cust , 
					type : 'GET', 
					success : function(data){
						//console.log();
						isiTableSearchCustomer(data); 
						//window.location = "${pageContext.request.contextPath}/sales-order/search-cust?customer=" + cust
					//	$('#modal-choose-cust'); 
					}, error : function(){
						alert ('getting failed');
					}, 
					dataType : 'json'
				}); 
			}); 
			
			function isiTableSearchCustomer(data){
				var oTable = $('#cust-tabel'); 
				/* oTable.empty();  */
				//console.log(data);
				var rawData = ""; 
				$.each(data, function(index, value){
					console.log(index, value); 
					rawData += "<tr>"; 
					rawData += "<td>"; 
					rawData += value.name ; 
					rawData += "</td>"; 
					rawData += "<td>"; 
					rawData += value.phone ; 
					rawData += "</td>"; 
					rawData += "<td>"; 
					rawData += value.email ; 
					rawData += "</td>"; 
					rawData += "<td>"; 
					rawData += "<a href='#' class='btn-pilih btn btn-primary'>pilih</a>" ; 
					rawData += "</td>"; 
					rawData += "</tr>";
					
				});
				
				var tbody = oTable.find("tbody");
				tbody.empty(); 
				tbody.append(rawData); 
				console.log(tbody); 
			}
				$(document).on('click', '.btn-pilih', function(){
					var element = $(this).parent().parent();
					var td = element.find("td").eq(0).text();  
					console.log(td); 
					$('#btn-choosecust').text(td);
					customer= {
						name : 	element.find("td").eq(0).text(),
						email : element.find("td").eq(1).text(),
						phone : element.find("td").eq(2).text(),
					};
					//alert ('yeeay'); 
					console.log(customer); 
				});
			//date 
			/* $('#input-sod').datepicker({
				dateFormat: "yy-mm-dd"
			}); */
			
			//btn save
			 $('#btn-add-cust').on('click', function(evt){
				evt.preventDefault();
			var customer = {
					name : $('#input-cust-name').val(),
					address : $('#input-cust-address').val(),  
					email : $('#input-cust-email').val(), 
					phone : $('#input-cust-phone').val(), 
					dob : $('#input-cust-dob').val(), 
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
				//console.log(customer); 
			 $.ajax({
					url : '${pageContext.request.contextPath}/sales-order/save-customer',
					type : 'POST', 
					contentType : 'application/json',
					data : JSON.stringify(customer), 
					success : function(data){
					/* 	$('#modal-create-cust').attr('hidden', 'hidden'); */
						window.location='${pageContext.request.contextPath}/sales-order'; 
						//alert ('save berhasil'); 
					},
					error : function(){
						alert('save failed'); 
					}
				});	 
			 }); 
			
			//untuk input province dan region 
			$('#input-province').change(function(){
				var id = $(this).val(); 
				if (id !==""){
					$.ajax({
						url : '${pageContext.request.contextPath}/sales-order/get-region?id=' + id, 
						type :'GET', 
						success : function(data){
							var region = []; 
							var reg = "<option value=\"\">--CHOOSE REGION--</option>";
							region.push(reg); 
							$(data).each(function(index, data2){
								reg = "<option value=\""+data2.id+"\">"+data2.name+"</option>"; 
								region.push(reg); 
							})
							$('#input-region').html(region); 
						}, error : function(){
							alert ('get-failes'); 
						}
					})	
				}
			});
			
			$('#input-region').change(function(){
				var id = $(this).val(); 
				if (id !==""){
					$.ajax({
						url : '${pageContext.request.contextPath}/sales-order/get-district?id=' + id, 
						type :'GET', 
						success : function(data){
							var district = []; 
							var dis = "<option value=\"\">--CHOOSE DISTRICT--</option>";
							district.push(dis); 
							$(data).each(function(index, data2){
								dis = "<option value=\""+data2.id+"\">"+data2.name+"</option>"; 
								district.push(dis); 
							})
							$('#input-district').html(district); 
						}, error : function(){
							alert ('get-failed'); 
						}
					})	
				}
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
					<button type="button" id="btn-search-item" class="btn btn-primary" 
						style="width : 100% ; margin-top:10px; ">Search</button>
				</div>
					 <div class="panel panel-default">
                                  <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table">
                                 <thead>
                                        <tr>
                                           
                                            <th>Item</th>
                                            <th></th>
                                            <th>Price</th>
                                             <th>#</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td><button type="button" id="btn-choose-item" class="btn btn-primary btn-info" 
						style="width : 100% ; margin-top:10px; ">V</button></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
			</div>
			<div class="col-md-6">
				<div class="form-group" >
					<div class="col-lg-12"> 
						<button type="button" id="btn-choosecust" class="btn btn-primary" 
						style="width : 100% ; margin-top:10px; ">Choose Customer</button>
						<%-- <button type="button" id="btn-choosecust" class="btn btn-primary" 
						style="width : 100% ; margin-top:10px; ">${cust.name }</button> --%>
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
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td> <button type="button" id="btn-cancel-item" class="btn btn-primary btn-danger" 
						style="width : 100% ; margin-top:10px; ">X</button>
                                        </td>
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
						style="width : 100% ; margin-top:10px; ">Clear Sale</button>
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