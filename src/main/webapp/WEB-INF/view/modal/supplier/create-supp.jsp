<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-create-supp" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<b class="modal-title" id="exampleModalLabel"><center>Supplier Detail</center></b>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="target" data-parsley-validate>
				<div class="modal-body">
				<div class="row" id="div-alert-modal" style="display:none;">
						<div class="col-xs-12">
							<div class="alert alert-info alert-dismissible" role="alert" id="show-alert2" style="padding: 5px">
			                <p><i class="icon fa fa-check"></i> Supplier added!</p>
			              </div>
						</div>
					</div>
					<input type="hidden" id="edit-id" name="input-id" />
					<div class="form-group">
					<label>Supplier Name</label>
						<input data-parsley-required="true" type="text"
							class="form-control" id="input-supp-name"
							placeholder="Supplier Name" pattern="^[0-9a-zA-Z. ]+$">
						<!-- <p style="color: red;">
							<small>*Letters only</small>
						</p> -->
					</div>
					<div class="form-group">
					<label>Address</label>
						<input data-parsley-required="true" type="text"
							class="form-control" id="input-address" placeholder="Address"
							pattern="^[0-9a-zA-Z. ]+$">
					<!-- 	<p style="color: red;">
							<small>*Required</small>
						</p> -->
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-sm-4">
							<label>Province</label>
								<select data-parsley-required="true" name="countries"
									id="input-province" style="width: 210px; margin-right: 30px;">
									<option selected disabled>CHOOSE PROVINCE</option>
									<c:forEach var="prov" items="${provinces}">
										<option value="${prov.id}">${prov.name}</option>
									</c:forEach>

								</select>
							</div>
							<div class="col-sm-4">
							<label>Region</label>
								<select data-parsley-required="true" name="countries"
									id="input-region" style="width: 210px; margin-right: 30px;">
									<option value="" selected="selected">CHOOSE REGION</option>
									<c:forEach var="reg" items="${regions}">
										<option value="${reg.id}">${reg.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-4">
							<label>District</label>
								<select data-parsley-required="true" name="countries"
									id="input-district" style="width: 210px; margin-right: 30px;">
									<option value="" selected="selected">CHOOSE DISTRICT</option>
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
							<label>Postal Code</label>
								<input data-parsley-required="true" type="text"
									class="form-control" id="input-postal-code"
									placeholder="Postal Code" maxlength = "6" minlength = "5" pattern="([0-9]){5,6}$">
								<!-- <p style="color: red;">
									<small> *number only , max length = 6 </small>
								</p> -->
							</div>
							<div class="col-sm-4">
							<label>Phone Number</label>
								<input data-parsley-required="true" type="text"
									class="form-control" id="input-phone" placeholder="Phone"
									maxlength= "14">
								<p>
									<small>example : 087651234567 </small>
								</p>
							</div>
							<div class="col-sm-4">
							<label>Email</label>
								<input data-parsley-required="true" type="text"
									class="form-control" id="input-email"
									pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
									placeholder="Email">
								<!-- <p style="color: red;">
									<small>ex : abc@something.com</small>
								</p> -->
							</div>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<button type="reset" class="btn btn-secondary">Cancel</button>
					<button type="button" id="btn-save" class="btn btn-primary">Save</button>
				</div>
			</form>
		</div>
	</div>
</div>