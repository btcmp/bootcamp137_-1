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
		$('#btn-export').click(function() {
			alert('yuhuu');
		})
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
											url : '${pageContext.request.contextPath}/outlet/get-all',
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
													alert('This email has been used');
												} else if (sameName > 0) {
													alert('This name has been used');
												} else {
													$
															.ajax({
																url : '${pageContext.request.contextPath}/outlet/save',
																type : 'POST',
																contentType : 'application/json',
																data : JSON
																		.stringify(outlet),
																success : function(
																		data) {
																	window.location = "${pageContext.request.contextPath}/outlet"
																},
																error : function() {
																	alert('save failed');
																}
															});
												}
											},
											error : function() {
												alert('failed');
											}
										});
							} else {
								alert('Complete your form ');
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
										url : '${pageContext.request.contextPath}/outlet/get-one/'
												+ id,
										type : 'GET',
										success : function(outlet) {
											setEditOutlet(outlet);
											$('#modal-edit-outlet').modal();
										},
										error : function() {
											alert('failed getting data update');
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
											url : '${pageContext.request.contextPath}/outlet/update',
											type : 'PUT',
											data : JSON.stringify(outlet),
											contentType : 'application/json',
											success : function(data) {
												window.location = '${pageContext.request.contextPath}/outlet';
												/* 	alert ('update berhasil');  */
											},
											error : function() {
												alert('update failed');
											}
										});
							}

							else {
								alert('Your form not valid ');
							}
						});
		$('#input-province')
				.change(
						function() {
							var id = $(this).val();
							if (id !== "") {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/outlet/get-region?id='
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
											url : '${pageContext.request.contextPath}/outlet/get-district?id='
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
											url : '${pageContext.request.contextPath}/outlet/get-region?id='
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
											url : '${pageContext.request.contextPath}/outlet/get-district?id='
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
		//untuk search 
		$('#btn-search')
				.on(
						'click',
						function() {
							var word = $('#search').val();
window.location = '${pageContext.request.contextPath}/outlet/search?search='
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
		<div id="search-box" style="margin-top: 20px; margin-botton: 20px">
			<span><input type="text" id="search" placeholder="search" /></span>
			<span><a id="btn-search" href="#" class="btn btn-primary">Search</a></span>
			<button type="button" id="btn-create" class="btn btn-primary"
				style="float: right; margin-right: 0px; width: 150px;">Create</button>
			<button type="button" id="btn-export" class="btn btn-primary"
				style="float: right; margin-right: 50px; width: 150px;">Export</button>
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
		<th><center>#</center></th>
	</thead>
	<tbody>
		<c:forEach items="${outlets}" var="outs">
			<tr>
				<td>${outs.name}</td>
				<td>${outs.address}</td>
				<td>${outs.phone}</td>
				<td>${outs.email}</td>
				<td><a id="${outs.id }" class="btn-edit btn btn-info btn-sm"
					href="#">Edit</a></td>
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
</body>
</html>