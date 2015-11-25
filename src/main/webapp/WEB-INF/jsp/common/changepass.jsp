
<%@page import="com.navprayas.bidding.common.constant.CommonConstants"%>
<html lang="en">
<%@ page
	import="org.springframework.security.core.AuthenticationException"%>
<%@ page
	import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/users/forgotPassword" var="forgotpassword_url" />
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">


		<!-- Left side column. contains the logo and sidebar -->


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Admin <small>Change Password</small>
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



							<form role="form" method="Post" action="changepassword"
								id="ChangePasswordForm" name="ChangePasswordForm">
								<div class="box-body">
									<div class="form-group">
										<label for="exampleInputEmail1">Old Password</label> <input
											type="password" class="form-control"
											placeholder="Old Password" name="Oldpass" id="Oldpass">
									</div>


									<div class="form-group">
										<label for="exampleInputEmail1"> New Password</label> <input
											type="password" class="form-control"
											placeholder="New Password" name="Newpass" id="Newpass">
									</div>


									<div class="form-group">
										<label for="exampleInputEmail1">Confirm Password</label> <input
											type="password" class="form-control"
											placeholder="Confirm Password" name="Cnfpass" id="Cnfpass">
									</div>

								</div>
								<!-- /.box-body -->

								<div class="box-footer">
									<button type="button" name="button" id="button"
										onclick="checkPassword();" class="btn btn-primary">
										Change Password</button>
									<a href="login.jsp" class="btn btn-primary">Login Again</a>
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


<script type="text/javascript">
	function checkPassword() {
		var Oldpass = document.getElementById("Oldpass").value;
		var Newpass = document.getElementById("Newpass").value;
		var Cnfpass = document.getElementById("Cnfpass").value;
		if (Oldpass == "" || Newpass == "" || Cnfpass == "") {
			alert("Fields Cannot Be Blank!!");
			return false;
		} else if (Newpass != Cnfpass) {
			alert("Both New Password Should be Identical!!");
			return false;
		} else if (Newpass.length < 4) {
			alert("New Password Should be atleast 4 charater long.!");
			return false;
		} else {
			//document.ChangePasswordForm.action = 'changepassword'; 
			document.ChangePasswordForm.submit();
			//return true;
		}
	}

	function goBack() {

		window.history.back(-1);
	}
</script>