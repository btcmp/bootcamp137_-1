<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

</head>
<body class="hold-transition login-page">
	<!-- comment -->
	<div class="login-box">
	  <div class="login-logo">
	    <a href="../../index2.html"><b>Admin</b>LTE</a>
	  </div>
	  <!-- /.login-logo -->
	  <div class="login-box-body">
	    <p class="login-box-msg">Choose your outlet</p>
		<select class="form-control col-sm-4" name="outlet-search"
			id="outlet-search">
			<option value="kosong">Search Outlet</option>
			<c:forEach var="outlet" items="${outlets }">
				<option value="${outlet.id }">${outlet.name }</option>
			</c:forEach>
		</select>
		<input type="button" class="btn btn-primary" id="choose-outlet" value="choose"/>
	  </div>
	  <!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->
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