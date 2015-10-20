


<%@page import="com.navprayas.bidding.common.constant.CommonConstants"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/static/js" var="js_url" />
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<spring:url value="/static/pdf" var="pdf_url" />
<spring:url value="/" var="home_url" />
<spring:url value="/bidder" var="bidder_home_url" />
<spring:url value="bidder/bidderReport" var="bidder_report_url" />
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
<link href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet">
<link type="text/css" href="${css_url}/custom.css" rel="stylesheet" />
<script type="text/javascript" src="${js_url}/json.min.js"></script>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>

<script type='text/javascript' src='/bidding/dwr/engine.js'>
	
</script>
<script type='text/javascript' src='/bidding/dwr/util.js'>
	
</script>
<script>
	function getPageForMarketType(marketType) {
		var location1 = ""
		if (marketType == "1")
			location1 = "${bidder_home_url}/marketlist";
		else if (marketType == "2")
			location1 = "${bidder_home_url}/active";
		else if (marketType == "3")
			location1 = "${bidder_home_url}/closed";
		window.location.href = location1;
	}
</script>
<!-- Bootstrap core CSS -->
<link href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet">
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<!-- Custom styles for this template -->
<link href="${css_url}/custom.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>


<!-- { header } -->
<header class="header">
	<div class="container">
		<div class="col-xs-12 col-sm-3 hdr-lft">
			<div class="hdr-lft-in">
				<img
					src="${images_url}/companylogos/<%=session.getAttribute(CommonConstants.CLIENTID)%>-ltd.png">
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 hdr-mdl">
			<div class="hdr-mdl-in">
				<marquee scrollamount="2" onmouseover="stop();"
					onmouseout="start();">
					<!-- In case of any technical
					difficulties, please contact support at +912225970344 -->
					Welcome To Online Auction Service Portal
				</marquee>
			</div>
		</div>
		<div class="col-xs-12 col-sm-3 hdr-rgt">
			<div class="hdr-rgt-in text-right">
				<%-- <img
					src="${images_url}/companylogos/<%=session.getAttribute(CommonConstants.CLIENTID)%>-logo.png">
		 --%>	</div>
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
						<li class="active"><a href="${bidder_home_url}/home"
							onMouseover="ddrivetip('Forward Market Price','', 'auto')"
							;
onMouseout="hideddrivetip()">Forward Market</a></li>
						<li><a href="${bidder_home_url}/bidderReport"
							onMouseover="ddrivetip('Won Bids','', 'auto')"
							;
onMouseout="hideddrivetip()">Won Bids</a></li>
						<li><a href="${pdf_url}/termandcondition.pdf" target="_blank"
							onMouseover="ddrivetip('General Terms &amp; Condition','', 'auto')"
							;
onMouseout="hideddrivetip()">General Terms &amp; Condition</a></li>
						<li><a href="${home_url}changepass" class="ui-corner-all"
							onMouseover="ddrivetip('Change Password','', 'auto')"
							;
onMouseout="hideddrivetip()">Change Password</a></li>
						<li><a href="#"
							onMouseover="ddrivetip('Coming Soon','', 'auto')"
							;
onMouseout="hideddrivetip()">Help</a></li>

					</ul>
				</div>
				<!--/.nav-collapse -->
				<div class="welcom">
					<ul class="list-inline">
						<li>Welcome |</li>
						<li><security:authentication property="principal.username" />
							&nbsp;| &nbsp; <a href="<c:url value="/j_logout"/>"
							class="logout">Logout</a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
</header>






<%-- <%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/js" var="js_url" />
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<spring:url value="/static/pdf" var="pdf_url" />
<spring:url value="/" var="home_url" />
<spring:url value="/bidder" var="bidder_home_url" />
<script type="text/javascript" src="${js_url}/json.min.js"></script>
<spring:url value="bidder/bidderReport" var="bidder_report_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
</head>
<body>
	<div class="Top">
		<div class="Logo">
			<span class="MahaLogo"><img
				src="${images_url}/maharashtra-seamless-ltd.png" width="241"
				height="76"></span>
		</div>
		<div class="Scroll">
			<marquee scrollamount="2" onMouseOver="stop();" onMouseOut="start();">
				In case of any technical difficulties, please contact support at
				+912225970344 </marquee>
		</div>
		<div class="JindalLogo">
			<img src="${images_url}/jindal-logo.png" width="164" height="40">
		</div>
	</div>

	<div class="MenuMain">
		<div class="MenuBtnselected">
			<a href="${bidder_home_url}/home"
				onMouseover="ddrivetip('Forward Market Price','', 'auto')"
				;
onMouseout="hideddrivetip()">Forward Market</a>
		</div>
		<div class="MenuBtn">
			<a href="${bidder_home_url}/bidderReport"
				onMouseover="ddrivetip('Won Bids','', 'auto')"
				;
onMouseout="hideddrivetip()">Won Bids</a>
		</div>
		<div class="MenuBtn">
			<a href="${pdf_url}/termandcondition.pdf" target="_blank"
				onMouseover="ddrivetip('General Terms &amp; Condition','', 'auto')"
				;
onMouseout="hideddrivetip()">General Terms &amp; Condition</a>
		</div>

		<div class="MenuBtn">
			<a href="${home_url}changepass" class="ui-corner-all"
				onMouseover="ddrivetip('Change Password','', 'auto')"
				;
onMouseout="hideddrivetip()">Change Password</a>
		</div>

		<div class="MenuBtn">
			<a href="#" onMouseover="ddrivetip('Coming Soon','', 'auto')";
onMouseout="hideddrivetip()">Help</a>
		</div>
		<div class="WelcomeUser">
			Welcome
			<security:authentication property="principal.username" />
			&nbsp;| &nbsp; <a href="<c:url value="/j_logout"/>" class="logout">Logout</a>
		</div>

	</div>
</body>
</html>



 --%>

