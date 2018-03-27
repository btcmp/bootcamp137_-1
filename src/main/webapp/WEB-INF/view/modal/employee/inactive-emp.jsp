<!-- Delete Modal -->
<div class="modal fade" id="delete-data" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Delete
					Data</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<input type="hidden" class="form-control" id="delete-id"
						placeholder="Enter Name">
				</div>
				Change status to inactive?
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-dismiss="modal">Cancel</button>
				<button type="button" id="btn-delete"
					class="btn btn-primary">Change</button>
			</div>
		</div>
	</div>
</div>