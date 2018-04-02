<!-- Modal -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-choose-cust" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Customer</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body">
				<div class="row show-grid" style="margin: 25px;">
					<div class="col-lg-8">
						<form id="target" data-parsley-validate>
							<input type="hidden" id="input-id" name="input-id" />
							<div class="form-group">

								<input type="text" class="form-control" id="input-search-cust"
									aria-describedby="emailHelp" placeholder="Search Customer">
							</div>
						</form>
					</div>
					<div class="col-lg-2">
						<button type="button" id ="btn-search-cust" class=" btn btn-primary"
							>Search</button>
					</div>
					<div class="col-lg-2">
						<button type="button" id ="btn-create-cust" class=" btn btn-primary"
							>Add New</button>
					</div>
				</div>
				<table id="cust-tabel"
					class="table table-sm table-striped table-bordered" width="100%"
					cellspacing="0">
					<thead class="thead-dark" >
						<th><center>Name</center></th>
						<th><center>Phone</center></th>
						<th><center>Email</center></th>
						<th><center>Action</center><th>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>