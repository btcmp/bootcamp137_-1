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
	                    <span class="glyphicon glyphicon-lock"></span> Login</div>
	                <div class="panel-body">
	                	<c:if test="${not empty error }">
							<div class="login-box-msg">${error}</div>
						</c:if>
						<c:if test="${not empty logout }">
							<div class="login-box-msg">${logout}</div>
						</c:if>
	    
	                    <form class="form-horizontal" role="form" name='loginForm' action="<c:url value='j_spring_security_check' />" method='POST'>
	                    <div class="form-group">
	                        <label for="inputEmail3" class="col-sm-3 control-label">Username</label>
	                        <div class="col-sm-9">
	                            <input type="text" name="username" class="form-control" id="inputEmail3" placeholder="Username" required>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label for="inputPassword3" class="col-sm-3 control-label">Password</label>
	                        <div class="col-sm-9">
	                            <input type="password" name="password" class="form-control" id="inputPassword3" placeholder="Password" required>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="col-sm-offset-3 col-sm-9">
	                        </div>
	                    </div>
	                    <div class="form-group last">
	                        <div class="col-sm-offset-3 col-sm-9">
	                            <button name="submit" type="submit" class="btn btn-success btn-sm">Sign in</button>
	                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                            <button type="reset" class="btn btn-default btn-sm">Reset</button>
	                        </div>
	                    </div>
	                    </form>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>