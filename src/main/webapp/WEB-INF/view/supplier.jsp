<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->

<script type="text/javascript">
	$(function() {
		//datatable
		$('#supplier-tbl').DataTable({
			/* paging : false, */
			searching : false,
		});

		//button-create 
		$('#btn-create').click(function() {
			$('#modal-create-supp').modal();
		});

		//btn save 
		$('#btn-save')
				.on(
						'click',
						function(evt) {
							evt.preventDefault();
							var form= $('#target'); 
							var valid = form.parsley().validate();    
							var supplier = {
								name : $('#input-supp-name').val(),
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
							
							  if (valid == true){   
								$
								.ajax({
									url : '${pageContext.request.contextPath}/supplier/save',
									type : 'POST',
									contentType : 'application/json',
									data : JSON.stringify(supplier),
									success : function(data) {
										//console.log(data); 
										window.location = "${pageContext.request.contextPath}/supplier"
										//alert('berhasil'); 
									},
									error : function() {
										alert('save failed');
									}
								});
			 				  } 
						});

		function setEditSupplier(supplier) {
			$('#edit-id').val(supplier.id);
			$('#edit-supp-name').val(supplier.name);
			$('#edit-address').val(supplier.address);
			$('#edit-phone').val(supplier.phone);
			$('#edit-email').val(supplier.email);
			$('#edit-postal-code').val(supplier.postalCode);
			$('#edit-province').val(supplier.province.id);
			$('#edit-region').val(supplier.region.id);
			$('#edit-district').val(supplier.district.id);
		}

		//btn view untuk mengedit atau update 
		$('.btn-edit')
				.click(
						function(evt) {
							evt.preventDefault();
							var id = $(this).attr('id');
							$
									.ajax({
										url : '${pageContext.request.contextPath}/supplier/get-one/'
												+ id,
										type : 'GET',
										dataType : 'json',
										success : function(supplier) {
											setEditSupplier(supplier);
											$('#modal-edit-supp').modal();
										},
										error : function() {
										}
									});
						});

		//execute btn update 
		$('#btn-save-edit')
				.on(
						'click',
						function(evt) {
							evt.preventDefault();
							var form= $('#target-edit'); 
							var valid = form.parsley().validate();
							var supplier = {
								id : $('#edit-id').val(),
								name : $('#edit-supp-name').val(),
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
							if (valid == true){
								$
								.ajax({
									url : '${pageContext.request.contextPath}/supplier/update',
									type : 'PUT',
									data : JSON.stringify(supplier),
									contentType : 'application/json',
									success : function(data) {
										window.location = '${pageContext.request.contextPath}/supplier';
									},
									error : function() {
										alert('update failed');
									}
								});
							}
						});

		$('#input-province')
				.change(
						function() {
							var id = $(this).val();
							if (id !== "") {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/supplier/get-region?id='
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
												alert('get failed');
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
											url : '${pageContext.request.contextPath}/supplier/get-district?id='
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

		$('#edit-province')
				.change(
						function() {
							var id = $('#edit-province').val();
							if (id !== "") {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/supplier/get-region?id='
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
												$('#edit-region').html(region);
											},
											error : function() {
												alert('get failed');
											}
										})
							}
						});

		$('#edit-region')
				.change(
						function() {
							var id = $('#edit-region').val();
							if (id !== "") {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/supplier/get-district?id='
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
												$('#edit-district').html(
														district);
											},
											error : function() {
												alert('get-failed');
											}
										})
							}
						});

		//button-search
		$('#btn-search')
				.on(
						'click',
						function() {
							var word = $('#search').val();
							window.location = '${pageContext.request.contextPath}/supplier/search?search='
									+ word;
						});
		
		/* $('#input-supp-name').parsley({
			required : true,
			requiredMessage : ' Code cannot be empty !!',
			minlengthMessage: ' must more than 5 character',
			typeMessage: ' must be text character',
			minlength: 5,
			type:"text"
		}); */

	});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<h5>Supplier</h5>
<hr>
<div id="save-form" style="margin-top: 20px; margin-bottom: 20px;">
	<form action="#">
		<div id="search-box" style="margin-top: 20px; margin-botton: 20px">
			<span><input type="text" id="search" placeholder="search"
				 /></span>
			<span><a id="btn-search" href="#" class="btn btn-primary">Search</a></span>
			<button type="button" id="btn-create" class="btn btn-primary"
				style="float: right; margin-right: 0px; width: 150px;">Create</button>
			<button type="button" id="btn-export" class="btn btn-primary"
				style="float: right; margin-right: 50px; width: 150px;">Export</button>
		</div>
	</form>
</div>
<table id="supplier-tbl"
	class="table table-sm table-striped table-bordered" width="100%"
	cellspacing="0">
	<thead class="thead-dark">
		<th><center>Name</center></th>
		<th><center>Address</center></th>
		<th><center>Phone</center></th>
		<th><center>Email</center></th>
		<th><center>#</center></th>
	</thead>
	<tbody>
		<c:forEach items="${suppliers}" var="supp">
			<tr>
				<td>${supp.name}</td>
				<td>${supp.address}</td>
				<td>${supp.phone}</td>
				<td>${supp.email}</td>
				<td><center>
						<a id="${supp.id }" class="btn-edit btn btn-info btn-sm" href="#">Edit</a>
					</center></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<!-- ======================================================================================================================= -->

<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->

<!-- panggil modal dari folder modal -->
<%@ include file="modal/supplier/create-supp.jsp"%>
<%@ include file="modal/supplier/edit-supp.jsp"%>

</body>
</html>