<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-create-category" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Category</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<form id="target" data-parsley-validate>
				<div class="modal-body">
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<input type="text" class="form-control" id="input-category-name"
							aria-describedby="emailHelp" placeholder="Category Name">
					</div>
				</div>
				<div class="modal-footer">
					<div class="col-sm-11">
						<button type="reset" class="btn btn-primary">Cancel</button>
					</div>
					<div class="col-sm-1">
						<button type="button" id="btn-save-cat" class="btn btn-primary">Save</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>