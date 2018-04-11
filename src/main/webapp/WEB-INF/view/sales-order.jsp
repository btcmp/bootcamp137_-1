<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->

<script type="text/javascript">
	var customer = {};
	$(function() {
		var add = [];
		var addQty = [];
		var quantity;

		//set Data Table 

		/* $('#sod-tabel').DataTable({
			paging : true, 
			searching : false,
		}); */

		//set Date on Form Customer 
		/* $('#input-cust-dob').datepicker({
			dateFormat : "mm-dd-yyyy",
			maxDate : 20,
		});
 */
 $(function() {
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();

		if(dd<10) {
		    dd = '0'+dd
		} 
		if(mm<10) {
		    mm = '0'+mm
		} 
		today = yyyy + '-' + mm + '-' + dd;
		
		$('#input-cust-dob').daterangepicker({
	        singleDatePicker: true,
	        maxDate: new Date(today),
	        showDropdowns: true
	    });
	});
 
		$('#cust-tabel').DataTable({
			searching : false,
			paging : true,
			ordering : false,
		});

		/* ============================================================CUSTOMER======================================================= */

		$("#input-cust-phone").keyup(
				function() {
					$(this).val(
							$(this).val().replace(/^(\d{4})(\d{4})(\d{4})+$/,
									"$1-$2-$3"));
				});

		/*-------------------- Memunculkan modal choose customer---------------------  */
		$('.btn-choosecust').click(function() {
			$('#modal-choose-cust').modal();
		});

		/* -------------- Memunculkan modal Add customer ------------------- */
		$('#btn-create-cust').click(function() {
			$('#modal-create-cust').modal();
		});

		/* --------------------Eksekusi save customer ---------------- */
		$('#btn-add-cust')
				.on(
						'click',
						function(evt) {
							evt.preventDefault();
							var matriks = $('#input-cust-dob').val().split('/');
							var ready = matriks[2]+'-'+matriks[0]+'-'+matriks[1];
							var form = $('#target-create-cust');
							var valid = form.parsley().validate();
							var customer = {
								name : $('#input-cust-name').val(),
								address : $('#input-cust-address').val(),
								email : $('#input-cust-email').val(),
								phone : $('#input-cust-phone').val(),
								dob : ready,
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
							if (valid == true) {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/payment/sales-order/get-all-customer',
											type : 'GET',
											success : function(data) {
												var sameEmail = 0;
												$(data)
														.each(
																function(index,
																		data2) {
																	if (customer.email
																			.toLowerCase() == data2.email
																			.toLowerCase()) {
																		sameEmail++;
																	}
																});
												if (sameEmail > 0) {
													$('#modal-val-email').modal(); 
												} else {
													$
															.ajax({
																url : '${pageContext.request.contextPath}/payment/sales-order/save-customer',
																type : 'POST',
																contentType : 'application/json',
																data : JSON
																		.stringify(customer),
																success : function(
																		data) {
																	$(
																			'#modal-create-cust')
																			.modal(
																					'toggle');
																},
																error : function() {
																	/* $('#modal-failed').modal();  */
																	alert ('failed'); 
																}
															});
												}
											},
											error : function() {
												$('#modal-failed').modal(); 
											}
										});
							} else {
								$('#modal-alert-form').modal(); 
							}
						});

		/*---------- Search Customer By Name Customer -----------*/
		$('#btn-search-cust')
				.click(
						function() {
							var cust = $('#input-search-cust').val();
							$
									.ajax({
										url : "${pageContext.request.contextPath}/payment/sales-order/search-cust?customer="
												+ cust,
										type : 'GET',
										success : function(data) {
											isiTableSearchCustomer(data);
										},
										error : function() {
											$('#modal-failed').modal(); 
										},
										dataType : 'json'
									});
						});

		/* ------------Fungsi isi data customer dalam table -----------------*/
		function isiTableSearchCustomer(data) {
			var oTable = $('#cust-tbody');
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

			//var tbody = oTable.find("tbody");
			oTable.empty();
			oTable.append(rawData);
		}

		/*-------------- Eksekusi Btn Pilih Customer  --------------------*/
		$(document).on('click', '.btn-pilih-customer', function() {
			var id = $(this).attr('id');
			var name = $('#customer-name' + id).text();
			$('.btn-choosecust').text(name);
			$('.btn-choosecust').attr("id", id);
			console.log(id);
		});

		/*=================================================================ITEM =====================================================*/

		/* ---------------Eksekusi Btn Search Item by Item and Variant Name------------------*/
		$('#btn-search-variant')
				.click(
						function() {
							var item = $('#input-search-variant').val();
							//alert (variant); 
							$
									.ajax({
										url : "${pageContext.request.contextPath}/payment/sales-order/search-item?inventory="
												+ item,
										type : 'GET',
										success : function(data) {
											isiTableSearchItem(data);
										},
										error : function(data) {
											$('#modal-failed').modal(); 
										},
										dataType : 'json'
									});
						});

		/* ----------Fungsi untuk mengisi table search Item -----------*/
		function isiTableSearchItem(data) {
			var oTable = $('#items-table');
			var rawData = "";
			$
					.each(
							data,
							function(index, value) {
								if (addQty.indexOf(value.id) == -1) {
									rawData += "<tr>";
									rawData += "<td>";
									rawData += value[0] + " - " + value[2];
									rawData += "</td>";
									rawData += "<td>";
									rawData += "Rp.";
									rawData += "</td>";
									rawData += "<td>";
									rawData += value[3];
									rawData += "</td>";
									rawData += "<td id='td-qty "+ value[1] +"' >";
									rawData += "<input type='number' class='add-item-qty"+value[1]+"' value='1' min ='1' max='"+value[4]+"'/>";
									rawData += "</td>";
									rawData += "<td >";
									rawData += "<button type='button' id='"+value[1]+"' class='btn-add-item"+value[1]+" btn-add-item btn btn-primary btn-sm'>Add</button><button type='button' id='"+ value[1] +"' class='btn-added-item"+value[1]+" btn-added-item btn btn-primary btn-sm'>Added</button>";
									rawData += "</td>";
									rawData += "</tr>";
									var tbody = oTable.find("tbody");
									tbody.empty();
									tbody.append(rawData);
									$('.btn-added-item').hide();
								} else {
									var a = addQty.indexOf(value.id);
									rawData += "<tr>";
									rawData += "<td>";
									rawData += value[0] + " - " + value[2];
									rawData += "</td>";
									rawData += "<td>";
									rawData += "Rp.";
									rawData += "</td>";
									rawData += "<td>";
									rawData += value[3];
									rawData += "</td>";
									rawData += "<td id='td-qty "+ value[1] +"' >";
									rawData += addQty[a];
									rawData += "</td>";
									rawData += "<td >";
									rawData += "<button type='button' id='"+value[1]+"' class='btn-add-item"+value[1]+" btn-add-item btn btn-primary btn-sm'>Add</button><button type='button' id='"+ value[1] +"' class='btn-added-item"+ value[1] +" btn-added-item btn-primary btn>Added</button>";
									rawData += "</td>";
									rawData += "</tr>";
									var tbody = oTable.find("tbody");
									tbody.empty();
									tbody.append(rawData);

									$('.btn-add-item').hide();
								}
							});
		}

		/* ----------------------------------Eksekusi BTN Pilih Item -----------------------*/
		$(document)
				.on(
						'click',
						'.btn-add-item',
						function() {
							var id = $(this).attr('id');
							quantity = $('.add-item-qty' + id).val();
							console.log(quantity);
							if (quantity < 1) {
								alert("quantity < 1");
							} else {
								add.push(id);
								addQty.push(quantity);
								$('#td-qty' + id).html(quantity);
								$(this).hide();
								$('.btn-added-item' + id).show();
								$
										.ajax({
											url : "${pageContext.request.contextPath}/payment/sales-order/get-item/"
													+ id,
											type : 'GET',
											success : function(data) {
												if (add.length == "1") {
													$('#table-dso-body')
															.empty();
												}
												isiTableDetailItem(data,
														quantity);
												$('#qty' + data.id).html(
														quantity);
											},
											error : function(data) {
												$('#modal-failed').modal(); 
											},
											dataType : 'json',
										});
							}

						});

		/* ------------------Fungsi Memasukan Data ke Tabel Detail ---------------------*/
		function isiTableDetailItem(data, quantity) {
			var oTable = $('#table-dso-body');
			var tFoot = $('#table-dso-foot');
			var subTotal = quantity * data.variant.price;
			var rawData = "";
			rawData += "<tr id='tr-tbody-dso"+ data.id +"'>";
			rawData += "<td id='"+ data.variant.id +"'>";
			rawData += data.variant.item.name + "-" + data.variant.name;
			rawData += "</td>";
			rawData += "<td id='qty"+data.id+"'>";
			rawData += "";
			rawData += "</td>";
			rawData += "<td>";
			rawData += "Rp." + data.variant.price;
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

		/*-------------------------------------------------------------BTN CANCEL---------------------------------------------------------------  */
		$(document)
				.on(
						'click',
						'.btn-cancel-item',
						function() {
							var id = $(this).attr('id');
							console.log(id);
							$('#tr-tbody-dso' + id).remove();
							$('.btn-added-item' + id).hide();
							$('.btn-add-item' + id).show();
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
							$('#table-dso-foot').append(
									'<tr id="tr-total-item"><th colspan="3">TOTAL</th><th colspan="2">Rp. '
											+ total + '</th></tr>');
							$('#btn-charge').text("Charge Rp." + total)
						});
		/* ------------------------------------------------------BTN CLEAR SALE -------------------------------------------------------------- */

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
					var word = $('#btn-search').val();
				})

		/* -----------------------------------------------------BTN CHARGE------------------------------------------------------------------- */
		/* Button Charge  */
		$('#btn-charge').click(function() {
			if ($('.btn-choosecust').attr('id') == "empty") {
				alert("your customer is empty");
			} else {
				$('#modal-charge').modal();
			}
		});

		/* ---------------------------------------------------------BTN DONE ------------------------------------------------------------------- */

		/* ----------------Eksekusi Btn Done ------------------------------- */
		$('#btn-done-order')
				.on(
						'click',
						function(evt) {
							evt.preventDefault();
							
							var payment = ($('#input-payment').val()); // di inputkan 
							var total = ($('#btn-charge').text().split("Rp.")[1]);
							$('#kembalian').val("Rp." + (payment - total));
							$('#charge-cash').html("Rp." + payment);
							if (payment == 0 ){
								alert ('your payment is empty ')
							} else {
								$('#modal-done-order').modal();
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
											url : '${pageContext.request.contextPath }/payment/sales-order/save',
											type : 'POST',
											data : JSON.stringify(salesOrder),
											contentType : 'application/json',
											success : function() {
												$
														.ajax({
															url : '${pageContext.request.contextPath}/payment/sales-order/update-stock',
															type : 'PUT',
															data : JSON
																	.stringify(salesOrder),
															contentType : 'application/json',
															success : function() {

															},
															error : function() {
																alert('update stock failed');
															}
														})
											},
											error : function() {
												alert('gagal save');
											}
										})
							}
							
						});

		/* -----------------------------------------button print receipt-------------------------------------  */
		 $('#btn-print-pdf')
				.click(
						function() {
							window.location = '${pageContext.request.contextPath}/generate/sales-order';
						})
		
		$('#btn-no-thx').click(function(){
			window.location = '${pageContext.request.contextPath}/payment/sales-order'; 
		})
		/* ==================================================SELECT OPTION PROVINCE, REGION, DISTRICT ============================================== */
		/* ------------------Untuk Input Region--------------------  */
		$('#input-province')
				.change(
						function() {
							var id = $(this).val();
							if (id !== "") {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/payment/sales-order/get-region?id='
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

		/* ------------------Untuk Input Distrcit--------------------  */
		$('#input-region')
				.change(
						function() {
							var id = $(this).val();
							if (id !== "") {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/payment/sales-order/get-district?id='
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
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<h5>Sales Order</h5>
<hr>

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
		<!-- =========================================================================================================== -->
		<div class="col-md-6">
			<div class="col-lg-12">
				<button type="button" id="empty"
					class=" btn-choosecust btn btn-primary"
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
	</div>
</div>
<!-- ======================================================================================================================= -->

<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->


<!-- =============================================Call Modal================================================================ -->

<%@ include file="modal/sales-order/choose-cust.jsp"%>
<%@ include file="modal/sales-order/create-cust.jsp"%>
<%@ include file="modal/sales-order/charge.jsp"%>
<%@ include file="modal/sales-order/done-order.jsp"%>
<%@ include file="modal/modal-alert-email.jsp"%>
<%@ include file="modal/modal-alert-form.jsp"%>
<%@ include file="modal/modal-alert-failed.jsp"%>
</body>
</html>