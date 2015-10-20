<%@ page
	import="org.springframework.security.core.AuthenticationException"%>
<%@ page
	import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/forgotPassword" var="forgotpassword_url" />
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="images/favicon.png">

<title>Signin</title>

<!-- Bootstrap core CSS -->
<link href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${css_url}/custom.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

	<!-- { header } -->
	<header class="header">
		<div class="container">
			<div class="col-xs-12 col-sm-3 hdr-lft">
				<div class="hdr-lft-in">
					<img src="${images_url}/logo.png">

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
					<%-- <img src="${images_url}/logo.png"> --%>

				</div>
			</div>
		</div>
		<div class="strip-bar"></div>
	</header>

	<!-- { middle } -->
	<section class="main">
		<div class="container">
			<div class="form-container">
				<h1>
					<i class="fa fa-sign-in"></i> Sign In
				</h1>
				<form role="form" method="post"
					action="<c:url value='j_spring_security_check'/>">
					<div class="form-group">
						<label for="exampleInputName">User Name</label> <input type="text"
							class="form-control" name='j_username'
							value='<c:if test="${not empty param.login_error}"><c:out value="${SPRING_SECURITY_LAST_USERNAME}"/></c:if>'
							placeholder="Enter Your Name">
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">Password</label> <input
							type="password" name="j_password" class="form-control"
							id="exampleInputPassword1" placeholder="Password">
					</div>
					<div class="form-group form-submit">
						<a href="${forgotpassword_url}">Forget Password</a>
						<button type="submit" class="btn btn-primary pull-right">Sign
							In</button>
						<div class="clearfix"></div>
					</div>
				</form>
			</div>
		</div>
		<!-- /container -->
	</section>

	<!-- { footer } -->
	<footer class="footer">
		<div class="container">
			<div class="col-xs-12 col-sm-6 copyrgt">
				<p>Copyright &copy; 2015 Navprayas</p>
			</div>
			<div class="col-xs-12 col-sm-6 poweredby text-right">
				<p>
					Developed By: <a href="http://cfeindia.com/">CFE India</a>
				</p>
			</div>
		</div>
	</footer>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="${js_url}/bootstrap.min.js"></script>
	<script src="${js_url}/ie10-viewport-bug-workaround.js"></script>
</body>
