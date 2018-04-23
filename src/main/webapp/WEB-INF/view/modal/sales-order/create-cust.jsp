<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-create-cust" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<!--------------------------------------- Untuk Form Customer-------------------------------  -->

	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">New Customer</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="target-create-cust" data-parsley-validate>
				<div class="row" id="div-alert-modal" style="display:none;">
						<div class="col-xs-12">
							<div class="alert alert-info alert-dismissible" role="alert" id="show-alert2" style="padding: 5px">
			                <p><i class="icon fa fa-check"></i> Success add new customer! </p>
			              </div>
						</div>
					</div>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<h5>PROFILE</h5>
						<input type="text" data-parsley-required="true"
							class="form-control" id="input-cust-name"
							placeholder="Customer Name" pattern="[A-Za-z]|'|]">
							<!-- <p style = "color : red;"><small>*Required</small></p> -->
							<br> 	
							<input type="text"
							data-parsley-required="true" class="form-control"
							id="input-cust-email" placeholder="Email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$">
							<!-- <p style = "color : red;"><small>ex : abc@something.com</small></p> -->
							<br />
							<input
							type="text" data-parsley-required="true" class="form-control"
							id="input-cust-phone" placeholder="Phone Number" maxlength= "14">
							<!-- <p style = "color : red;"><small> *number only, ex : 08xxxxxxxxxx </small></p> -->
					</div>
					
					
					<div class="form-group">
						<h5>DAY OF BIRTH</h5>
						<input type="text" data-parsley-required="true"
							class="form-control" id="input-cust-dob"
							placeholder="Day Of Birth ">
							<!-- <p style = "color : red;"><small>*Required</small></p> -->
					</div>

					<div class="form-group">
						<h5>ADDRESS</h5>
						<input type="text" data-parsley-required="true"
							class="form-control" id="input-cust-address"
							placeholder="Address">
							<!-- <p style = "color : red;"><small>*Required</small></p>  -->
							<br>
						<div class="row show-grid">
							<div class="col-lg-4">
								<select data-parsley-required="true" name="countries"
									id="input-province" style="width: 210px; margin-right: 30px;">
									<option value="" selected="selected">CHOOSE PROVINCE</option>
									<c:forEach var="prov" items="${provinces}">
										<option value="${prov.id}">${prov.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-lg-4">
								<select data-parsley-required="true" name="countries"
									id="input-region" style="width: 210px; margin-right: 30px;">
									<option value="" selected="selected">CHOOSE REGION</option>
									<c:forEach var="reg" items="${regions}">
										<option value="${reg.id}">${reg.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-lg-4">
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
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-add-cust" class="btn btn-primary">Done</button>
			</div>
		</div>
	</div>
</div>