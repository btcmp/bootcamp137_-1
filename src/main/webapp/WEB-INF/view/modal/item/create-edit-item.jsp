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
								<input type='file' onchange="readURL(this);" />
								<img id="blah" src="" alt="your image" style="max-width: 100%"/>
							</div>
			 				<div class="col-md-8">
								<input type="hidden" id="input-item-id"/>		
								<div class="form-group">
									<input type="text" class="form-control" id="input-item-name" 
									 placeholder="Item Name"aria-describedby="emailHelp" pattern="([A-z0-9\s]){2,50}$">
									<p style = "color : red;"><small>*Required</small></p>
								</div><br/>
								<div class ="form-group">
									<select id="input-item-category" style="width: 100%; height: 35px;">
									<option value="" selected="selected">Category</option>
									<c:forEach items= "${categories}" var="ctg">
										<option value=${ctg.id}>${ctg.name}</option>
									</c:forEach>
									</select>
								</div>
							</div>
						</div><br/>
					<div class="row">
						<div class="col-md-9"><h5>Variant</h5></div>
						<div class="col-md-3">
							<button type="button" id="btn-add-variant" class="btn btn-primary" style="float:right; margin-right: 0px; width:150px;">Add Variant</button>
						</div>
					</div><br/>
					
	<table id="variant-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead class="thead-dark">
			<th>Variant Name</th>
			<th>Unit Price</th>
			<th>SKU</th>
			<th>Beginning Stock</th>
			<th style="display: none;">alert Stock</th>
			<th style="display: none;">ending Quantity</th>
			<th style="display: none;">Outlet</th>
			<th>#</th>
		</thead>
		<tbody id="tbody-add-variant-create-item"></tbody>
	</table>
					
</form>
			</div>
			<div class="modal-footer row">
				
					<div class="col-md-4" style="margin: auto;">
						<button type="button" id="btn-cancel" class="btn btn-primary" style="width:100%;" data-dismiss="modal">Back</button>
					</div>
					<div class="col-md-4" style="margin: auto;">
						<button type="button" id="btn-cancel" class="btn btn-primary" style="width:100%;" data-dismiss="modal">Cancel</button>
					</div>
					<div class="col-md-4" style="margin: auto;">
						<button type="button" id="btn-save" class="btn btn-primary" style="width:100%;" href="#">Save</button>
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
					<input type="hidden" id="input-varian-id" name="input-id" />		
					<div class="row">
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-variant-name" placeholder="Variant Name"
							 aria-describedby="emailHelp" data-parsley-length="[4,20]" data-parsley-group="block1">
							
						</div>
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-variant-price" placeholder="Unit Price"
							pattern="^\d{3,4}-\d{6,8}$" aria-describedby="emailHelp">
							<p style = "color : red;"><small> *number only, ex : 500000 </small></p>
						</div>
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-variant-sku" placeholder="SKU">
						</div>			
					</div>				
					<div><br/><br/>
						<div class="row">
							<div class="col-md-3">
								<h5>Set Beginning Stock</h5>
							</div>
							<div class="form-group col-md-3">
						   	 <select name="title" id="input-outlet" class="form-control custom-select custom-select-md">
						    	<option value="">Outlet</option>
						    	<c:forEach items= "${outlet}" var="outlet">
									<option value="${outlet.id}">${outlet.name}</option>
								</c:forEach>
						    </select>
							</div>
						</div>
						<hr widht="100%"/>
						</div><br/>
						<div class="row" style="display: none" id="inventory-store">
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
				<button type="button" id="btn-add-item-variant" class="btn btn-primary" style="float:right; margin-right: 0px; width: 30%;">Add</button>
				<button type="button" id="btn-cancel-add" class="btn btn-primary" style="float:right; margin-right: 31px; width:30%;" data-dismiss="modal">Cancel</button>
			</div>
		</div>
	</div>
</div>

<!--End Modal- add-variant -->

<!-- Modal- add-edit-variant -->
	<div class="modal fade" id="modal-add-edit-variant" tabindex="-1" role="dialog"
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
					<input type="hidden" id="input-edit-edit-varian-id" name="input-id" />		
					<div class="row">
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-edit-variant-name" placeholder="Variant Name">
						</div>
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-edit-variant-price" placeholder="Unit Price">
						</div>
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-edit-variant-sku" placeholder="SKU">
						</div>			
					</div>				
					<div><br/><br/>
						<div class="row">
							<div class="col-md-3">
								<h5>Set Beginning Stock</h5>
							</div>
							<div class="form-group col-md-3">
						   	 <select name="title" id="input-edit-outlet" class="form-control custom-select custom-select-md">
						    	<option value="">Outlet</option>
						    	<c:forEach items= "${outlet}" var="outlet">
									<option value="${outlet.id}">${outlet.name}</option>
								</c:forEach>
						    </select>
							</div>
						</div>
						<hr widht="100%"/>
						</div><br/>
						<div class="row">
						<div class="form-group col-md-6">
							<input type="text" class="form-control " id="input-edit-beginning-stock" placeholder="Beginning Stock">
						</div>
						<div class="form-group col-md-6">
							<input type="text" class="form-control " id="input-edit-alert-at" placeholder="Alert At">
						</div>			
					</div>	
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-edit-cancel-add" class="btn btn-primary" style="float:right; margin-right: 31px; width:150px;" data-dismiss="modal">Cancel</button>
				<button type="button" id="" class="btn-add-edit-update-variant btn btn-primary" style="float:right; margin-right: 0px; width: 150px;">Update</button>
			</div>
		</div>
	</div>
</div>

<!--End Modal- add-edit-variant -->


<!--===========================================================================================================================  -->


<!-- Modal edit items -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-edit-item" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Edit Items</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="target" data-parsley-validate>
								
						<div class="row col-md-12">
							<div class="col-md-4">
								<img id="image-item" src="https://www.w3schools.com/w3images/fjords.jpg" style="width: 100%;">
							</div>
							<div class="col-md-8">
								<input type="hidden" id="edit-item-id" name="input-id" />		
								<div class="form-group">
									<input type="text" class="form-control" id="edit-item-name" placeholder="Item Name">
								</div><br/>
								<div class ="form-group">
									<select id="edit-item-category" style="width: 100%; height: 35px;">
									<c:forEach items= "${categories}" var="ctg">
										<option value="${ctg.id}">${ctg.name}</option>
									</c:forEach>
									</select>
								</div>
							</div>
						</div><br/>
					<div class="row">
						<div class="col-md-9"><h5>Variant</h5></div>
						<div class="col-md-3">
							<button type="button" id="btn-edit-add-variant" class="btn btn-primary" style="float:right; margin-right: 0px; width:150px;">Add Variant</button>
						</div>
					</div><br/>
					
	<table id="edit-variant-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead style="text-align: center;">
			<th>Variant Name</th>
			<th>Unit Price</th>
			<th>SKU</th>
			<th>Beginning Stock</th>
			<th style="display: none">alert Stock</th>
			<th style="display: none;">ending Quantity</th>
			<th style="display: none">id</th>
			<th>#</th>
		</thead>
		<tbody id="tbody-variant">
			
		</tbody>
	</table>
	<div class="row">
		<button type="button" style="max-width:22%; margin-left:2%" id="btn-edit-delete-item" class="btn btn-danger" style="float:right; margin-right: 0px; width:150px;">Delete Item</button>
	</div>
</form>
			</div>
			<div class="modal-footer row">
					<div class="col-md-4" style="margin: auto;">
						<button type="button" id="btn-cancel" class="btn btn-primary" style="width:100%;" data-dismiss="modal">Back</button>
					</div>
					<div class="col-md-4" style="margin: auto;">
						<button type="button" id="btn-cancel" class="btn btn-primary" style="width:100%;" data-dismiss="modal">Cancel</button>
					</div>
					<div class="col-md-4" style="margin: auto;">
						<button type="button" id="btn-save-edit" class="btn btn-primary" style="width:100%;" href="#">Save</button>
					</div>

			</div>
		</div>
	</div>
</div>

<!-- end modal-edit -->
					<!--=======================================================================================================  -->
<!-- Modal- edit-add-variant -->
	<div class="modal fade" id="modal-edit-add-variant" tabindex="-1" role="dialog"
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
					<input type="hidden" id="input-edit-add-varian-id" name="input-id" />		
					<div class="row">
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-edit-add-variant-name" placeholder="Variant Name">
						</div>
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-edit-add-variant-price" placeholder="Unit Price">
						</div>
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="input-edit-add-variant-sku" placeholder="SKU">
						</div>			
					</div>				
					<div><br/><br/>
						<h5>Set Beginning Stock</h5>
						<hr widht="100%"/>
						</div><br/>
						<div class="row">
						<div class="form-group col-md-6">
							<input type="text" class="form-control " id="input-edit-add-beginning-stock" placeholder="Beginning Stock">
						</div>
						<div class="form-group col-md-6">
							<input type="text" class="form-control " id="input-edit-add-alert-at" placeholder="Alert At">
						</div>			
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-cancel-add-edit-item-variant" class="btn btn-primary" style="width:20%;">Cancel</button>
				<button type="button" id="btn-edit-add-add-item-variant" class="btn btn-primary" style="width:20%;" >Add</button>
			</div>
		</div>
	</div>
</div>

<!--End Modal-edit-add-variant -->

<!-- Modal- edit-edit-variant -->
	<div class="modal fade" id="modal-edit-edit-variant" tabindex="-1" role="dialog"
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
					<input type="hidden" id="edit-edit-varian-id" name="input-id" />		
					<div class="row">
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="edit-edit-variant-name" placeholder="Variant Name">
						</div>
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="edit-edit-variant-price" placeholder="Unit Price">
						</div>
						<div class="form-group col-md-4">
							<input type="text" class="form-control " id="edit-edit-variant-sku" placeholder="SKU">
						</div>			
					</div>				
					<div><br/><br/>
						<h5>Set Beginning Stock</h5>
						<hr widht="100%"/>
						</div><br/>
						<div class="row">
						<div class="form-group col-md-6">
							<input type="text" class="form-control " id="edit-edit-beginning-stock" placeholder="Beginning Stock">
						</div>
						<div class="form-group col-md-6">
							<input type="text" class="form-control " id="edit-edit-alert-at" placeholder="Alert At">
						</div>			
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-cancel-edit-edit" class="btn btn-primary" style="width:20%;" >Cancel</button>
				<button type="button" id="btn-edit-edit-update-variant" class="btn btn-primary" style="width:20%;" >Update</button>
			</div>
		</div>
	</div>
</div>

<!--End Modal-edit-edit-variant -->