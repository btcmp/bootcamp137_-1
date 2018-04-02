<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->

<script type="text/javascript">
	var customer = {};
	$(function() {
		//setup data untuk datatable
		$('#sod-tabel').DataTable({
			paging : true, 
			searching : false,
		});

		/* Memunculkan modal */
		//button-choose cust 
		$('.btn-choosecust').click(function() {
			$('#modal-choose-cust').modal();
		});

		/* Add new customer  */
		$('#btn-create-cust').click(function() {
			$('#modal-create-cust').modal();
		});

		/* Button Charge  */
		$('#btn-charge').click(function() {
			if ($('.btn-choosecust').attr('id')=="empty") {
				alert("your customer is empty");
			}else {
				$('#modal-charge').modal();
			}	
		});

		/* Modal Done Order  */
		$('#btn-done-order').click(function() {
			$('#modal-done-order').modal();
		});
		
		/* -----------------------------------BTN CUSTOMER-------------------------------------- */
		/* Eksekusi btn add customer */
		//btn save
		$('#btn-add-cust').on('click',function(evt) {
							evt.preventDefault();
							var form = $('#target-create-cust');
							var valid = form.parsley().validate();
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
								}, 
								active : true
							}
							if ( valid == true ){
								 $.ajax({
									url : '${pageContext.request.contextPath}/sales-order/get-all-customer', 
									type :'GET', 
									success : function (data){
											var sameEmail = 0; 
											$(data).each(function(index, data2){
												if ( customer.email.toLowerCase() == data2.email.toLowerCase()){
													sameEmail ++ ; 
												} 
											}); 
											 if ( sameEmail > 0){
												alert ('This email has been used'); 
											} 
											else {
												$.ajax({
													url : '${pageContext.request.contextPath}/sales-order/save-customer',
													type : 'POST',
													contentType : 'application/json',
													data : JSON.stringify(customer),
													success : function(data) {
														//window.location = '${pageContext.request.contextPath}/sales-order';
														/* var word = $('#btn-search-cust').val(); 
														var cust = $('#input-search-cust').val();  */
														 $('#modal-create-cust').modal('toggle');
													},
													error : function() {
														alert('save new customer failed');
													}
												});	
											}  
									}, 
									error : function (){
										alert ('failed'); 
									}
								 }); 
							} 
							else {
								alert ('Complete your form '); 
							}
			});

		
		
		/* Search Customer By Name */
		$('#btn-search-cust')
				.click(
						function() {
							var cust = $('#input-search-cust').val();
							$
									.ajax({
										url : "${pageContext.request.contextPath}/sales-order/search-cust?customer="
												+ cust,
										type : 'GET',
										success : function(data) {
											isiTableSearchCustomer(data); 
										},
										error : function() {
											alert('getting failed');
										},
										dataType : 'json'
									});
						});

		/* Mengisi Table Customer Setelah di Search */
		function isiTableSearchCustomer(data) {
			var oTable = $('#cust-tabel');
			var rawData = "";
			$
					.each(
							data,
							function(index, value) {
								console.log(index, value);
								rawData += "<tr>";
								rawData += "<td id='customer-name"+ value.id+"'>";
								rawData += value.name;
								rawData += "</td>";
								rawData += "<td>";
								rawData += value.phone;
								rawData += "</td>";
								rawData += "<td>";
								rawData += value.email;
								rawData += "</td>";
								rawData += "<td>";
								rawData += '<button type="button" id="'+ value.id +'" class="btn-pilih-customer'
					+ value.id +' btn-pilih-customer btn btn-primary"  data-dismiss="modal">Pilih</button>';
								rawData += "</td>";
								rawData += "</tr>";

							});

			var tbody = oTable.find("tbody");
			tbody.empty();
			tbody.append(rawData);
			console.log(tbody);
		}

		/* Mengeksekusi Btn Pilih Customer  */
		$(document).on('click', '.btn-pilih-customer', function() {
			var id = $(this).attr('id');
			var name = $('#customer-name' + id).text();
			$('.btn-choosecust').text(name);
			$('.btn-choosecust').attr("id", id);
			console.log(id);
		});

		/* Search Item */

		/* Untuk mengaktifkan button search variant dan menjalankan fungsi search  */
		$('#btn-search-variant')
				.click(
						function() {
							var variant = $('#input-search-variant').val();
							//alert (variant); 
							$
									.ajax({
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
			var rawData = "";
			$
					.each(
							data,
							function(index, value) {
								rawData += "<tr>";
								rawData += "<td>";
								rawData += value.item.name + " - " + value.name;
								rawData += "</td>";
								rawData += "<td>";
								rawData += "Rp.";
								rawData += "</td>";
								rawData += "<td>";
								rawData += value.price;
								rawData += "</td>";
								rawData += "<td id='td-qty "+ value.id +"' >";
								rawData += "<input type='number' class='add-item-qty"+value.id+"' value='1'/>";
								rawData += "</td>";
								rawData += "<td >";
								rawData += "<button type='button' id='"+value.id+"' class='btn-add-item btn btn-primary btn-sm'>Add</a>";
								rawData += "</td>";
								rawData += "</tr>";
							});
			var tbody = oTable.find("tbody");
			tbody.empty();
			tbody.append(rawData);
		}

		/* ---------------------------BATAS-------------------------- */
		var add = [];
		var addQty = [];
		var quantity;

		/*  Eksekusi Button V Pilih Item */
		$(document)
				.on(
						'click',
						'.btn-add-item',
						function() {
							var id = $(this).attr('id');
							//	console.log(id); 
							quantity = $('.add-item-qty' + id).val();
							console.log(quantity);
							add.push(id);
							addQty.push(quantity);
							$('#td-qty' + id).html(quantity);
							$
									.ajax({
										url : "${pageContext.request.contextPath}/sales-order/get-item/"
												+ id,
										type : 'GET',
										success : function(data) {
											//console.log(data.id); 
											isiTableDetailItem(data, quantity);
											$('#qty' + data.id).html(quantity);
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
			rawData += data.item.name + "-" + data.name;
			rawData += "</td>";
			rawData += "<td id='qty"+data.id+"'>";
			rawData += "";
			rawData += "</td>";
			rawData += "<td>";
			rawData += "Rp." + data.price;
			rawData += "</td>";
			rawData += "<td>";
			rawData += "Rp." + subTotal;
			rawData += "</td>";
			rawData += "<td>";
			rawData += "<button type='button' id='"+ data.id +"' class='btn-cancel-item"
			+ data.id +" btn-cancel-item btn btn-danger'>Cancel</button>";
			rawData += "</td>";
			rawData += "</tr>";
			oTable.append(rawData);
			tFoot.empty();
			var total = 0;
			$('#table-dso-body > tr').each(function(index, data) {
				var price = $(data).find('td').eq(3).text().split("Rp.")[1];
				total = total + parseInt(price);
				$('#btn-charge').text("Charge Rp." + total);
			})
			var rawDataFoot = "";
			rawDataFoot += "<tr id='tr-total-item'>";
			rawDataFoot += "<th colspan='3'>";
			rawDataFoot += "TOTAL";
			rawDataFoot += "</th>";
			rawDataFoot += "<th colspan ='2'>";
			rawDataFoot += "Rp." + total;
			rawDataFoot += "</th>";
			rawDataFoot += "</tr>";
			tFoot.append(rawDataFoot);
		}

		/* -------------------------------------------END BTN PILIH---------------------------- */
		/*-------------------------BTN CANCEL-----------------------  */
		$(document)
				.on(
						'click',
						'.btn-cancel-item',
						function() {

							var id = $(this).attr('id');
							console.log(id);
							$('#tr-tbody-dso' + id).remove();
							$('#qty' + id)
									.html(
											'<input type="number" class="add-item-qty'+ id +'" value="1" />');
							var a = add.indexOf(id.toString());
							add.splice(a, 1);
							addQty.splice(a, 1);
							if (document.getElementById("table-dso-body").rows.length > 0) {
								document.getElementById("btn-charge").disabled = false;
							} else {
								document.getElementById("btn-charge").disabled = true;
							}
							$('#table-dso-foot').empty();
							var total = 0;
							$('#table-dso-body > tr').each(
									function(index, data) {
										var price = $(data).find('td').eq(3)
												.text().split("Rp.")[1];
										total = total + parseInt(price);
									})
							$('#table-dso-body').append(
									'<tr id="tr-total-item"><th colspan="3">TOTAL</th><th colspan="2">Rp. '
											+ total + '</th></tr>');
							$('#btn-charge').text("Charge Rp." + total)
						});
		/* ---------------------------------------END BTN CANCEL ----------------------------- */
		/* -----------------------------BTN CLEAR SALE --------------------------------------- */

		$(document).on(
				'click',
				'#btn-clear-sale',
				function() {
					$('#table-dso-body').empty();
					added = [];
					addedQty = [];
					$('#table-dso-foot').empty();
					$('#table-dso-foot').append(
							'<tr id="tr-total-item"><th colspan="3">TOTAL</th><th colspan="2">Rp. '
									+ 0 + '</th></tr>');
					$('#btn-charge').text("Charge");
					//document.getElementById("btn-charge").disabled = true;
					var word = $('#btn-search').val();
					//input-search-variant(word);  
				})
		/* --------------------------------------END BTN CLEAR SALE ------------------------- */
		/* ------------------------START BTN DONE -------------------------------------- */
		$('#btn-done-order')
				.on(
						'click',
						function(evt) {
							evt.preventDefault();
							var payment = ($('#input-payment').val()); // di inputkan 
							var total = ($('#btn-charge').text().split("Rp.")[1]);
							$('#kembalian').val("Rp." + (payment - total));
							$('#charge-cash').html("Rp." + payment);

							var salesOrderDetails = [];
							$('#table-dso-body > tr')
									.each(
											function(index, data) {
												var sod = {
													variant : {
														id : $(data).find('td')
																.eq(0).attr(
																		'id')
													},
													qty : $(data).find('td')
															.eq(1).text(),
													unitPrice : $(data).find(
															'td').eq(2).text()
															.split("Rp.")[1],
													subTotal : $(data).find(
															'td').eq(3).text()
															.split("Rp.")[1]
												}
												salesOrderDetails.push(sod);
											})

							var salesOrder = {
								customer : {
									id : $('.btn-choosecust').attr('id'),
								},
								grandTotal : $('#btn-charge').text().split(
										"Rp.")[1],
								salesOrderDetails : salesOrderDetails
							}
							$
									.ajax({
										url : '${pageContext.request.contextPath }/sales-order/save',
										type : 'POST',
										data : JSON.stringify(salesOrder),
										contentType : 'application/json',
										success : function() {
											window.location = "${pageContext.request.contextPath}/sales-order";
										},
										error : function() {
											alert('gagal save');
										}
									})
						});
		//untuk input province dan region 
		$('#input-province')
				.change(
						function() {
							var id = $(this).val();
							if (id !== "") {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/sales-order/get-region?id='
													+ id,
											type : 'GET',
											success : function(data) {
												var region = [];
												var reg = "<option value=\"\">CHOOSE REGION</option>";
												region.push(reg);
												$(data)
														.each(
																function(index,
																		data2) {
																	reg = "<option value=\""+data2.id+"\">"
																			+ data2.name
																			+ "</option>";
																	region
																			.push(reg);
																})
												$('#input-region').html(region);
											},
											error : function() {
												alert('get-failes');
											}
										})
							}
						});

		$('#input-region')
				.change(
						function() {
							var id = $(this).val();
							if (id !== "") {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/sales-order/get-district?id='
													+ id,
											type : 'GET',
											success : function(data) {
												var district = [];
												var dis = "<option value=\"\">CHOOSE DISTRICT</option>";
												district.push(dis);
												$(data)
														.each(
																function(index,
																		data2) {
																	dis = "<option value=\""+data2.id+"\">"
																			+ data2.name
																			+ "</option>";
																	district
																			.push(dis);
																})
												$('#input-district').html(
														district);
											},
											error : function() {
												alert('get-failed');
											}
										})
							}
						});

	});
	//});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<div>
	<b>Sales Order</b>
</div>

<div class="form-group">
	<div class="row show-grid">
		<div class="col-md-6">
			<div class="col-lg-12">
				<input type="text" id="input-search-variant" placeholder="Search"
					style="width: 100%; margin-top: 10px;" />
				<button type="button" id="btn-search-variant"
					class="btn btn-primary"
					style="width: 100%; margin-top: 10px; margin-bottom: 10px;">Search</button>
			</div>
			<div class="col-lg-12">
				<table class="table table-sm table-striped table-bordered"
					id="items-table" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th>Item</th>
							<th></th>
							<th>Price</th>
							<th>Qty</th>
							<th>#</th>
						</tr>
					</thead>
					<tbody id="body-item-tbl">
					</tbody>
				</table>
			</div>
		</div>
		<div class="col-md-6">
			<div class="col-lg-12">
				<button type="button" id="empty" class=" btn-choosecust btn btn-primary"
					style="width: 100%; margin-top: 10px; margin-bottom: 10px;">Choose
					Customer</button>
			</div>
			<div class="col-lg-12">
				<table class="table table-sm table-striped table-bordered"
					id="table-detail-sales-order" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th>Item</th>
							<th>Qty</th>
							<th>Price</th>
							<th>Subtotal</th>
							<th>#</th>
						</tr>
					</thead>
					<tbody id="table-dso-body">
					</tbody>
					<tfoot id="table-dso-foot">
						<tr></tr>
					</tfoot>
				</table>
			</div>
			<div class="row show-grid">
				<div class="col-lg-12">
					<div class="col-md-6">
						<button type="button" id="btn-clear-sale" class="btn btn-primary"
							style="width: 100%; margin-top: 10px;">Clear Sale</button>
					</div>
					<div class="col-md-6">
						<button type="button" id="btn-charge" class="btn btn-primary"
							style="width: 100%; margin-top: 10px;">Charge Rp.0</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 	</div> -->
	</div>
</div>
<!-- ======================================================================================================================= -->

<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->


<!-- panggil modal dari folder modal -->
<%@ include file="modal/sales-order/choose-cust.jsp"%>
<%@ include file="modal/sales-order/create-cust.jsp"%>
<%@ include file="modal/sales-order/charge.jsp"%>
<%@ include file="modal/sales-order/done-order.jsp"%>
</body>
</html>