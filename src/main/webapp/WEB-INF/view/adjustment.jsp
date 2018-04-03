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
			<div class="input-group">
              <div class="input-group-addon">
                <i class="fa fa-calendar"></i>
              </div>
              <input type="text" class="form-control pull-right" name="daterange" id="reservation">
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
		<tbody>
			<c:forEach items="${prs }" var="pr">
				<tr>
					<td>
						<script>
							var times = '${pr.createdOn }';
							var time = times.split(':');
							document.write(time[0]+':'+time[1]);
						</script>
					</td>
					<td>${pr.prNo }</td>
					<td>${pr.notes }</td>
					<td>${pr.status }</td>
					<td>
						<script type="text/javascript">
							var cek = '${pr.status }';
							console.log(cek);
							if(cek == "Approved"){
								$('.update').prop('disabled', true);
							}else{
								$('.update').prop('disabled', false);
							}
						</script>
						<a id="${pr.id }" class="update btn btn-success btn-sm" href="#">Edit</a> |
						<a id="${pr.id }" class="view btn btn-success btn-sm" href="${pageContext.request.contextPath}/pr/detail/${pr.id}">View</a>
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