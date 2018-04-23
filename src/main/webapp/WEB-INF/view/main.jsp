<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =================================================================================================================== -->
<!-- ajax here -->
<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<p>Welcome <b class="text-uppercase">${employee.firstName} ${employee.lastName}</b></p>
<p>Outlet Active : <b>${outlet.name}</b></p>

<br><br>

<div class="row main-show">
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-aqua"><i class="fa fa-ticket"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Purchase Request</span>
              <span class="info-box-number">
              	<script type="text/javascript">
					$.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath}/t/pr/get-pr-need',
						dataType: 'json',
						success : function(data){
							console.log(data);
							$('#pr-need').val(data);
						}
					});
				</script>
				<input type="text" class="form-control" readonly id="pr-need" style="border:none; background:white; font-size: 2em;" />
              </span> 
               action needed
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-green"><i class="fa fa-dollar"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Purchase Order</span>
              <span class="info-box-number">
              	<script type="text/javascript">
					$.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath}/t/po/get-po-need',
						dataType: 'json',
						success : function(data){
							console.log(data);
							$('#po-need').val(data);
						}
					});
				</script>
				<input type="text" class="form-control" readonly id="po-need" style="border:none; background:white; font-size: 2em;" />
              </span> action needed
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-yellow"><i class="fa fa-edit"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Adjustment</span>
              <span class="info-box-number">
              	<script type="text/javascript">
					$.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath}/t/adjustment/get-adj-need',
						dataType: 'json',
						success : function(data){
							console.log(data);
							$('#adj-need').val(data);
						}
					});
				</script>
				<input type="text" class="form-control" readonly id="adj-need" style="border:none; background:white; font-size: 2em;" />
              </span> action needed
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-red"><i class="fa fa-retweet"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Transfer Stock</span>
              <span class="info-box-number">
              	<script type="text/javascript">
					$.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath}/t/ts/get-ts-need',
						dataType: 'json',
						success : function(data){
							console.log(data);
							$('#ts-need').val(data);
						}
					});
				</script>
				<input type="text" class="form-control" readonly id="ts-need" style="border:none; background:white; font-size: 2em;" />
              </span> action needed
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
      
<!-- ======================================================================================================================= -->
	
<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->

<!-- Call Modal -->
	
</body>
</html>