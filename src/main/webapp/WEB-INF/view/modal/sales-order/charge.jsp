<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-charge" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<!--------------------------------------- Untuk Form Customer-------------------------------  -->
	
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">PAYMENT</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
			<div class="row show-grid" style="margin : 25px;">
				<div class="col-lg-2">
					<LABEL>CASH</LABEL>
				</div>
				<div class="col-lg-8">
				<form id="target" data-parsley-validate>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<input type="text"
							class="form-control" id="input-payment" aria-describedby="emailHelp"
							placeholder="Payment">
					</div>
				</form>
				</div>
				<div class="col-lg-2">
				<button type="button" id = "btn-done-order" class=" btn btn-primary">DONE</button>
				</div>
			</div>
			</div>
		</div>
	</div>
</div>