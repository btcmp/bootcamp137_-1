<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<h6>PURCHASE REQUEST DETAIL</h6>
<hr>
<table>
	<tr>
		<th>PR Number </th>
		<td></td>
		<td> : </td>
		<td id="pr-number"></td>
	</tr>
	<tr>
		<th>Created By </th>
		<td></td>
		<td> : </td>
		<td id="created-by"></td>
	</tr>
	<tr>
		<th>Target Waktu Item Ready </th>
		<td></td>
		<td> : </td>
		<td id="tgl-ready"></td>
	</tr>
	<tr>
		<th>PR Status </th>
		<td></td>
		<td> : </td>
		<td id="status"></td>
	</tr>
	<tr>
		<th>Notes </th>
		<td></td>
		<td> : </td>
		<td id="notes"></td>
	</tr>
</table>
<div class="form-group">
	<label for="input-note">Notes</label>
	<textarea class="form-control" id="input-note" rows="5" disabled="disabled"></textarea>
</div>
<h5><b>Status History</b></h5>
<hr>
<h5><b>Purchase Items</b></h5>
<hr>

<!-- ======================================================================================================================= -->
	
<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->

<!-- Call Modal -->
	
</body>
</html>