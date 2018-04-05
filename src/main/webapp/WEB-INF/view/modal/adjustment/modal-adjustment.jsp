
<!-- Call modal -->
<!-- Modal Purchase Input -->
<div class="modal fade" id="modal-adj-input" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">ADJUSTMENT</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div> 
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<label for="input-name">CREATE NEW PR : </label>
						<select name="role" id="input-outlet">
							<c:forEach var="out" items="${outlets }">
								<option value="${out.id }">${out.name }</option>
							</c:forEach>
				 		</select>
					</div>
					<div class="form-group">
		 				
					</div>
					
					
					<div class="form-group">
						<label for="input-note">Notes</label>
						<textarea class="form-control" id="input-note" rows="5"></textarea>
					</div>
					<div class="form-group">
						<label for="input-name">Adjustment Stock</label>
						<hr>
						
						<table id="tbl-adj-add-item" class="table table-striped table-bordered" cellspacing="0" width="100%">
							<thead style="text-align:  center;">
								<th>Item</th>
								<th>In Stock</th>
								<th>Adj. Qty</th>
								<th></th>
							</thead>
							<tbody id="tbody-add-item">
							</tbody>
						</table>
						
						<button type="button" id="btn-add-item" class="btn btn-primary btn-block">Add Item</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="row">
					<div class="col-md-6">
					
					</div>
					<div class="col-md-3">
						<button type="button" id="btn-cancel-input" class="btn btn-primary btn-block" data-dismiss="modal">Cancel</button>
					</div>
					<div class="col-md-3">
						<button type="button" id="btn-save" class="btn btn-success btn-block">Save and Submit</button>
					</div>
				</div>				
			</div>
		</div>
	</div>
</div>

<!-- Modal Add Item -->
<div class="modal fade" id="modal-adj-add-item" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Add Item</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<input type="text" id="src-item-variant" class="form-control" placeholder="Item Name - Variant Name" />
					</div>
				</form>
			</div>
			<div class=modal-body>
				<table class="table table-striped table-bordered" cellspacing="0" width="100%">
					<thead>
						<th>Item</th>
						<th>Stock</th>
						<th>Adj. Qty</th>
						<th>Action</th>
					</thead>
					<tbody id="tbl-add-item-purchase">
					</tbody>
				</table>
				<div class="row">
					<div class="col-md-5">
						<button type="button" id="btn-cancel-add" class="btn btn-primary btn-block" data-dismiss="modal">Cancel</button>
					</div>
					<div class="col-md-2">
					
					</div>
					<div class="col-md-5">
						<button type="button" id="btn-add-item-var" class="btn btn-primary btn-block">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
