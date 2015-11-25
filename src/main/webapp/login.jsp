<%@ page
	import="org.springframework.security.core.AuthenticationException"%>
<%@ page
	import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/forgotPassword" var="forgotpassword_url" />
<spring:url value="/static/adminthemecontent" var="theme_url" />

<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.5 -->
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
<!-- iCheck -->
<link rel="stylesheet"
	href="${theme_url}/plugins/iCheck/square/blue.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="${theme_url}/index2.html"><b>Admin</b>auction</a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg">Sign in to start your session</p>

			<form action="<c:url value='j_spring_security_check'/>" method="post">
				<div class="form-group has-feedback">
					<input type="text" class="form-control" name='j_username'
						value='<c:if test="${not empty param.login_error}"><c:out value="${SPRING_SECURITY_LAST_USERNAME}"/></c:if>'
						placeholder="Enter Your Name"> <span
						class="glyphicon glyphicon-envelope form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="password" class="form-control" placeholder="Password"
						name="j_password"> <span
						class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="row">
					<div class="col-xs-8">
						<div class="checkbox icheck">
							<label> <input type="checkbox"> Remember Me
							</label>
						</div>
					</div>
					<!-- /.col -->
					<div class="col-xs-4">
						<button type="submit" class="btn btn-primary btn-block btn-flat">Sign
							In</button>
					</div>
					<!-- /.col -->
				</div>
			</form>

			<div class="social-auth-links text-center">
				<p>- OR -</p>
				<a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i
					class="fa fa-facebook"></i> Sign in using Facebook</a> <a href="#"
					class="btn btn-block btn-social btn-google btn-flat"><i
					class="fa fa-google-plus"></i> Sign in using Google+</a>
			</div>
			<!-- /.social-auth-links -->

			<a href="${forgotpassword_url}">I forgot my password</a><br> <a
				href="#" class="text-center">Register a new membership</a>

		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->

	<!-- jQuery 2.1.4 -->
	<script src="${theme_url}/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<!-- Bootstrap 3.3.5 -->
	<script src="${theme_url}/bootstrap/js/bootstrap.min.js"></script>
	<!-- iCheck -->
	<script src="${theme_url}/plugins/iCheck/icheck.min.js"></script>
	<script>
		$(function() {
			$('input').iCheck({
				checkboxClass : 'icheckbox_square-blue',
				radioClass : 'iradio_square-blue',
				increaseArea : '20%' // optional
			});
		});
	</script>
</body>






<%-- <%@ page
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
					<img src="${images_url}/logo.png">

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
 --%>