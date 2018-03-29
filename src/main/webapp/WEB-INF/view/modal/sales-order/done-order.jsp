<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-done-order" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<!--------------------------------------- Untuk Form Customer-------------------------------  -->
	
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content" >
			<div class="modal-body">
				<div class="form-group" >
					<div class="row show-grid">
						<div class="col-lg-2"></div>
						<div class="col-lg-8">
							<input type="text"
							class="form-control" id="kembalian" style ="margin : 20px; "
							placeholder="Total" >
						</div>
						<div class="col-lg-2 "></div>
					</div> 
				</div>
				<!-- Penutup div box harga  -->		
					<div class="form-group">
						<h3 style="text-align : center;" id = "charge-cash"></h3>
						<hr>
						<!-- <input type="text"
							class="form-control" id="charge-cash" style ="margin : 20px; "
							placeholder="Total" > -->
					</div>
				<!-- Penutup out  -->
				<div class="form-group"  >
					<p style="text-align : center; ">How do you want to receive your receipts ? </p>
				</div>
				<!-- Penutup How  -->
				<div class="form-group" >
					<div class="row show-grid">
						<div class="col-lg-10">
							<input type="text"
							class="form-control" id="input-address" style ="margin: 20px; "
							placeholder="Customer Email">
						</div>
						<div class="col-lg-2">
						<button type="button" class="btn btn-primary" data-dismiss="modal">DONE</button></div>
					</div> 
				</div>
				
				<!-- Button dua dibawah  -->	
				<div class="form-group"  >
						<button type="button" class="btn btn-primary btn-info" 
						data-dismiss="modal" style="width : 100% ; margin-top:10px; ">Print Receipt </button>
						
				</div>	
				<div class="form-group" >
						<button type="button" class="btn btn-primary btn-danger" 
						data-dismiss="modal" style="width : 100% ; margin-top:10px; ">No, Thanks & Done </button>
						
				</div>	
			</div>
			</div>
		</div>
	</div>