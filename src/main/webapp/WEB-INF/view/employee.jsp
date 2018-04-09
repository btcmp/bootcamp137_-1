<%@ include file="/WEB-INF/view/template/master-header.jsp"%>

<!-- =========================================================================================================== -->

<script type="text/javascript">
	jQuery(document).ready(
		function() {
			$('#dt-table').DataTable({
				"searching" : false,
				"info" : false
			});

			$('#btn-assign-outlet').on('click', function() {
				$('#modal-assign-outlet').modal();
			});

			$('#btn-select-outlet').on('click', function() {
				$('#modal-assign-outlet').modal('hide');
			});

			$('#cb-have-account').val('false');
			$('#cb-have-account').change(function() {
				if (this.checked) {
					$('#row-user').show(1000);
					$('#cb-have-account').val('true');
					$('#insert-username').attr('data-parsley-required', true);
		        	$('#insert-username').prop('required', true);
		        	$('#insert-pass').attr('data-parsley-required', true);
		        	$('#insert-pass').prop('required', true);
		        	$('#insert-role').attr('data-parsley-required', true);
		        	$('#insert-role').prop('required', true);
				} else {
					$('#row-user').hide(1000);
					$('#cb-have-account').val('false');
					$('#insert-username').attr('data-parsley-required', false);
		        	$('#insert-username').prop('required', false);
	        		$('#insert-pass').attr('data-parsley-required', false);
	        		$('#insert-pass').prop('required', false);
	        		$('#insert-role').attr('data-parsley-required', false);
		        	$('#insert-role').prop('required', false);
		        	userOK = 1;
				}
			});

			//save
			$('#btn-save').on('click', function() {
				var form= $('#form-emp');
				var valid = form.parsley().validate();
				
				var empOut = [];

				$('.select-outlet:checked').each(function() {
					var eo = {
						//id : $('#insert-empout-id').val(),
						outlet : {
							id : $(this).val()
						}
					};
					empOut.push(eo);
				});

				var usr;
				if ($('#cb-have-account').is(":checked")) {
					var haveAkun = 1;
					usr = {
						id : $('#insert-user-id').val(),
						username : $('#insert-username').val(),
						password : $('#insert-pass').val(),
						active : 1,
						role : {
							id : $('#insert-role').val()
						}
					}
				};

				var employee = {
					id : $('#insert-emp-id').val(),
					firstName : $('#insert-first-name').val(),
					lastName : $('#insert-last-name').val(),
					email : $('#insert-email').val(),
					title : $('#insert-title').val(),
					empouts : empOut,
					haveAccount : haveAkun,
					user : usr,
					active : 0
				};
				console.log(employee);
				console.log(userOK);
				console.log(emailOK);
				if (valid == true && emailOK==1 && userOK==1){
					$.ajax({
						type : 'POST',
						url : '${pageContext.request.contextPath}/mst/employee/save',
						data : JSON.stringify(employee),
						contentType : 'application/json',
						success : function() {
							window.location = '${pageContext.request.contextPath}/mst/employee';
						},
						error : function() {
							alert('save failed');
						}

					}); 
					
				 } else if(valid == true && emailOK==0 && userOK==1){
					 alert('This email has been used');
				 } else if(valid == true && emailOK==1 && userOK==0){
					 alert('This user has been used');
				 } else if(valid == true && emailOK==0 && userOK==0){
					 alert('This email and user has been used');
				 } else {
					 alert('Complete your form ');
				 }
			});

			var emailExist = '';
			var emailOK = 0;
			var userExist = '';
			var userOK = 1;
			
			$('#insert-email').on('keyup',function(){
				var email = $('#insert-email').val();
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/mst/employee/check-email?email='+email,
					success : function(data){
						console.log(email);
						if(data > 0 && email != emailExist){
							emailOK = 0;
						}else{
							emailOK = 1;
						}
					}, error : function(){
						console.log('check email failed')
					}
				});
			});
			
			$('#insert-username').on('keyup',function(){
				var user = $('#insert-username').val();
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/mst/employee/check-user?user='+user,
					success : function(data){
						console.log(data);
						if(data > 0 && $('#cb-have-account').is(":checked") && user != userExist){
							userOK = 0;
						}else{
							userOK = 1;
						}
					}, error : function(){
						console.log('check user failed')
					}
				});
			});

			//edit
			$('.update').on('click',function(evt) {
				evt.preventDefault();
				var id = $(this).attr('id');
				console.log(id);

				//ajax ambil data
				$.ajax({
					url : '${pageContext.request.contextPath}/mst/employee/get-one/'+ id,
					type : 'GET',
					dataType : 'json',
					success : function(emp) {
						console.log(emp);
						emailOK = 1;
						userOK = 1;
						setEditEmployee(emp);
						//$('input[name="cb-have-account"]').prop('checked', false);
						if (emp.haveAccount != 0 && emp.user.active == 1 ) {
							$('input[name="cb-have-account"]').prop('checked', true);
							$('#insert-user-id').val(emp.user.id);
							$('#insert-username').val(emp.user.username);
							$('#insert-pass').val(emp.user.password);
							$('#insert-role').val(emp.user.role.id);
							$('#row-user').fadeIn('fast');
						}else if(emp.haveAccount == 1 && emp.user.active == 0){
							$('input[name="cb-have-account"]').prop('checked', false);
							$('#insert-user-id').val(emp.user.id);
							$('#insert-username').val(emp.user.username);
							$('#insert-pass').val(emp.user.password);
							$('#insert-role').val(emp.user.role.id);
						/* }else if(emp.haveAccount == 0 && emp.user.active == 0){
							$('input[name="cb-have-account"]').prop('checked', false);
							$('#insert-user-id').val('');
							$('#insert-username').val('');
							$('#insert-pass').val('');
							$('#insert-role').val(''); */
						};
						if (emp.empouts != null) {
							$.each(emp.empouts,function(i, item) {
								$('#insert-empout-id').val(emp.empouts.id);
								$('input[name="select-outlet"][value="'+ emp.empouts[i].outlet.id+ '"]').prop('checked',true);
							})
						}

					},
					error : function() {
						alert('fail ambil data');
					}
				});
			});

			//set edit mahasiswa
			function setEditEmployee(emp) {
				$('#insert-emp-id').val(emp.id);
				$('#insert-first-name').val(emp.firstName);
				$('#insert-last-name').val(emp.lastName);
				$('#insert-email').val(emp.email);
				$('#insert-title').val(emp.title);
				$('#cb-have-account').val(emp.haveAccount)
			}

			$('.btn-x').on('click', function(evt) {
				evt.preventDefault();
				var id = $(this).attr('id');

				console.log(id);

				//ajax ambil data
				$.ajax({
					url : '${pageContext.request.contextPath}/mst/employee/get-one/'+ id,
					type : 'GET',
					dataType : 'json',
					success : function(emp) {
						setEditEmployee(emp);
						$('input[name="cb-have-account"]').prop('checked', false);
						if (emp.haveAccount != 0) {
							$('input[name="cb-have-account"]').prop('checked', true);
						}
						$('#delete-data').modal();
					},
					error : function() {
						alert('fail ambil data');
					}
				});
			});

			$('#btn-delete').click(function() {
				var emp = {
					id : $('#insert-emp-id').val(),
					firstName : $('#insert-first-name').val(),
					lastName : $('#insert-last-name').val(),
					email : $('#insert-email').val(),
					title : $('#insert-title').val(),
					haveAccount : $('#cb-have-account').val()
				};

				$.ajax({
					url : '${pageContext.request.contextPath}/mst/employee/update-status',
					type : 'PUT',
					data : JSON.stringify(emp),
					contentType : 'application/json',
					success : function(data) {
						window.location = '${pageContext.request.contextPath}/mst/employee';
					},
					error : function() {
						alert('update failed');
					}
				});
			});

			$('#btn-cancel').on('click', function() {
				clearForm();
			});

			function clearForm() {
				$('#insert-first-name').val('');
				$('#insert-last-name').val('');
				$('#insert-email').val('');
				$('#insert-title').val('');
				$('input[name="cb-have-account"]').prop('checked', false);
				$('#insert-role').val('');
				$('#insert-username').val('');
				$('#insert-pass').val('');
				$('#row-user').fadeOut('fast');
			}
		});
</script>

<!-- =================================================================================================================== -->

<%@ include file="/WEB-INF/view/template/master-body-top.jsp"%>

<!-- =================================================================================================================== -->


<hr>
<h6>ADD EMPLOYEE</h6>
<hr>
	<form id="form-emp">
		<div class="row">
			<div class="col-md-3">
				<input type="hidden" id="insert-emp-id" name="insert-emp-id" />
				<div class="form-group">
					<input type="text" data-parsley-required="true" pattern="([A-z0-9\s]){2,50}$" class="form-control" id="insert-first-name" placeholder="First Name">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<input type="text" data-parsley-required="true" pattern="([A-z0-9\s]){2,50}$" class="form-control" id="insert-last-name" placeholder="Last Name">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<input type="text" data-parsley-required="true" class="form-control" id="insert-email" placeholder="Email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<select name="title" data-parsley-required="true" id="insert-title" class="form-control custom-select custom-select-md">
						<option selected disabled>Title</option>
						<option value="Mr.">Mr.</option>
						<option value="Ms.">Ms.</option>
					</select>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<div class="form-group">
					<button type="button" id="btn-assign-outlet" class="btn btn-success btn-block">Assign Outlet</button>
				</div>
			</div>
			<div class="col-md-8" style="padding-top: 8px;">
				<div class="custom-control custom-checkbox">
					<input type="checkbox" class="custom-control-input" id="cb-have-account" name="cb-have-account" value="cbaccount"> 
					<label class="custom-control-label" for="cb-have-account">Create Account?</label>
				</div>
			</div>
		</div>
	
		<hr>
		<div class="row" id="row-user" style="display: none">
			<div class="col-md-3">
				<div class="form-group">
					<select name="role" id="insert-role" class="form-control custom-select custom-select-md">
						<option selected disabled>Role</option>
						<c:forEach var="role" items="${roles }">
							<option value="${role.id }">${role.name }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="col-md-3">
				<input type="hidden" id="insert-user-id"
					name="insert-user-id" />
				<div class="form-group">
					<input type="text" data-parsley-required="false" class="form-control" id="insert-username" placeholder="Username">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<input type="password" data-parsley-required="false" class="form-control" id="insert-pass" placeholder="Password">
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8"></div>
			<div class="col-md-2">
				<div class="form-group">
					<button type="button" id="btn-cancel"
						class="btn btn-success btn-block">Cancel</button>
				</div>
			</div>
			<div class="col-md-2">
				<div class="form-group">
					<button type="button" id="btn-save"
						class="btn btn-success btn-block">Save</button>
				</div>
			</div>
		</div>
	</form>
	Staff List
	<hr>
	<table id="dt-table"
		class="table table-sm table-striped table-bordered"
		cellspacing="0" width="100%">
		<thead class="thead-dark" style="text-align: center;">
			<th><center>Name</center></th>
			<th><center>Email</center></th>
			<th><center>Have Account ?</center></th>
			<th><center>Outlet Access</center></th>
			<th><center>Role</center></th>
			<th><center>#</center></th>
		</thead>
		<tbody>
			<c:forEach items="${employees }" var="emp">
				<tr>
					<td>${emp.firstName }</td>
					<td>${emp.email }</td>
					<td><center>
							<script type="text/javascript">
								if ("${emp.haveAccount }" === "false") {
									document
											.write("&times;");
								} else {
									document
											.write("&#10004;");
								}
							</script>
						</center></td>
					<td><ol>
							<c:forEach items="${emp.empouts }" var="empout">
								<li style="list-style-type: none;">${empout.outlet.name }</li>
							</c:forEach>
						</ol></td>
					<td>
						<script>
							if("${emp.haveAccount}" === "true" && "${emp.user.active}" === "true"){
									//document.write("${emp.user.role.name }");
									if("${emp.user.role.name }" == "ROLE_ADMIN"){
										document.write("Role Admin");
									}else if("${emp.user.role.name }" == "ROLE_BACK_OFFICE"){
										document.write("Role Back Office");
									}else{
										document.write("Role Cashier");
									}
								}else if("${emp.haveAccount}" === "true" && "${emp.user.active}" === "false"){
									document.write('<FONT COLOR="red">');
									document.write(' User Not Active ');
									document.write('</FONT>');
								}else{
									document.write('<FONT COLOR="red">');
									document.write("Tidak Memiliki User");
									document.write('</FONT>');
							}
						</script>
					</td>
					<td><a id="${emp.id }" class="update btn btn-info btn-sm" href="#">Edit</a> | <a id="${emp.id }" class="btn-x btn btn-danger btn-sm" href="#"> X </a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- ======================================================================================================================= -->
	
	<%@ include file="/WEB-INF/view/template/master-body-bottom.jsp"%>
	
	<!-- ======================================================================================================================= -->
	
	<!-- Call Modal -->
	<%@ include file="modal/employee/inactive-emp.jsp" %>
	<%@ include file="modal/employee/assign-outlet.jsp" %>
	
</body>
</html>