<%@ include file="/WEB-INF/view/template/master-header.jsp"%>
<style>
body { 
  background: url('${url}/img/bg-login.png') no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}

.panel-default {
opacity: 0.9;
margin-top:30px;
}
.form-group.last { margin-bottom:0px; }
</style>

</head><!-- comment -->
<body>
	<br><br><br><br><br><br>
	<div class="container">
	    <div class="row">
	        <div class="col-md-4 col-md-offset-7">
	            <div class="panel panel-default">
	                <div class="panel-heading">
	                    <span class="glyphicon glyphicon-lock"></span> Choose Outlet</div>
	                <div class="panel-body">
					    <div>
						<select class="form-control col-sm-4" name="outlet-search"
							id="outlet-search">
							<option value="kosong">Search Outlet</option>
							<c:forEach var="outlet" items="${outlets }">
								<option value="${outlet.id }">${outlet.name }</option>
							</c:forEach>
						</select>
						</div>
	                    <div class="form-group">
	                        <div class="col-sm-offset-3 col-sm-9">
	                        </div>
	                    </div>
	                    <br><br>
	                    <div class="form-group last">
	                        <div class="col-sm-offset-8 col-sm-4" style="padding-right:0">
	                            <div class="form-group has-feedback">
					        		<input type="button" class="btn btn-success btn-sm btn-block btn-flat form-control" id="choose-outlet" value="Enter"/>
					          		<span class="glyphicon glyphicon-log-in form-control-feedback" style="color:white"></span>
					        	</div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</body>

<!-- jQuery 3 -->
	<script src="${url}/bower_components/jquery/dist/jquery.min.js"></script>
<script>

jQuery(document).ready(function(){
	$('#choose-outlet').click(function(){
		var idOutlet = $('#outlet-search').val();
		if (idOutlet!=="kosong") {
			window.location = "${pageContext.request.contextPath}/welcome-auth/home?id="+idOutlet;
		}
	})
})
/* ini comment */
</script>
</html>