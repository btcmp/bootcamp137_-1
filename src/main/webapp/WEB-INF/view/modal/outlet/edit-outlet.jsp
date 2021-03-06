<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-edit-outlet" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Edit Outlet</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="target-edit" data-parsley-validate>
				<div class="modal-body">
					<div class="row" id="div-alert-modal-edit" style="display: none;">
						<div class="col-xs-12">
							<div class="alert alert-info alert-dismissible" role="alert"
								id="show-alert2" style="padding: 5px">
								<p>
									<i class="icon fa fa-check"></i> Outlet Update!
								</p>
							</div>
						</div>
					</div>
					<input type="hidden" id="edit-id" name="input-id" />
					<div class="form-group">
						<label>Outlet Name</label> <input type="text"
							data-parsley-required="true" class="form-control"
							id="edit-outlet-name" aria-describedby="emailHelp"
							placeholder="Outlet Name" pattern="([A-z0-9\s]){2,50}$">
						<!-- <p style = "color : red;"><small>*Required</small></p> -->
					</div>
					<div class="form-group">
						<label>Address</label> <input type="text"
							data-parsley-required="true" class="form-control"
							id="edit-address" aria-describedby="emailHelp"
							placeholder="Address" pattern="^[0-9a-zA-Z. ]+$">
						<!-- 	<p style = "color : red;"><small>*Required</small></p> -->
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-sm-4">
								<label>Province</label> <select data-parsley-required="true"
									name="countries" id="edit-province"
									style="width: 210px; margin-right: 30px;">
									<option selected disabled>CHOOSE PROVINCE</option>
									<c:forEach var="prov" items="${provinces}">
										<option value="${prov.id}">${prov.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-4">
								<label>Region</label> <select data-parsley-required="true"
									name="countries" id="edit-region"
									style="width: 210px; margin-right: 30px;">
									<option selected disabled>CHOOSE REGION</option>
									<c:forEach var="reg" items="${regions}">
										<option value="${reg.id}">${reg.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-4">
								<label>District</label> <select data-parsley-required="true"
									name="countries" id="edit-district"
									style="width: 210px; margin-right: 30px;">
									<option selected disabled>CHOOSE DISTRICT</option>
									<c:forEach var="dis" items="${districts}">
										<option value="${dis.id}">${dis.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div class="from-group">
						<div class="row">
							<div class="col-sm-4">
								<label>Postal Code</label> <input type="text"
									data-parsley-required="true" class="form-control"
									id="edit-postal-code" aria-describedby="emailHelp"
									placeholder="Postal Code" pattern="([0-9]){5,6}$">
								<!-- <p style = "color : red; "><small> *number only , max length = 6 </small></p> -->
							</div>
							<div class="col-sm-4">
								<label>Phone Number</label> <input type="text"
									data-parsley-required="true" class="form-control"
									id="edit-phone" aria-describedby="emailHelp"
									placeholder="Phone" maxlength="13">
								<!-- pattern="^\d{3,4}-\d{6,8}$"> -->
								<span><small>ex : 021-2233445 </small></span>
							</div>
							<div class="col-sm-4">
								<label>Email</label> <input type="text"
									data-parsley-required="true" class="form-control"
									id="edit-email" aria-describedby="emailHelp"
									placeholder="Email"
									pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$">
								<!-- 	<p style = "color : red;"><small>ex : abc@something.com</small></p> -->
							</div>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<button type="reset" class="btn btn-primary">Cancel</button>
					<button type="button" class="btn-update-outlet btn btn-primary">Save</button>
				</div>
			</form>
		</div>
	</div>
</div>