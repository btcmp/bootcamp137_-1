<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

</head><!-- comment -->
<body class="login-img3-body hold-transition login-page">
	
	<div class="login-box">
	  <div class="login-logo">
	    <a href="../../index2.html"><b>Kelompok</b>Satu</a>
	  </div>
	  <!-- /.login-logo -->
	  <div class="login-box-body">
		<c:if test="${not empty error }">
			<div class="login-box-msg">${error}</div>
		</c:if>
		<c:if test="${not empty logout }">
			<div class="login-box-msg">${logout}</div>
		</c:if>
	    <p class="login-box-msg">Sign in to start your session</p>
	
	    <form name='loginForm' action="<c:url value='j_spring_security_check' />" method='POST'>
	      <div class="form-group has-feedback">
	        <input type="text" class="form-control" placeholder="Username" name='username'>
	        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
	      </div>
	      <div class="form-group has-feedback">
	        <input type="password" class="form-control" placeholder="Password" name='password'>
	        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
	      </div>
	      <div class="row">
	        <div class="col-xs-8">
	         
	        </div>
	        <!-- /.col -->
	        <div class="col-xs-4">
	          <button name="submit" type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
	        </div>
	        <!-- /.col -->
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	      </div>
	    </form>
	  </div>
	  <!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->
</body>
</html>