<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->
<style>
	.modal-content {
	  overflow: scroll;
	}
</style>

<%@ include file="/WEB-INF/view/modal/adjustment/script-adjustment.jsp"%>
<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<hr>
<h6>ADJUSTMENT</h6>
<hr>
	<div class="row">
	  <div class="col-md-3">
	  	<div class="form-group">
			<!-- <input type="text" class="form-control" id="insert-date" name="daterange" value="01/01/2018 - 01/31/2018"> -->
			<div class="input-group" style="    width: 132%;">
              <div class="input-group-addon">
                <i class="fa fa-calendar"></i>
              </div>
              <input type="text" class="form-control pull-right" name="daterange" id="src-date">
            </div>
		</div> 
	  </div>
	 <div class="col-md-5">
	  </div>
	  <div class="col-md-2">
	  	<div class="form-group">
			<button type="button" id="btn-export" class="btn btn-primary btn-block">Export</button>
		</div>
	  </div>
	  <div class="col-md-2">
	  	<div class="form-group">
		    <button type="button" id="btn-create" class="btn btn-primary btn-block">Create</button>
		</div>
	  </div>
	</div>
	<hr>
	<table id="dt-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead class="thead-dark">
			<th><center>Adjustment Date</center></th>
			<th><center>Notes</center></th>
			<th><center>Status</center></th>
			<th><center>#</center></th>
		</thead>
		<tbody id="tbody-adj">
			<c:forEach items="${adj}" var="adj">
				<tr style="text-align: center;">
					<td>
						<script>
							var times = '${adj.createdOn }';
							var time = times.split(':');
							document.write(time[0]+':'+time[1]);
						</script>
					</td>
					<td>${adj.notes }</td>
					<td>${adj.status }</td>
					<td>
						<a id="${adj.id }" class="view btn btn-success btn-sm" href="${pageContext.request.contextPath}/t/adjustment/detail/${adj.id}">View</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- ======================================================================================================================= -->
	
	<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>
	
	<!-- ======================================================================================================================= -->
	
	<!-- Call Modal -->
	
<%@ include file="/WEB-INF/view/modal/adjustment/modal-adjustment.jsp"%>
</body>
</html>