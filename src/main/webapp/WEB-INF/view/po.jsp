<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<script type="text/javascript">
	jQuery(document).ready(function(){		
		$('#btn-edit-po').on('click', function(){
			$('#modal-edit-po').modal('show');
		});
		
		/* date picker*/
		$(function() {
		    $('input[name="daterange"]').daterangepicker();
		});
		
		/* view detail-po */
		$('.btn-view-po').on('click', function(){
			window.location.assign("${pageContext.request.contextPath}/po/detail-po")
		});
	});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

	<div>
		<b> Purchase Order</b>
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<div class="row">
			  <div class="col-md-3">
			  	<div class="form-group">
					<!-- <input type="text" class="form-control" id="insert-date" name="daterange" value="01/01/2018 - 01/31/2018"> -->
					<div class="input-group">
		              <div class="input-group-addon">
		                <i class="fa fa-calendar"></i>
		              </div>
		              <input type="text" class="form-control pull-right" name="daterange" id="reservation">
		            </div>
				</div>
			  </div>
			  <div class="col-md-2">
			  	<div class="form-group">
				    <select name="title" id="insert-title" class="form-control custom-select custom-select-md">
				    	<option selected>Status</option>
				    		<option value="">Submitted</option>
				    		<option value="">Approved</option>
				    		<option value="">Rejected</option>
				    </select>
				</div>
			  </div>
			  <div class="col-md-2">
			  	<div class="form-group">
					<input type="text" class="form-control" id="insert-search" placeholder="Search">
				</div>
			  </div>
			  <div class="col-md-3">
			  </div>
			  <div class="col-md-2">
			  	<div class="form-group">
					<button type="button" id="btn-export" class="btn btn-primary btn-block" style="float: right;">Export</button>
				</div>
			  </div>
			</div>
		</form>
	</div>
	
	<table id="emp-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead style="text-align: center;">
			<th>Create Date</th>
			<th>Supplier</th>
			<th>PO No.</th>
			<th>Total</th>
			<th>Status</th>
			<th>#</th>
		</thead>
		<tbody>
		<c:forEach items="${pos}" var="po">
			<tr>
				<td><center>${po.createdOn }</center></td>
				<td>${po.supplierId.name }</td>
				<td>${po.poNo }</td>
				<td>${po.grandTotal}</td>
				<td>A</td>
				<td><center>
					<a id="btn-edit-po" class="btn btn-info btn-sm" href="#">Edit</a>
					<a id="btn-view-po" class="btn-view-po btn btn-info btn-sm" href="#">View</a></center>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

<!-- ======================================================================================================================= -->
	
	<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>
	
	<!-- ======================================================================================================================= -->
	
<!-- call modal -->
	<%@ include file="modal/purchase-order/form-edit-po.jsp" %>
	
	
</body>
</html>