<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-edit-supp" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Edit Supplier Detail</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="target" data-parsley-validate>
			<div class="modal-body">
					<input type="hidden" id="edit-id" name="input-id" />
					<div class="form-group">
						<input type="text"
							class="form-control" id="edit-supp-name"
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
							<c:forEach var="prov" items= "${provinces}">
								<option value="${prov.id}">${prov.name}</option>
							</c:forEach> 
							</select>
						</div>
						<div class="col-sm-4">
							<select data-parsley-required="true" name = "countries" id="edit-region">
							<option value="" selected="selected">--CHOOSE REGION--</option>
							 <c:forEach var="reg" items= "${regions}">
								<option value="${reg.id}">${reg.name}</option>
							</c:forEach>
							</select>
						</div>
						<div class="col-sm-4"> 
							<select data-parsley-required="true" name = "countries" id="edit-district">
							<option value="" selected="selected">--CHOOSE DISTRICT--</option>
						 <c:forEach var="dis" items= "${districts}">
								<option value="${dis.id}">${dis.name}</option>
							</c:forEach> 
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
			
			</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-primary" >Cancel</button>
				<button type="button" id="btn-save-edit" class="btn btn-primary">Save</button>
			</div>
				</form>
		</div>
	</div>
</div>