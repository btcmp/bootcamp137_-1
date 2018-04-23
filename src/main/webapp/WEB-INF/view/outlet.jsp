<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->

<script type="text/javascript">
	$(function() {
		//untuk datatable
		$('#outlet-tbl').DataTable({
			paging : true,
			searching : false,
			ordering : false
		});

		//button-create 
		$('#btn-create').click(function() {
			$('#modal-create-outlet').modal();
		});

		//button-export
		$('#btn-export')
				.click(
						function() {
							window.location = '${pageContext.request.contextPath}/generate/outlet';
						})

		$("#input-phone").keyup(
				function() {
					$(this).val(
							$(this).val().replace(/^(\d{3,4})(\d{6,8})+$/,
									"$1-$2"));
				});

		$("#edit-phone").keyup(
				function() {
					$(this).val(
							$(this).val().replace(/^(\d{3,4})(\d{6,8})+$/,
									"$1-$2"));
				});
		//btn save  
		$('#btn-save')
				.on(
						'click',
						function(evt) {
							evt.preventDefault();
							var form = $('#target');
							var valid = form.parsley().validate();
							var outlet = {
								name : $('#input-outlet-name').val(),
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
								},
								createdOn : new Date(),
								modifiedOn : new Date()
							}

							if (valid == true) {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/mst/outlet/get-all',
											type : 'GET',
											success : function(data) {
												var sameEmail = 0;
												var sameName = 0;
												$(data)
														.each(
																function(index,
																		data2) {
																	if (outlet.email
																			.toLowerCase() == data2.email
																			.toLowerCase()) {
																		sameEmail++;
																	} else if (outlet.name
																			.toLowerCase() == data2.name
																			.toLowerCase()) {
																		sameName++;
																	}
																});
												if (sameEmail > 0) {
													$('#modal-val-email')
															.modal();
												} else if (sameName > 0) {
													$('#modal-val-name')
															.modal();
												} else {
													$
															.ajax({
																url : '${pageContext.request.contextPath}/mst/outlet/save',
																type : 'POST',
																contentType : 'application/json',
																data : JSON
																		.stringify(outlet),
																success : function(
																		data) {
																	$('#div-alert-modal').fadeIn();
																	setTimeout(function() {
																		window.location = "${pageContext.request.contextPath}/mst/outlet";
																	}, 1000);
																	
																},
																error : function() {
																	$(
																			'#modal-failed')
																			.modal();
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

		$('.btn-edit')
				.on(
						'click',
						function(evt) {
							evt.preventDefault();
							var id = $(this).attr('id');
							console.log(id);
							$
									.ajax({
										url : '${pageContext.request.contextPath}/mst/outlet/get-one/'
												+ id,
										type : 'GET',
										success : function(outlet) {
											setEditOutlet(outlet);
											$('#modal-edit-outlet').modal();
										},
										error : function() {
											$('#modal-failed').modal();
										},
										dataType : 'json'
									});
						});

		//set up data update 
		function setEditOutlet(outlet) {
			$('#edit-id').val(outlet.id);
			$('#edit-outlet-name').val(outlet.name);
			$('#edit-address').val(outlet.address);
			$('#edit-postal-code').val(outlet.postalCode);
			$('#edit-phone').val(outlet.phone);
			$('#edit-email').val(outlet.email);
			$('#edit-province').val(outlet.province.id);
			$('#edit-region').val(outlet.region.id);
			$('#edit-district').val(outlet.district.id);
		}

		//execute btn update 
		$('.btn-update-outlet')
				.on(
						'click',
						function(evt) {
							evt.preventDefault();
							var form = $('#target-edit');
							var valid = form.parsley().validate();
							var outlet = {
								id : $('#edit-id').val(),
								name : $('#edit-outlet-name').val(),
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
								},
								modifiedOn : new Date()
							}
							if (valid == true) {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/mst/outlet/get-all',
											type : 'GET',
											success : function(data) {
												var sameEmail = 0;
												var sameName = 0;
												$(data)
														.each(
																function(index,
																		data2) {
																	if (outlet.id != data2.id) {
																		if (outlet.email
																				.toLowerCase() == data2.email
																				.toLowerCase()) {
																			sameEmail++;
																		} else if (outlet.name
																				.toLowerCase() == data2.name
																				.toLowerCase()) {
																			sameName++;
																		}
																	}

																});
												if (sameEmail > 0) {
													$('#modal-val-email')
															.modal();
												} else if (sameName > 0) {
													$('#modal-val-name')
															.modal();
												} else {
													$
															.ajax({
																url : '${pageContext.request.contextPath}/mst/outlet/update',
																type : 'PUT',
																data : JSON
																		.stringify(outlet),
																contentType : 'application/json',
																success : function(
																		data) {
																	$('#div-alert-modal-edit')
																	.fadeIn();
															setTimeout(function() {
																window.location = '${pageContext.request.contextPath}/mst/outlet';
															}, 1000);
																	
																	/* 	alert ('update berhasil');  */
																},
																error : function() {
																	$(
																			'#modal-failed')
																			.modal();
																}
															});
												}
												
											},
											error : function() {
												$('#modal-failed').modal();
											}
										});
							}

							else {
								$('#modal-alert-form').modal();
							}
						});
		$('#input-province')
				.change(
						function() {
							var id = $(this).val();
							if (id !== "") {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/mst/outlet/get-region?id='
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
												$('#modal-failed').modal();
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
											url : '${pageContext.request.contextPath}/mst/outlet/get-district?id='
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
												$('#modal-failed').modal();
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
											url : '${pageContext.request.contextPath}/mst/outlet/get-region?id='
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
												$('#modal-failed').modal();
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
											url : '${pageContext.request.contextPath}/mst/outlet/get-district?id='
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
												$('#modal-failed').modal();
											}
										})
							}
						});
		//untuk search 
		$('#btn-search')
				.on(
						'click',
						function() {
							var word = $('#search').val();
							window.location = '${pageContext.request.contextPath}/mst/outlet/search?search='
									+ word;
						});
	});
	//});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<h5>Outlet</h5>
<hr>
<div id="save-form" style="margin-top: 20px; margin-bottom: 20px;">
	<form action="#">
		<div class="row">
			<div class="col-md-3">
				<div class="form-group">
					<!--   <div id="search-box" style="margin-top: 20px; margin-botton: 20px"> -->
					<input type="text" id="search" placeholder="search"
						class="form-control" />
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group ">
					<button type="button" id="btn-search" class="btn btn-success">Search</button>
					<!-- <a id="btn-search" href="#" class="btn btn-success">Search</a></span> -->
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<button type="button" id="btn-export"
						class="btn btn-success btn-block">Export</button>
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<button type="button" id="btn-create"
						class="adm-show btn btn-success btn-block">Create</button>
				</div>
			</div>

		</div>
	</form>
</div>

<table id="outlet-tbl"
	class="table table-sm table-striped table-bordered" width="100%"
	cellspacing="0">
	<thead class="thead-dark">
		<th><center>Name</center></th>
		<th><center>Address</center></th>
		<th><center>Phone</center></th>
		<th><center>Email</center></th>
		<th class="adm-show"><center>#</center></th>
	</thead>
	<tbody>
		<c:forEach items="${outlets}" var="outs">
			<tr>
				<td>${outs.name}</td>
				<td>${outs.address}</td>
				<td>${outs.phone}</td>
				<td>${outs.email}</td>
				<td class="adm-show"><a id="${outs.id }"
					class="btn-edit btn btn-info btn-sm" href="#">Edit</a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!-- ======================================================================================================================= -->

<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->

<!-- panggil modal dari folder modal -->
<%@ include file="modal/outlet/create-outlet.jsp"%>
<%@ include file="modal/outlet/edit-outlet.jsp"%>
<%@ include file="modal/modal-alert-email.jsp"%>
<%@ include file="modal/modal-alert-name.jsp"%>
<%@ include file="modal/modal-alert-form.jsp"%>
<%@ include file="modal/modal-alert-failed.jsp"%>
</body>
</html>