<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

	<%@ include file="modal/item/script-item-outlet.jsp" %>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->
 
	<div>
		<b>Items</b>
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<div class="row">
				<div class="col-md-5">
				  	<div class="form-group col-md-6">
							<input type="text" class="form-control" id="insert-search" placeholder="Search">
				 	 </div>
				 	 <div class="form-group col-md-6">
				 	 	 <select name="title" id="list-by-outlet" class="form-control custom-select custom-select-md">
						    	<option value="">from All Outlet</option>
						    	<c:forEach items= "${outlet}" var="outlet">
									<option value="${outlet.id}">${outlet.name}</option>
								</c:forEach>
						  </select>
				 	 </div>
				  	
				</div>
				<div class="col-md-1">
				</div>
				<div class="col-md-3">
		 		  	<div class="form-group">
						<button type="button" id="btn-export" class="btn btn-primary btn-block">Export</button>
					</div>
				</div>
				<div class="col-md-3">
				  	<div class="form-group">
					    <button type="button" id="btn-create" class="btn btn-primary btn-block">Create</button>
					</div>
		  		</div>
			</div>	
		</form>
	</div>
	
	<table id="item-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead class="thead-dark" style="text-align: center;">
			<th>Name</th>
			<th>Category</th>
			<th>Unit Price</th>
			<th>In Stock</th>
			<th>Stock Alert</th>
			<th>#</th>
		</thead>
		<tbody class="tbody-item-list">
			 <c:forEach items="${inventories}" var="inv">
				 <tr>
				<td>${inv.variant.item.name} - ${inv.variant.name} </td>
				<td><center>${inv.variant.item.categoryId.name }</center></td>
				<td><center>Rp. ${inv.variant.price}</center></td>
				<td><center>${inv.beginning }</center></td>
				<td><center>${inv.variant.sku }</center></td>
				<td><center>
					<a id="${inv.variant.item.id}" class="btn-item-edit btn btn-info btn-sm" href="#">Edit</a></center>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>


<!-- ======================================================================================================================= -->
	
	<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>
	
	<!-- ======================================================================================================================= -->
<!-- call modal -->
	<%@ include file="modal/item/create-edit-item.jsp" %>

	
</body>
</html>