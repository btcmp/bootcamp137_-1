<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-create-outlet" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Input Outlet</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="target" data-parsley-validate>
				<div class="modal-body">
					<div class="row" id="div-alert-modal" style="display: none;">
						<div class="col-xs-12">
							<div class="alert alert-info alert-dismissible" role="alert"
								id="show-alert2" style="padding: 5px">
								<p>
									<i class="icon fa fa-check"></i> Outlet added!
								</p>
							</div>
						</div>
					</div>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<label>Outlet Name</label> <input type="text"
							data-parsley-required="true" class="form-control"
							id="input-outlet-name" aria-describedby="emailHelp"
							placeholder="Outlet Name" pattern="([A-z0-9\s]){2,50}$">
						<!-- <p style = "color : red;"><small>*Required</small></p> -->
					</div>
					<div class="form-group ">
						<label>Address</label> <input type="text"
							data-parsley-required="true" class="form-control"
							id="input-address" aria-describedby="emailHelp"
							placeholder="Address" pattern="^[0-9a-zA-Z. ]+$">
						<!-- 	<p style = "color : red;"><small>*Required</small></p> -->
					</div>
					<!-- <div class="form-group"> -->
					<form class="form-inline">
						<div class="row">
							<div class="col-sm-4">
								<div class="form-group">
									<label>Province</label> <select class="form-control"
										data-parsley-required="true" name="countries"
										id="input-province" style="width: 210px; margin-right: 30px;"
										data-size="5">
										<option value="" selected="selected">CHOOSE PROVINCE</option>
										<c:forEach var="prov" items="${provinces}">
											<option value="${prov.id}">${prov.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group">
									<label>Region</label> <select class="form-control"
										data-parsley-required="true" name="countries"
										id="input-region" style="width: 210px; margin-right: 30px;"
										data-size="5">
										<option value="" selected="selected">CHOOSE REGION</option>
										<%-- <c:forEach var="reg" items= "${regions}">
								<option value="${reg.id}">${reg.name}</option>
							</c:forEach>  --%>
									</select>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group">
									<label>District</label> <select class="form-control"
										data-parsley-required="true" name="countries"
										id="input-district" style="width: 210px; margin-right: 30px;"
										data-size="5">
										<option value="" selected="selected">CHOOSE DISTRICT</option>
										<%--  <c:forEach var="dis" items= "${districts}">
								<option value="${dis.id}">${dis.name}</option>
							</c:forEach>  --%>
									</select>
								</div>
							</div>
						</div>
					</form>
					<!--  </div> -->
					<div class="from-group">
						<div class="row">
							<div class="col-sm-4">
								<label>Postal Code</label> <input type="text"
									data-parsley-required="true" class="form-control"
									id="input-postal-code" aria-describedby="emailHelp"
									placeholder="Postal Code" pattern="([0-9]){5,6}$">
								<!-- <p style = "color : red; "><small> *number only , max length = 6 </small></p> -->

							</div>
							<div class="col-sm-4">
								<label>Phone Number</label> <input type="text"
									data-parsley-required="true" class="form-control"
									id="input-phone" placeholder="Phone" maxlength="13">
								<!-- pattern="^\d{3,4}-\d{6,8}$"> -->
								<!-- 		<p style = "color : red;"><small> *number only, ex : 021-2233445 </small></p> -->
								<span><small>example : 021-2233445 </small></span>
							</div>
							<div class="col-sm-4">
								<label>Email</label> <input type="text"
									data-parsley-required="true" class="form-control"
									id="input-email" aria-describedby="emailHelp"
									placeholder="Email"
									pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$">
								<!-- <p style = "color : red;"><small>ex : abc@something.com</small></p> -->
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="reset" class="btn btn-primary">Cancel</button>
						<button type="button" id="btn-save" class="btn btn-primary">Save</button>
					</div>

				</div>
			</form>
		</div>
	</div>
</div>