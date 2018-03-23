<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-create-cust" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true" >
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
				<form id="target" data-parsley-validate>
					<input type="hidden" id="input-id" name="input-id" />
					<div class="form-group">
						<h5>PROFILE</h5>
						<input type="text"
							class="form-control" id="input-supp-name" aria-describedby="emailHelp"
							placeholder="Customer Name">
							<input type="text"
							class="form-control" id="input-address" aria-describedby="emailHelp"
							placeholder="Email">
							<input type="text"
							class="form-control" id="input-address" aria-describedby="emailHelp"
							placeholder="Phone Number">
					</div>
					
					<div class="form-group" >
						<h5>DAY OF BIRTH </h5>
						<input type="text"
							class="form-control" id="input-supp-name" aria-describedby="emailHelp"
							placeholder="Day Of Birth ">
					</div>	
					
					<div class="form-group">
					<h5>ADDRESS</h5>
					<input type="text"
							class="form-control" id="input-supp-name" 
							placeholder="Text">	
					<div class= "row show-grid">	
						<div class ="col-lg-4" >
							<select data-parsley-required="true" name = "countries" id="input-province">
							<option value="" selected="selected">--CHOOSE PROVINCE--</option>
							<%-- <c:forEach var="loc" items= "${locations}">
								<option value="${loc.id}">${loc.streetAddress}</option>
							</c:forEach> --%>
							</select>
						</div>
						<div class="col-lg-4">
							<select data-parsley-required="true" name = "countries" id="input-region">
							<option value="" selected="selected">--CHOOSE REGION--</option>
							<%-- <c:forEach var="loc" items= "${locations}">
								<option value="${loc.id}">${loc.streetAddress}</option>
							</c:forEach> --%>
							</select>
						</div>
						<div class="col-lg-4"> 
							<select data-parsley-required="true" name = "countries" id="input-district">
							<option value="" selected="selected">--CHOOSE DISTRICT--</option>
							<%-- <c:forEach var="loc" items= "${locations}">
								<option value="${loc.id}">${loc.streetAddress}</option>
							</c:forEach> --%>
						</select>
						</div>
					 </div>	
					 </div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-save" class="btn btn-primary">Done</button>
			</div>
		</div>
</div>
</div>