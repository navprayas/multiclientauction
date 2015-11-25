<%@page import="com.navprayas.bidding.common.constant.CommonConstants"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/report/observerSummary1" var="report_summary1_url" />
<spring:url value="/" var="home_url" />
<spring:url value="/observer" var="observer_home_url" />
<spring:url value="/static/pdf" var="pdf_url" />
<spring:url value="/" var="home_url" />
<link rel="stylesheet"
	href="${theme_url}/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${theme_url}/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="${theme_url}/dist/css/skins/all-skins.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="${theme_url}/plugins/iCheck/flat/blue.css">
<link rel="stylesheet" href="${theme_url}/plugins/iCheck/all.css">
<link rel="stylesheet" href="${theme_url}/plugins/iCheck/_all.css">
<link rel="stylesheet"
	href="${theme_url}/plugins/iCheck/prettyCheckable.css">

<!-- Morris chart -->
<link rel="stylesheet" href="${theme_url}/plugins/morris/morris.css">
<!-- jvectormap -->
<link rel="stylesheet"
	href="${theme_url}/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
<!-- Date Picker -->
<link rel="stylesheet"
	href="${theme_url}/plugins/datepicker/datepicker3.css">
<!-- Daterange picker -->
<link rel="stylesheet"
	href="${theme_url}/plugins/daterangepicker/daterangepicker-bs3.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet"
	href="${theme_url}/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->



<!-- jQuery 2.1.4 -->
<script src="${theme_url}/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="${theme_url}/bootstrap/js/bootstrap.min.js"></script>


<!-- DataTables -->
<script src="${theme_url}/plugins/datatables/jquery.dataTables.min.js"></script>
<script
	src="${theme_url}/plugins/datatables/dataTables.bootstrap.min.js"></script>


<!-- FastClick -->
<script src="${theme_url}/plugins/fastclick/fastclick.min.js"></script>
<!-- AdminLTE App -->
<script src="${theme_url}/dist/js/app.min.js"></script>
<!-- Sparkline -->
<script src="${theme_url}/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script
	src="${theme_url}/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script
	src="${theme_url}/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="${theme_url}/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- ChartJS 1.0.1 -->
<script src="${theme_url}/plugins/chartjs/Chart.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->









<header class="main-header">

	<!-- Logo -->
	<a href="${admin_home_url}" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
		<span class="logo-mini"><b>A</b>Auction</span> <!-- logo for regular state and mobile devices -->
		<span class="logo-lg"><b>Bidder</b> Auction</span>
	</a>

	<!-- Header Navbar: style can be found in header.less -->
	<nav class="navbar navbar-static-top" role="navigation">
		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
			role="button"> <span class="sr-only">Toggle navigation</span>
		</a>
		<!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">

				<!-- User Account: style can be found in dropdown.less -->
				<li class="dropdown user user-menu"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <img
						src="${images_url}/companylogos/<%=session.getAttribute(CommonConstants.CLIENTID)%>-ltd.png"
						class="user-image" alt="User Image"> <span class="hidden-xs">Auction</span>
				</a>
					<ul class="dropdown-menu">
						<!-- User image -->
						<li class="user-header"><img
							src="${images_url}/companylogos/<%=session.getAttribute(CommonConstants.CLIENTID)%>-ltd.png"
							class="img-circle" alt="User Image">
							<p>
								<security:authentication property="principal.username" />
								<small>Observer Member</small>
							</p></li>
						<!-- Menu Footer-->
						<li class="user-footer">
							<div class="pull-left">
								<a href="#" class="btn btn-default btn-flat">Profile</a>
							</div>
							<div class="pull-right">
								<a href="<c:url value="/j_logout"/>"
									class="btn btn-default btn-flat">Sign out</a>
							</div>
						</li>
					</ul></li>
			</ul>
		</div>
	</nav>
</header>


<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<img
					src="${images_url}/companylogos/<%=session.getAttribute(CommonConstants.CLIENTID)%>-ltd.png"
					class="img-circle" alt="User Image">
			</div>
			<div class="pull-left info">
				<p>Admin - Auction</p>
				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu">
			<li class="header">MAIN NAVIGATION</li>


			<%-- <li class="active"><a href="${observer_home_url}/home">Forward
							Market</a></li>
					<li><a href="${report_summary1_url}">Report</a></li>
					<li><a href="${home_url}changepass">Change Password</a></li>
					<li><a href="${pdf_url}/termandcondition.pdf" target="_blank">General
							Terms & Conditions</a></li> --%>


			<li class="active treeview"><a href="${observer_home_url}/home">
					<i class="fa fa-table"></i> <span>Forward Market</span> <i
					class="fa fa-angle-left pull-right"></i>
			</a></li>
			<li class="treeview"><a href="${report_summary1_url}"> <i
					class="fa fa-dashboard"></i> <span>Report</span> <i
					class="fa fa-angle-left pull-right"></i>
			</a></li>
			<li class="treeview"><a href="${pdf_url}/termandcondition.pdf"
				target="_blank"> <i class="fa fa-laptop"></i> <span>General
						Terms &amp; Condition</span> <i class="fa fa-angle-left pull-right"></i>
			</a></li>
			<li class="treeview"><a href="${home_url}changepass"> <i
					class="fa fa-laptop"></i> <span>Change Password</span> <i
					class="fa fa-angle-left pull-right"></i>
			</a></li>



		</ul>
	</section>
	<!-- /.sidebar -->
</aside>
















<%-- <%@page import="com.navprayas.bidding.common.constant.CommonConstants"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/report/observerSummary1" var="report_summary1_url" />
<spring:url value="/" var="home_url" />
<spring:url value="/observer" var="observer_home_url" />
<spring:url value="/static/pdf" var="pdf_url" />
<spring:url value="/" var="home_url" />
<link href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${css_url}/custom.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="${css_url}/dhtmlgoodies_calendar.css?random=20051112"
	media="screen"></link>

<script type="text/javascript"
	src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="${js_url}/csspopup.js"></script>
<link href="${css_url}/menu.css" rel="stylesheet" media="screen" />

<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript" src="${js_url}/json.min.js"></script>
<script type='text/javascript' src='/bidding/dwr/engine.js'></script>
<script type='text/javascript' src='/bidding/dwr/util.js'></script>
<link type="text/css" rel="stylesheet"
	href="${css_url}/dhtmlgoodies_calendar.css?random=20051112"
	media="screen"></link>
<script type="text/javascript"
	src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>

<link type="text/css" href="${css_url}/custom.css" rel="stylesheet" />
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>



<script>
	function getPageForMarketType(marketType) {
		var location1 = ""
		if (marketType == "1")
			location1 = "${observer_home_url}/marketlist";
		else if (marketType == "2")
			location1 = "${observer_home_url}/active";
		else if (marketType == "3")
			location1 = "${observer_home_url}/closed";
		window.location.href = location1
	}
</script>

<div class="container">
	<div class="col-xs-12 col-sm-3 hdr-lft">
		<div class="hdr-lft-in">
			<img
				src="${images_url}/companylogos/<%=session.getAttribute(CommonConstants.CLIENTID)%>-ltd.png">
		</div>
	</div>
	<div class="col-xs-12 col-sm-6 hdr-mdl">
		<div class="hdr-mdl-in">
			<marquee scrollamount="2" onmouseover="stop();" onmouseout="start();">
				<!-- In case of any technical difficulties, please contact support at
				+912225970344 -->
				Welcome To Online Auction Service Portal
			</marquee>
		</div>
	</div>
	<div class="col-xs-12 col-sm-3 hdr-rgt">
		<div class="hdr-rgt-in text-right">
			<img
				src="${images_url}/companylogos/<%=session.getAttribute(CommonConstants.CLIENTID)%>-logo.png">
	
		</div>
	</div>
</div>
<div class="strip-bar">
	<div class="container">
		<nav class="navbar">
			<div class="navbar-header">
				<button aria-controls="navbar" aria-expanded="false"
					data-target="#navbar" data-toggle="collapse"
					class="navbar-toggle collapsed" type="button">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
			</div>
			<div class="navbar-collapse collapse" id="navbar">
				<ul class="nav navbar-nav auction-menu">
					<li class="active"><a href="${observer_home_url}/home">Forward
							Market</a></li>
					<li><a href="${report_summary1_url}">Report</a></li>
					<li><a href="${home_url}changepass">Change Password</a></li>
					<li><a href="${pdf_url}/termandcondition.pdf" target="_blank">General
							Terms & Conditions</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
			<div class="welcom">
				<ul class="list-inline ">
					<li>Welcome <security:authentication
							property="principal.username" /></li>
					<li><a href="<c:url value="/j_logout"/>">Logout</a></li>
				</ul>
			</div>
		</nav>
	</div>
</div>


 --%>