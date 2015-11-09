
<%@page import="com.navprayas.bidding.common.constant.CommonConstants"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/static/adminthemecontent" var="theme_url" />
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">


		<!-- Left side column. contains the logo and sidebar -->


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Admin <small>Home</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>Admin -
							Dashboard</a></li>
					<li class="active">Dashboard</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<!-- left column -->
					<div class="col-md-6">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">Reset Password</h3>
							</div>



							<form role="form" id="resetPasswordForm" name="resetPasswordForm"
								method="Post" action="admin/resetPassword">
								<div class="box-body">
									<div class="form-group">
										<label for="exampleInputEmail1">User Id</label> <input
											type="text" class="form-control" placeholder="USER Id"
											name="username" id="username">
									</div>


									<div class="form-group">
										<label for="exampleInputEmail1"> New Password</label> <input
											type="password" class="form-control"
											placeholder="New Password" name="password" id="password">
									</div>


									<div class="form-group">
										<label for="exampleInputEmail1">Confirm Password</label> <input
											type="password" class="form-control"
											placeholder=" Confirm Password" name="Cnfpass" id="Cnfpass">
									</div>

								</div>
								<!-- /.box-body -->

								<div class="box-footer">
									<button type="button" name="button" id="button"
										onclick="checkPassword();" class="btn btn-primary">Reset
										Password</button>
								</div>
							</form>

						</div>
					</div>

				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->



	</div>
	<!-- ./wrapper -->

</body>



<script>
	function checkPassword() {

		var Newpass = document.getElementById("password").value;
		var Cnfpass = document.getElementById("Cnfpass").value;
		var userName = document.getElementById("username").value;

		if (userName == "") {
			alert("User Id Cannot Be Blank!!")
			return false;
		}
		if (Newpass == "" || Cnfpass == "") {
			alert("Passowrd Fields Cannot Be Blank!!")
			return false;
		} else if (Newpass != Cnfpass) {
			alert("Both New Password Should be Identical!!")
			return false;
		} else if (Newpass.length < 4) {
			alert("New Password Should be atleast 4 charater long.!")
			return false;
		} else {
			document.resetPasswordForm.submit();
		}
	}
</script>



<%-- <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/admin/superAdmin" var="admin_url" />
<body>
	<!-- { middle } -->
	<section class="main">
		<div class="container">
			<div class="form-container">
				<h1>
					<i class="fa fa-sign-in"></i> Forgot Password
				</h1>
				<c:if test="${not empty resetPasswordMessage}">
					<c:out value="${resetPasswordMessage}" />.
				</c:if>


				<form role="form" id="resetPasswordForm" name="resetPasswordForm"
					method="Post" action="admin/resetPassword">

					<div class="form-group">
						<label for="exampleInputPassword1">User Id</label> <input
							type="text" class="form-control" placeholder="USER Id"
							name="username" id="username">
					</div>

					<div class="form-group">
						<div class="form-group">
							<label for="exampleInputPassword1">New Password</label> <input
								type="password" class="form-control" placeholder="New Password"
								name="password" id="password">


						</div>

					</div>
					<div class="form-group">
						<div class="form-group">
							<label for="exampleInputPassword1">Confirm Password</label> <input
								type="password" class="form-control"
								placeholder=" Confirm Password" name="Cnfpass" id="Cnfpass">
						</div>
					</div>
					<div class="form-group form-submit">

						<button type="button" class="btn btn-primary pull-right"
							name="button" id="button" onclick="checkPassword();">Reset Password</button>
							
						<div class="clearfix"></div>
					</div>
				</form>
			</div>
		</div>
		<!-- /container -->
	</section>

</body>

<script>
	function checkPassword() {

		var Newpass = document.getElementById("password").value;
		var Cnfpass = document.getElementById("Cnfpass").value;
		var userName = document.getElementById("username").value;

		if (userName == "") {
			alert("User Id Cannot Be Blank!!")
			return false;
		}
		if (Newpass == "" || Cnfpass == "") {
			alert("Passowrd Fields Cannot Be Blank!!")
			return false;
		} else if (Newpass != Cnfpass) {
			alert("Both New Password Should be Identical!!")
			return false;
		} else if (Newpass.length < 4) {
			alert("New Password Should be atleast 4 charater long.!")
			return false;
		} else {
			document.resetPasswordForm.submit();
		}
	}
</script>

 --%>