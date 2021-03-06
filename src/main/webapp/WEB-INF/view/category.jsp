<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->

<script type="text/javascript">
	$(function() {
		//setup data untuk datatable
		$('#category-tbl').DataTable({
			/* 	paging : false, */
			searching : false,
			ordering : false
		});

		//button-create 
		$('#btn-create').click(function() {
			$('#modal-create-category').modal();
		});

		//button export 
		$('#btn-export')
				.click(
						function() {
							window.location = '${pageContext.request.contextPath}/generate/category';
						});
		//untuk ngesave 
		$('#btn-save-cat')
				.on(
						'click',
						function(evt) {
							evt.preventDefault();
							var form = $('#target');
							var valid = form.parsley().validate();
							var category = {
								name : $('#input-category-name').val(),
								modifiedOn : new Date()
							}
							if (valid == true) {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/mst/category/get-all',
											type : 'GET',
											success : function(data) {
												var sameName = 0;
												$(data)
														.each(
																function(index,
																		data2) {
																	if (category.name
																			.toLowerCase() == data2.name
																			.toLowerCase()) {
																		sameName++;
																	}
																});
												if (sameName > 0) {
													$('#modal-val-name')
															.modal();
												} else {
													$
															.ajax({
																url : '${pageContext.request.contextPath}/mst/category/save',
																type : 'POST',
																contentType : 'application/json',
																data : JSON
																		.stringify(category),
																success : function(
																		data) {
																	$('#div-alert-modal').fadeIn();
																	setTimeout(function(){
																		window.location = '${pageContext.request.contextPath}/mst/category';
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

		//btn view untuk mengedit atau update 
		$('.btn-view')
				.click(
						function(evt) {
							evt.preventDefault();
							var id = $(this).attr('id');
							$
									.ajax({
										url : '${pageContext.request.contextPath}/mst/category/get-one/'
												+ id,
										type : 'GET',
										success : function(category) {
											setEditCategory(category);
											$('#modal-edit-category').modal();
										},
										error : function() {
											$('#modal-failed').modal();
										},
										dataType : 'json'
									});
						});
		function setEditCategory(category) {
			$('#edit-id').val(category.id);
			$('#edit-category-name').val(category.name);
		}
		;

		//execute btn update 
		$('#btn-save-edit')
				.click(
						function() {
							var form = $('#target-edit');
							var valid = form.parsley().validate();
							var category = {
								id : $('#edit-id').val(),
								name : $('#edit-category-name').val(),
								modifiedOn : new Date()
							}
							if (valid == true) {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/mst/category/get-all',
											type : 'GET',
											success : function(data) {
												var sameName = 0;
												$(data)
														.each(
																function(index,
																		data2) {
																	if (category.id != data2.id) {
																		if (category.name
																				.toLowerCase() == data2.name
																				.toLowerCase()) {
																			sameName++;
																		}
																	}

																});
												if (sameName > 0) {
													$('#modal-val-name')
															.modal();
												} else {
													$
															.ajax({
																url : '${pageContext.request.contextPath}/mst/category/update',
																type : 'PUT',
																data : JSON
																		.stringify(category),
																contentType : 'application/json',
																success : function(
																		data) {
																	
																	$('#div-alert-modal-edit').fadeIn();
																	setTimeout(function(){
																		window.location = '${pageContext.request.contextPath}/mst/category';
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

		//btn-X
		$('#btn-X')
				.click(
						function() {
							var category = {
								id : $('#edit-id').val(),
								name : $('#edit-category-name').val(),
							}
							$
									.ajax({
										url : '${pageContext.request.contextPath}/mst/category/update-status',
										type : 'PUT',
										data : JSON.stringify(category),
										contentType : 'application/json',
										success : function(data) {
											window.location = '${pageContext.request.contextPath}/mst/category';
										},
										error : function() {
											$('#modal-failed').modal();
										}
									});
						});

		//button searchh 
		$('#btn-search')
				.click(
						function() {
							var word = $('#search').val();
							window.location = '${pageContext.request.contextPath}/mst/category/search?search='
									+ word;
						});
	});
</script>


<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<h5>Category</h5>
<hr>
<div id="save-form" style="margin-top: 20px; margin-bottom: 20px;">
	<form action="#">
		<!-- <div id="search-box" style="margin-top: 20px; margin-botton: 20px">
			<span><input type="text" id="search" placeholder="search" /></span>
			<span><a id="btn-search" href="#" class="btn btn-primary">Search</a></span>
			<button type="button" id="btn-create"
				class="adm-show btn btn-primary"
				style="float: right; margin-right: 0px; width: 150px;">Create</button>
			<button type="button" id="btn-export" class="btn btn-primary"
				style="float: right; margin-right: 50px; width: 150px;">Export</button>
		</div> -->
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
<table id="category-tbl"
	class="table table-sm table-striped table-bordered" width="100%"
	cellspacing="0">
	<thead class="thead-dark">
		<th><center>Category Name</center></th>
		<th><center>Items Stock</center></th>
		<!-- <th><center>#</center></th> -->
		<th class="adm-show"><center>#</center></th>
	</thead>
	<tbody>
		<c:forEach items="${categories}" var="ctg">
			<tr>
				<td>${ctg.name}</td>
				<td>${ ctg.itemStock}</td>
				<td class="adm-show"><center>
						<a id="${ctg.id }" class="btn-view btn btn-info" href="#">View</a>
					</center></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<!-- ======================================================================================================================= -->

<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->

<!-- panggil modal dari folder modal -->
<%@ include file="modal/category/create-category.jsp"%>
<%@ include file="modal/category/edit-category.jsp"%>
<%@ include file="modal/modal-alert-name.jsp"%>
<%@ include file="modal/modal-alert-form.jsp"%>
<%@ include file="modal/modal-alert-failed.jsp"%>
</body>
</html>
