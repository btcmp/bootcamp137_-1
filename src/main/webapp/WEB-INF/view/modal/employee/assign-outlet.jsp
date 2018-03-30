<!-- call modal -->
<div class="modal fade" id="modal-assign-outlet" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel"
	aria-hidden="true">
	<div class="modal-dialog " role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Assign
					Outlet to Employee</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body">
				<form id="target">
					<input type="hidden" id="insert-empout-id"
						name="insert-empout-id" /> <input type="hidden"
						id="insert-outlet-id" name="insert-outlet-id" />
					<c:forEach var="outlet" items="${outlets }">
					<div class="input-group">
		                  <input type="text" readonly class="form-control" value="${outlet.name }">
		                  <span class="form- control input-group-addon">
		                    <input type="checkbox" value="${outlet.id }" class="select-outlet" name="select-outlet" />
		                  </span>
		            </div><br>
		            </c:forEach>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-select-outlet"
					class="btn btn-success">Select</button>
			</div>
		</div>
	</div>
</div>