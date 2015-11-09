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
								<h3 class="box-title">Upload Bid Item</h3>
							</div>



							<form role="form" id="usersForm" name="usersForm" method="post"
								action="registration" modelAttribute="usersForm">
								<div class="box-body">
									<div class="form-group">
										<label for="exampleInputEmail1">First Name</label> <input
											name="firstName" id="firstName" placeholder="First Name"
											class="form-control">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">Middle Name</label> <input
											name="middleName" id="middleName" placeholder="Middle Name"
											class="form-control">
									</div>

									<div class="form-group">
										<label for="exampleInputEmail1">Last Name</label> <input
											type="text" class="form-control" name="lastName"
											id="lastName" placeholder="Last Name">
									</div>

									<div class="form-group">
										<label for="exampleInputEmail1">Age</label> <input type="text"
											class="form-control" name="age" id="age" placeholder="Age">
									</div>

									<div class="form-group">
										<label for="exampleInputEmail1">Gender</label> <select
											class="form-control" name="gender" id="gender">
											<option value="0">select</option>
											<option value="Male">Male</option>
											<option value="Female">Female</option>
										</select>
									</div>


									<div class="form-group">
										<label for="exampleInputEmail1">Email</label> <input
											type="email" class="form-control" name="email" id="email"
											placeholder="Email">
									</div>

									<div class="form-group">
										<label for="inputphone2">Phone</label> <input type="text"
											class="form-control" name="phone" id="phone"
											placeholder="Phone Number">
									</div>

									<div class="form-group">
										<label for="inputphone2">Mobile</label> <input type="text"
											class="form-control" name="mobile" id="mobile"
											placeholder="Mobile Number">
									</div>

									<div class="form-group">
										<label for="inputphone2">User Id</label> <input type="text"
											class="form-control" name="username" id="username"
											placeholder="User Id">
									</div>


									<div class="form-group">
										<label for="inputPassword4">Password</label> <input
											type="password" class="form-control" name="password"
											id="password" placeholder="Password">
									</div>

									<div class="form-group">
										<label for="inputPassword5">Confirm Password</label> <input
											type="password" class="form-control" name="Cnfpass"
											id="Cnfpass" placeholder="Confirm Password">

									</div>
									<div class="form-group">
										<label for="inputrole2">Role</label> <select
											class="form-control" name="role" id="role">
											<option value="0">select</option>
											<option value="ROLE_BIDDER" selected="selected">BIDDER</option>
											<option value="ROLE_OBSERVER">OBSERVER</option>
											<option value="ROLE_SUPER_ADMIN">SUPERADMIN</option>
										</select>

									</div>










								</div>
								<!-- /.box-body -->

								<div class="box-footer">
									<button type="button" class="btn btn-primary" id="button"
										name="button" onclick="checkLogin();">Submit</button>
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







<%-- 


<section class="main">
	<div class="container">
		<div class="form-container form-container-cr user-registraton">

			<h1>
				<i class="fa fa-user"></i> User Registration
			</h1>
			<form class="form-horizontal" id="usersForm" name="usersForm"
				method="post" action="registration" modelAttribute="usersForm">
				<%
					if (request.getParameter("registrationMessage") != null) {
				%>

				<div class="form-group">

					<div class="col-xs-12 col-sm-8">
						<%
							out.println(request.getParameter("registrationMessage"));
						%>
					</div>
				</div>


				<%
					}
				%>







				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">First
						Name</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="firstName"
							id="firstName" placeholder="First Name">
					</div>
				</div>
				<div class="form-group">
					<label for="inputname3" class="col-xs-12 col-sm-4 control-label">Middle
						Name</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="middleName"
							id="middleName" placeholder="Middle Name">
					</div>
				</div>
				<div class="form-group">
					<label for="inputname4" class="col-xs-12 col-sm-4 control-label">Last
						Name</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="lastName"
							id="lastName" placeholder="Last Name">
					</div>
				</div>
				<div class="form-group">
					<label for="inputage2" class="col-xs-12 col-sm-4 control-label">Age</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="age" id="age"
							placeholder="Age">
					</div>
				</div>
				<div class="form-group">
					<label for="inputgender2" class="col-xs-12 col-sm-4 control-label">Gender</label>
					<div class="col-xs-12 col-sm-8">
						<select class="form-control" name="gender" id="gender">
							<option value="0">select</option>
							<option value="Male">Male</option>
							<option value="Female">Female</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail4" class="col-xs-12 col-sm-4 control-label">Email</label>
					<div class="col-xs-12 col-sm-8">
						<input type="email" class="form-control" name="email" id="email"
							placeholder="Email">
					</div>
				</div>
				<div class="form-group">
					<label for="inputphone2" class="col-xs-12 col-sm-4 control-label">Phone</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="phone" id="phone"
							placeholder="Phone Number">
					</div>
				</div>
				<div class="form-group">
					<label for="inputmobile2" class="col-xs-12 col-sm-4 control-label">Mobile</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="mobile" id="mobile"
							placeholder="Mobile Number">
					</div>
				</div>
				<div class="form-group">
					<label for="inputuserid2" class="col-xs-12 col-sm-4 control-label">User
						Id</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="username"
							id="username" placeholder="User Id">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword4"
						class="col-xs-12 col-sm-4 control-label">Password</label>
					<div class="col-xs-12 col-sm-8">
						<input type="password" class="form-control" name="password"
							id="password" placeholder="Password">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword5"
						class="col-xs-12 col-sm-4 control-label">Confirm Password</label>
					<div class="col-xs-12 col-sm-8">
						<input type="password" class="form-control" name="Cnfpass"
							id="Cnfpass" placeholder="Confirm Password">
					</div>
				</div>
				<div class="form-group">
					<label for="inputrole2" class="col-xs-12 col-sm-4 control-label">Role</label>
					<div class="col-xs-12 col-sm-8">
						<select class="form-control" name="role" id="role">
							<option value="0">select</option>
							<option value="ROLE_BIDDER" selected="selected">BIDDER</option>
							<option value="ROLE_OBSERVER">OBSERVER</option>
							<option value="ROLE_SUPER_ADMIN">SUPERADMIN</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-8">
						<button type="button" class="btn btn-primary" id="button"
							name="button" onclick="checkLogin();">Submit</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- /container -->
</section>

<script>
	function checkLogin() {

		var firstName = document.getElementById("firstName").value;
		var lastName = document.getElementById("lastName").value;
		var userName = document.getElementById("username").value;
		var Newpass = document.getElementById("password").value;
		var Cnfpass = document.getElementById("Cnfpass").value;
		var email = document.getElementById("email").value;

		if (firstName == "") {
			alert("First Name Cannot Be Blank.")
			return false;
		}
		if (lastName == "") {
			alert("Last Name Cannot Be Blank.")
			return false;
		}

		if (email == "") {
			alert("email Cannot Be Blank.")
			return false;
		}

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
			document.usersForm.submit();
		}
	}
</script>



 --%>