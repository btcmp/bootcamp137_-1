<!-- Modal create -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-create-item" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Items</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
								
						<div class="row col-md-12">
							<div class="col-md-4">
								<img src="https://www.w3schools.com/w3images/fjords.jpg" style="width: 100%;">
							</div>
							<div class="col-md-8">
								<input type="hidden" id="input-id" name="input-id" />		
								<div class="form-group">
									<input type="text" class="form-control" id="input-item-name" placeholder="Item Name">
								</div><br/>
								<div class ="form-group">
									<select data-parsley-required="true" name="countries" id="input-province" style="width: 100%; height: 35px;">
									<option value="" selected="selected">Category</option>
									<%-- <c:forEach var="loc" items= "${locations}">
										<option value="${loc.id}">${loc.streetAddress}</option>
									</c:forEach> --%>
									</select>
								</div>
							</div>
						</div>
					<div>
						<h5>Variant</h5>
						<button type="button" id="btn-add-variant" class="btn btn-primary" style="float:right; margin-right: 0px; width:150px;">Add Variant</button>
					</div><br/><br/>
					
	<table id="emp-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead class="thead-dark">
			<th>Variant Name</th>
			<th>Unit Price</th>
			<th>SKU</th>
			<th>Beginning Stock</th>
			<th>#</th>
		</thead>
		<tbody>
			<tr>
				<td>Toyota</td>
				<td><center>Rp.200000</center></td>
				<td><center>Low</center></td>
				<td><center>10</center></td>
				<td><center>
					<a id="btn-create" class="btn btn-info btn-sm" href="#">Edit</a></center>
				</td>
			</tr>
		</tbody>
	</table>
					
</form>
			</div>
			<div class="modal-footer">
				<div class="row">
					<div class="col-md-4">
						<button type="button" id="btn-cancel" class="btn btn-primary" style="width:240px;" data-dismiss="modal">Back</button>
					</div>
					<div class="col-md-4">
						<button type="button" id="btn-cancel" class="btn btn-primary" style="width:240px;" data-dismiss="modal">Cancel</button>
					</div>
					<div class="col-md-4">
						<button type="button" id="btn-cancel" class="btn btn-primary" style="width:240px;" data-dismiss="modal">Save</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- end modal-create -->


<!-- Modal- add-variant -->
	<div class="modal fade" id="modal-add-variant" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel" style="text-align: center;">Add variant</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<input type="hidden" id="input-id" name="input-id" />		
					<div class="row">
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-variant-name" placeholder="Variant Name">
						</div>
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-unit-price" placeholder="Unit Price">
						</div>
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-sku" placeholder="SKU">
						</div>			
					</div>				
					<div><br/><br/>
						<h5>Set Beginning Stock</h5>
						<hr widht="100%"/>
						</div><br/>
						<div class="row">
						<div class="form-group col-md-6">
							<input type="text" class="form-control " id="input-beginning-stock" placeholder="Beginning Stock">
						</div>
						<div class="form-group col-md-6">
							<input type="text" class="form-control " id="input-alert-at" placeholder="Alert At">
						</div>			
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-cancel" class="btn btn-primary" style="float:right; margin-right: 31px; width:150px;" data-dismiss="modal">Cancel</button>
				<button type="button" id="btn-add" class="btn btn-primary" style="float:right; margin-right: 0px; width: 150px;">Add</button>
			</div>
		</div>
	</div>
</div>

<!--End Modal- add-variant -->