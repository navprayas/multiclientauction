
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
							<option value="ROLE_ADMIN">ADMIN</option>
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



