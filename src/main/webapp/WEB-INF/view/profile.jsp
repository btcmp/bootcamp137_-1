<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =================================================================================================================== -->
<!-- ajax here -->
<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->

<table>
	<tr>
		<th>First Name </th>
		<td> : </td>
		<td>${emp.firstName }</td>
	</tr>
	<tr>
		<th>Last Name </th>
		<td> : </td>
		<td>${emp.lastName }</td>
	</tr>
	<tr>
		<th>Email </th>
		<td> : </td>
		<td>${emp.email }</td>
	</tr>
	<tr>
		<th>Akses Outlet </th>
		<td> : </td>
		<td>
			<ol>
				<c:forEach items="${emp.empouts }" var="empout">
					<li>${empout.outlet.name }</li>
				</c:forEach>
			</ol>
		</td>
	</tr>
	<tr>
		<th>Username </th>
		<td> : </td>
		<td>${emp.user.username }</td>
	</tr>
	<tr>
		<th>Password </th>
		<td> : </td>
		<td>${emp.user.password }</td>
	</tr>
	<tr>
		<th>Role </th>
		<td> : </td>
		<td>${emp.user.role.name }</td>
	</tr>
</table>

<br><br>
      
<!-- ======================================================================================================================= -->
	
<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>

<!-- ======================================================================================================================= -->

<!-- Call Modal -->
	
</body>
</html>