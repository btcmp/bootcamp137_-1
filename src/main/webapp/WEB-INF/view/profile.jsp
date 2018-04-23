<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =================================================================================================================== -->
<!-- ajax here -->
<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<div class="row">
    <div class="col-xs-12 col-sm-6 col-md-6">
        <div class="well well-sm">
            <div class="row">
                <div class="col-sm-6 col-md-4">
                    <img src="${url}/dist/img/user2-160x160.jpg" alt="" class="img-rounded img-responsive" />
                </div>
                <div class="col-sm-6 col-md-8">
                    <h4 class="text-capitalize"><b>${emp.firstName } ${emp.lastName }</b></h4>
                    <p>
                        <i class="glyphicon glyphicon-envelope"></i> ${emp.email }
                        <br />
                        <i class="glyphicon glyphicon-th"></i> Outlet Akses
                        	<ol>
								<c:forEach items="${emp.empouts }" var="empout">
									<li>${empout.outlet.name }</li>
								</c:forEach>
							</ol>
                        <i class="glyphicon glyphicon-user"></i> Username : ${emp.user.username }
                        <br />
                        <i class="glyphicon glyphicon-lock"></i> Pass : ${emp.user.password }
                        <br />
                        <i class="glyphicon glyphicon-globe"></i> Role : ${emp.user.role.name }
                    </p> 
                    <!-- Split button -->
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ======================================================================================================================= -->
	
<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->

<!-- Call Modal -->
	
</body>
</html>