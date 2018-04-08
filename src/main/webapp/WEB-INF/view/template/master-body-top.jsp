</head>
<!-- =================================================================================================================== -->

<body class="hold-transition skin-green-light sidebar-mini">
	<div class="wrapper">

		<header class="main-header">
			<!-- Logo -->
			<a href="#" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
				<span class="logo-mini"><b>#</b>1</span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg"><b>KELOMPOK</b>1</span>
			</a>
			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="push-menu"
					role="button"> <span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
				</a>

				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <img
								src="${url}/dist/img/user2-160x160.jpg" class="user-image"
								alt="User Image"> <span class="hidden-xs">Kel 1 BC137</span>
						</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img
									src="${url}/dist/img/user2-160x160.jpg" class="img-circle"
									alt="User Image">

									<p>
										Kelompok 1 BC137 <small>Member since
											Mar. 2018</small>
									</p></li>
								<!-- Menu Body -->
								<li class="user-footer">
									<div class="pull-left">
										<a href="#" class="btn btn-default btn-flat">Profile</a>
									</div>
									<div class="pull-right">
										<c:url value="/j_spring_security_logout" var="logoutUrl" />
											<!-- csrt for log out-->
											<form action="${logoutUrl}" method="post" id="logoutForm">
											  <input type="hidden"
												name="${_csrf.parameterName}"
												value="${_csrf.token}" />
												<input type="submit" class="btn btn-default btn-flat" name="logout" value="Sign Out"/>
											</form>
										
										<!-- <a href="#" class="btn btn-default btn-flat">Sign out</a> -->
									</div>
								</li>
							</ul></li>
					</ul>
				</div>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="${url}/dist/img/user2-160x160.jpg" class="img-circle"
							alt="User Image">
					</div>
					<div class="pull-left info">
						<p>Kel 1 BC137</p>
						<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
					</div>
				</div>
				<!-- /.search form -->
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu" data-widget="tree">
					<li class="treeview active"><a href="#"> <i
							class="fa fa-table"></i> <span>Master Tables</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li><a href="${pageContext.request.contextPath}/mst/employee"><i class="fa fa-circle-o"></i>Employee</a></li>
							<li><a href="${pageContext.request.contextPath}/mst/item-outlet"><i class="fa fa-circle-o"></i> Item</a></li>
							<li><a href="${pageContext.request.contextPath}/mst/outlet"><i class="fa fa-circle-o"></i> Outlet</a></li>
							<li><a href="${pageContext.request.contextPath}/mst/supplier"><i class="fa fa-circle-o"></i> Supplier</a></li>
							<li><a href="${pageContext.request.contextPath}/mst/category"><i class="fa fa-circle-o"></i> Category</a></li>
						</ul>
					</li>
					<li class="treeview active"><a href="#"> <i
							class="fa fa-table"></i> <span>Transaction Tables</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li><a href="${pageContext.request.contextPath}/t/pr"><i class="fa fa-circle-o"></i> Purchase Request </a></li>
							<li><a href="${pageContext.request.contextPath}/t/po"><i class="fa fa-circle-o"></i> Purchase Order</a></li>
							<li><a href="${pageContext.request.contextPath}/t/adjustment"><i class="fa fa-circle-o"></i> Adjustment</a></li>
							<li><a href="${pageContext.request.contextPath}/t/ts"><i class="fa fa-circle-o"></i> Transfer Stock</a></li>
							<li><a href="${pageContext.request.contextPath}/t/sales-order"><i class="fa fa-circle-o"></i> Sales Order </a></li>
						</ul>
					</li>
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h2 style="text-align: center;">P O S</h2>
				<ol class="breadcrumb">
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<!-- /.box -->

						<div class="box">
							<!-- /.box-header -->
							<div class="box-body">