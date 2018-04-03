<!-- Modal edit -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="modal fade" id="modal-edit-po" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true" >
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">PURCHASE ORDER</h5><input id="input-po-id" style="display: none"/>
				<input id="input-po-no" style="display: none"/><input id="input-pr-id" style="display: none"/>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			
			
			<div class="modal-body">
				<form id="target" data-parsley-validate>
					<h5>EDIT NEW PO: <input id="input-outlet" style="border: none"/><input id="input-outlet-id" style="display: none"/>
					</h5>
					<hr/>
						<h5>Choose Supplier</h5>			
						<div class ="form-group">
							<div class="row">
								<div class="col-md-12">
									<select data-parsley-required="true" name="countries" id="input-supplier" style="width: 100%; height:110% ">
					 				<option value="" selected="selected">Supplier</option>
									 <c:forEach var="sup" items= "${suppliers}">
										<option value="${sup.id}">${sup.name}</option>
									</c:forEach> 
									</select>
								</div>
							</div>
						</div>
					<div>
						<h5>Notes</h5>
						<textarea rows="" cols="" style="width: 100%; height: 123px;" id="input-notes" ></textarea>
					</div><br/>
					<h5>Purchace Order</h5>
			<table id="item-po-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
				<thead class="thead-dark">
					<th>Item</th>
					<th>In Stock</th>
					<th>Qty</th>
					<th>Unit Cost</th>
					<th>Sub Total</th>
				</thead>
				<tbody id="tbody-edit-po">
				<c:forEach var="po" items= "${pos}">
					<tr>
						<%-- <td>${po.prId }</td>
						<td><center>3</center></td>
						<td><center>3</center></td>
						<td><center>Rp. 300.000</center></td>
						<td><center>Rp. 900.000</center></td> --%>
					</tr><br/>
				</c:forEach>
				</tbody>
				<tfoot>
					<tr style=" border: none; background: none;">
						<td colspan="4">TOTAL</td>
						<td><input id="input-total" style="border: none;"/></td>
					</tr>
				</tfoot>
			</table>
					
			</form>
			</div>
			<div class="modal-footer" style="margin: auto;">
				<div class="row">
					<div class="col-md-4">
						<button type="button" id="btn-submit" class="btn btn-primary" style="width: 100%;" >Submit</button>
					</div>
					<div class="col-md-4">
						<button type="button" id="btn-cancel" class="btn btn-primary" style="width: 100%;"  data-dismiss="modal">Cancel</button>
					</div>
					<div class="col-md-4">
						<button type="button" id="btn-save" class="btn btn-primary" style="width: 100%;" >Save</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- end modal-edit -->