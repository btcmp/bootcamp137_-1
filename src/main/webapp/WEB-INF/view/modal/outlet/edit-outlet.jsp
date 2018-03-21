<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-edit-outlet" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Edit Outlet</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<input type="text"
							class="form-control" id="edit-supp-name" aria-describedby="emailHelp"
							placeholder="Supplier Name">
					</div>
					<div class="form-group" >
						<input type="text"
							class="form-control" id="edit-address" aria-describedby="emailHelp"
							placeholder="Address">
					</div>	
					<div class="form-group">
					<div class= "row">			
						<div class ="col-sm-4" >
							<select data-parsley-required="true" name = "countries" id="edit-province">
							<option value="" selected="selected">--CHOOSE PROVINCE--</option>
							<%-- <c:forEach var="loc" items= "${locations}">
								<option value="${loc.id}">${loc.streetAddress}</option>
							</c:forEach> --%>
							</select>
						</div>
						<div class="col-sm-4">
							<select data-parsley-required="true" name = "countries" id="edit-region">
							<option value="" selected="selected">--CHOOSE REGION--</option>
							<%-- <c:forEach var="loc" items= "${locations}">
								<option value="${loc.id}">${loc.streetAddress}</option>
							</c:forEach> --%>
							</select>
						</div>
						<div class="col-sm-4"> 
							<select data-parsley-required="true" name = "countries" id="edit-district">
							<option value="" selected="selected">--CHOOSE DISTRICT--</option>
							<%-- <c:forEach var="loc" items= "${locations}">
								<option value="${loc.id}">${loc.streetAddress}</option>
							</c:forEach> --%>
						</select>
						</div>
					 </div>	
					 </div>
					 <div class="from-group">
					<div class= "row">
					<div class="col-sm-4">
						<input type="text"
							class="form-control" id="edit-postal-code" aria-describedby="emailHelp"
							placeholder="Postal Code">
					</div>
					<div class="col-sm-4">
						<input type="text"
							class="form-control" id="edit-phone" aria-describedby="emailHelp"
							placeholder="Phone">
					</div>
					<div class="col-sm-4">
						<input type="text"
							class="form-control" id="edit-email" aria-describedby="emailHelp"
							placeholder="Email">
					</div>
					</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				<button type="button" id="btn-save" class="btn btn-primary">Save</button>
			</div>
		</div>
	</div>
</div>