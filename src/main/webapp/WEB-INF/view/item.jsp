<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

	<%@ include file="modal/item/script.jsp" %>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

	<div>
		<b>Items</b>
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<input type="text" id="search" placeholder="Search" />
			<button type="button" id="btn-create" class="btn btn-primary" style="float:right; margin-right: 0px; width:150px;">Create</button>
			<button type="button" id="btn-export" class="btn btn-primary" style="float:right; margin-right: 50px; width: 150px;">Export</button>
			
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