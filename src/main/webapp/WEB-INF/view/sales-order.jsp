<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!-- taglib untuk form spring -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<link rel="stylesheet"
	href="resources/css/dataTables.bootstrap4.min.css" />
<script type="text/javascript" src="${jq }"></script>
<script type="text/javascript"
	src="<spring:url value="/resources/js/parsley.js"/>"></script>
<script type="text/javascript"
	src="<spring:url value="/resources/js/parsley.min.js"/>"></script>
<script type="text/javascript"
	src="<spring:url value="/resources/js/bootstrap.min.js"/>"></script>
<script type="text/javascript"
	src="<spring:url value="/resources/js/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript"
	src="<spring:url value="/resources/js/dataTables.bootstrap4.min.js"/>"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>

<style type="text/css">
input.parsley-error {
	color: #B94A48 !important;
	background-color: #F2DEDE !important;
	border: 1px solid #EED3D7 !important;
}
</style>

<script type="text/javascript">
	var customer = {}; 	
	$(function(){
			//setup data untuk datatable
			/* $('#cust-tabel').DataTable({
				paging : false,
				searching : false, 
			});	
			 */
			 /* Memunculkan modal */
			 //button-choose cust 
			$('.btn-choosecust').click(function(){
				$('#modal-choose-cust').modal(); 
			}); 
			
			 /* Add new customer  */
			$('#btn-create-cust').click(function(){
				$('#modal-create-cust').modal(); 
			});
			
			/* Button Charge  */
			$('#btn-charge').click(function(){
				$('#modal-charge').modal(); 
			});
			
			/* Modal Done Order  */
			$('#btn-done-order').click(function(){
				$('#modal-done-order').modal(); 
			});
			
			/* Search Customer By Name */
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
			
			/* Mengisi Table Customer Setelah di Search */
			function isiTableSearchCustomer(data){
				var oTable = $('#cust-tabel'); 
				/* oTable.empty();  */
				//console.log(data);
				var rawData = ""; 
				$.each(data, function(index, value){
					console.log(index, value); 
					rawData += "<tr>"; 
					rawData += "<td id='customer-name"+ value.id+"'>"; 
					rawData += value.name ; 
					rawData += "</td>"; 
					rawData += "<td>"; 
					rawData += value.phone ; 
					rawData += "</td>"; 
					rawData += "<td>"; 
					rawData += value.email ; 
					rawData += "</td>"; 
					rawData += "<td>"; 
					rawData += '<button type="button" id="'+ value.id +'" class="btn-pilih-customer'
					+ value.id +' btn-pilih-customer btn btn-primary"  data-dismiss="modal">Pilih</button>'; 
					/* <a href='#' class='btn-pilih btn btn-primary'>pilih</a>" ;  */
					rawData += "</td>"; 
					rawData += "</tr>";
					
				});
				
				var tbody = oTable.find("tbody");
				tbody.empty(); 
				tbody.append(rawData); 
				console.log(tbody); 
			}
			
			/* Mengeksekusi Btn Pilih Customer  */
				$(document).on('click', '.btn-pilih-customer', function(){
					//var element = $(this).parent().parent();
				/* 	var id = $(this).attr('id');  */
					//var td = element.find("td").eq(0).text(); 
					
					var id = $(this).attr('id');
					var name = $('#customer-name'+id).text();
					$('.btn-choosecust').text(name);
					$('.btn-choosecust').attr("id",id);
					
					//console.log(td); 
				/* $('#btn-choosecust').text(td);
				$('#btn-choosecust').attr("id", id);  */
					/* customer= {
						name : 	element.find("td").eq(0).text(),
						email : element.find("td").eq(1).text(),
						phone : element.find("td").eq(2).text(),
					}; */
					//alert ('yeeay'); 
					//console.log(customer); 
					console.log(id); 
				});
			
				/* Search Item */
				
				/* Untuk mengaktifkan button search variant dan menjalankan fungsi search  */
				$('#btn-search-variant').click(function() {
						var variant = $('#input-search-variant').val();
						//alert (variant); 
						$.ajax({
							url : "${pageContext.request.contextPath}/sales-order/search-variant?variant="
														+ variant,
							type : 'GET',
							success : function(data) {
													//console.log(data); 
													//window.location = '${pageContext.request.contextPath}/sales-order'; 
													isiTableSearchItem(data); 
												//	alert('success search variant');
												},
												error : function(data) {
													alert('failed search variant');
												},
												dataType : 'json'
											});
								});

				/*  Fungsi untuk mengisi table saat search */
				function isiTableSearchItem(data) {
					var oTable = $('#items-table');
					/* oTable.empty();  */
					//console.log(data);
					var rawData = "";
					$.each(data, function(index, value) {
						//console.log(index, value);
						rawData += "<tr>";
						rawData += "<td>";
						rawData += value.item.name +" - "+value.name;
						rawData += "</td>";
						rawData += "<td>"; 
						rawData += "Rp." ; 
						rawData += "</td>"; 
						rawData += "<td>"; 
						rawData += value.price; 
						rawData += "</td>"; 
						rawData += "<td id='td-qty "+ value.id +"' >"; 
						rawData += "<input type='number' class='add-item-qty"+value.id+"' value='1'/>" ; 
						rawData += "</td>"; 
						rawData += "<td >"; 
						rawData += "<button type='button' id='"+value.id+"' class='btn-add-item btn btn-primary btn-sm'>Add</a>" ; 
						rawData += "</td>";  
						rawData += "</tr>";
						//console.log("id variant : "+value.id);
					});
					var tbody = oTable.find("tbody");
					tbody.empty();
					tbody.append(rawData);
					//console.log(tbody);
					//console.log("id variant : "+value.id);
				}
				
				/* ---------------------------BATAS-------------------------- */
		var add = [];
		var addQty= [];  
		var quantity ; 
		
			/*  Eksekusi Button V Pilih Item */
		$(document).on('click', '.btn-add-item', function() {
		var id = $(this).attr('id'); 
				//	console.log(id); 
		quantity = $('.add-item-qty'+ id).val();
		console.log(quantity); 
		add.push(id); 
		addQty.push(quantity);  
		$('#td-qty'+id).html(quantity);
				$.ajax({
					url : "${pageContext.request.contextPath}/sales-order/get-item/" + id, 					
					type : 'GET',
					success : function(data) {
						//console.log(data.id); 
						//window.location = '${pageContext.request.contextPath}/sales-order'; 
						isiTableDetailItem(data, quantity); 
						$('#qty'+ data.id).html(quantity); 
						//alert('success search variant');
						
						},
					error : function(data) {
							alert('failed get variant');
										},
					dataType : 'json', 
					});
	});
	
	/*  Memasukan Data ke tabel detail */
	function isiTableDetailItem(data, quantity) {
		var oTable = $('#table-dso-body');
 	var tFoot = $('#table-dso-foot');  
		/* oTable.empty();  */
	/* 	var id = $(this).attr('id');  */
		//console.log(data);
		var subTotal = quantity * data.price; 
	var rawData = "";
			rawData += "<tr id='tr-tbody-dso"+ data.id +"'>";
			rawData += "<td id='"+ data.id +"'>";
			rawData += data.item.name +"-"+data.name;
			rawData += "</td>"; 
			rawData += "<td id='qty"+data.id+"'>"; 
			rawData += ""; 
			rawData += "</td>"; 
			rawData += "<td>"; 
			rawData += "Rp." + data.price; 
			rawData += "</td>"; 
			rawData += "<td>"; 
			rawData += "Rp." + subTotal ; 
			rawData += "</td>";  
			rawData += "<td>"; 
			rawData += "<button type='button' id='"+ data.id +"' class='btn-cancel-item"
			+ data.id +" btn-cancel-item btn btn-danger'>Cancel</button>" ; 
			rawData += "</td>";  
			rawData += "</tr>";  
		//oTable.empty();
	 	oTable.append(rawData);
		//console.log(rawData); 
		//console.log(tbody.html());  
	tFoot.empty();
	var total = 0;
	$('#table-dso-body > tr').each(function(index, data){
		var price = $(data).find('td').eq(3).text().split("Rp.")[1];
		total = total + parseInt(price);
	$('#btn-charge').text("Charge Rp."+total); 
	})
	var rawDataFoot = ""; 
		rawDataFoot += "<tr id='tr-total-item'>"; 
		rawDataFoot += "<th colspan='3'>"; 
		rawDataFoot += "TOTAL"; 
		rawDataFoot += "</th>";
		rawDataFoot += "<th colspan ='2'>";
		rawDataFoot += "Rp." + total ; 
		rawDataFoot += "</th>"; 
		rawDataFoot += "</tr>"; 
	tFoot.append(rawDataFoot); 
//	console.log(rawDataFoot);  
	} 
	 
	/* -------------------------------------------END BTN PILIH---------------------------- */
	/*-------------------------BTN CANCEL-----------------------  */
	$(document).on('click', '.btn-cancel-item', function()	
	{
		//var id = $(this).attr('id');  
		
		 var id = $(this).attr('id');
		 console.log(id); 
		$('#tr-tbody-dso'+id).remove();
/* 		$('.btn-added-item'+id).hide();
		$('.btn-add-item'+id).show();  */
		 $('#qty'+id).html('<input type="number" class="add-item-qty'+ id +'" value="1" />');
		var a = add.indexOf(id.toString());
		add.splice(a,1);
		addQty.splice(a,1);
		if (document.getElementById("table-dso-body").rows.length>0) {
			document.getElementById("btn-charge").disabled = false;
		}else {
			document.getElementById("btn-charge").disabled = true;
		}
		$('#table-dso-foot').empty();
		var total = 0;
		$('#table-dso-body > tr').each(function(index, data){
			var price = $(data).find('td').eq(3).text().split("Rp.")[1];
			total = total + parseInt(price);
		})
		$('#table-dso-body').append('<tr id="tr-total-item"><th colspan="3">TOTAL</th><th colspan="2">Rp. '+ total +'</th></tr>');
		$('#btn-charge').text("Charge Rp."+total)  
	});
	/* ---------------------------------------END BTN CANCEL ----------------------------- */
	/* -----------------------------BTN CLEAR SALE --------------------------------------- */
	
	$(document).on('click', '#btn-clear-sale', function(){
		$('#table-dso-body').empty();
		added = [];
		addedQty = [];
		$('#table-dso-foot').empty();
		$('#table-dso-foot').append('<tr id="tr-total-item"><th colspan="3">TOTAL</th><th colspan="2">Rp. '+ 0 +'</th></tr>');
		$('#btn-charge').text("Charge");
		//document.getElementById("btn-charge").disabled = true;
		var word = $('#btn-search').val();
		//input-search-variant(word);  
	})
	/* --------------------------------------END BTN CLEAR SALE ------------------------- */
	/* ------------------------START BTN DONE -------------------------------------- */
	$('#btn-done-order').on('click', function(evt){
		evt.preventDefault(); 
		var payment =($('#input-payment').val()); // di inputkan 
		var total =($('#btn-charge').text().split("Rp.")[1]); 
		//console.log(total); 
		$('#kembalian').val("Rp." + (payment-total)); 
		$('#charge-cash').html("Rp." + payment); 
		
		var salesOrderDetails = []; 
		$('#table-dso-body > tr').each(function(index, data){
			var sod= {
					variant : {
						id : $(data).find('td').eq(0).attr('id')
					}, 
					qty : $(data).find('td').eq(1).text(), 
					 unitPrice : $(data).find('td').eq(2).text().split("Rp.")[1], 
					 subTotal : $(data).find('td').eq(3).text().split("Rp.")[1]
			}
			salesOrderDetails.push(sod); 
		})
		
		var salesOrder = {
			customer : {
				id : $('.btn-choosecust').attr('id'), 
			}, 
			grandTotal : $ ('#btn-charge').text().split("Rp.")[1], 
			salesOrderDetails : salesOrderDetails
		}
		//console.log(salesOrder); 
		$.ajax({
			url : '${pageContext.request.contextPath }/sales-order/save',
			type : 'POST',
			data : JSON.stringify(salesOrder),
			contentType : 'application/json',
			success : function(){
				window.location = "${pageContext.request.contextPath}/sales-order";
			}, error : function(){
				alert('gagal save');
			}
		})
	}); 
	/* -----------------------------------BTN CUSTOMER-------------------------------------- */
/* Eksekusi btn add customer */
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
					<input type="text" id="input-search-variant" placeholder="Search" style="width:100%; margin-top: 10px; "/>
					<button type="button" id="btn-search-variant" class="btn btn-primary" 
						style="width : 100% ; margin-top:10px; ">Search</button>
				</div>
					 <div class="panel panel-default">
                                  <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table" id="items-table">
                                 <thead>
                                        <tr>
                                           <th>Item</th>
											<th></th>
											<th>Price</th>
											<th>Qty</th>
											<th>#</th>
                                        </tr>
                                    </thead>
                                    <tbody id = "body-item-tbl">
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
			</div>
			<div class="col-md-6">
				<!-- <div class="form-group" > -->
					<div class="col-lg-12"> 
						<button type="button" id="" class=" btn-choosecust btn btn-primary" 
						style="width : 100% ; margin-top:10px; ">Choose Customer</button>
						</div>	
				<!-- </div > -->
				<div class="col-lg-12">
                    <div class="panel panel-default">
                                  <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table" id = "table-detail-sales-order">
                                    <thead>
                                        <tr>
                                           		<th>Item</th>
												<th>Qty</th>
												<th>Price</th>
												<th>Subtotal</th>
												<th>#</th>
                                        </tr>
                                    </thead>
                                    <tbody id = "table-dso-body">
                                    </tbody>
                                    <tfoot id="table-dso-foot">
                                    <tr></tr>
                                </tfoot>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
               <!--  <div class="form-group"> -->
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
			
		<!-- 	</div> -->
		</div>	
	</div>
	</div>
	
 	<!-- panggil modal dari folder modal -->
 	<%@ include file="modal/sales-order/choose-cust.jsp" %>
	<%@ include file="modal/sales-order/create-cust.jsp" %>
	<%@ include file="modal/sales-order/charge.jsp" %>
	<%@ include file="modal/sales-order/done-order.jsp" %>
</body>
</html>