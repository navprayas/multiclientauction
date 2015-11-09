
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/admin/initcache" var="admin_initcache_url" />
<spring:url value="admin/closeAuction" var="close_auction_url" />


<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">


		<!-- Left side column. contains the logo and sidebar -->


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Auction Mapping <small>user</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>Admin
							Auction</a></li>
					<li class="active">User Mapping</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
								<h4 class="box-title">Select Auction</h4>
								&nbsp;&nbsp;&nbsp;&nbsp;<select
									name="auction" id="auction">
									<option value="-1">Select</option>
									<c:forEach var="auction1" items="${AuctionList}">
										<option id="${auction1.auctionId}"
											value="${auction1.auctionId}">
											<c:out value="${auction1.name}" />
										</option>
									</c:forEach>
								</select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<h4 class="box-title">Select Category</h4>
								&nbsp;&nbsp;&nbsp;&nbsp; <input
									type="checkbox" id="CategoriesList" name="CategoriesList"
									class="CategoriesList"> Select All
								<c:forEach var="category" items="${CategoryList}">
									<input type="checkbox" id="${category.categoryId}"
										name="Categories" class="categoriesclass">${category.categoryName}
				                  </c:forEach>




							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example2" class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>Sr. No.</th>
											<th>Select All <input type="checkbox" name="selectAll"
												id="selectAll" onclick="selectAllUser();"></th>
											<th>User Name</th>
											<th>Full Name</th>
											<th>Email</th>


										</tr>
									</thead>
									<tbody>



										<c:forEach items="${UserList}" var="user" varStatus="status">
											<tr>
												<td>${status.index+1}</td>
												<td align="center"><input type="checkbox"
													id="${user.userId}" name="Users" class="minimal"></td>





												<td>${user.username}</td>
												<td>${user.name}</td>
												<td>${user.email}</td>
											</tr>
										</c:forEach>




									</tbody>
									<tfoot>
										<tr>
											<th>Sr. No.</th>
											<th>Select All <input type="checkbox" name="selectAll"
												id="selectAll" onclick="selectAllUser();"></th>
											<th>User Name</th>
											<th>Full Name</th>
											<th>Email</th>

										</tr>
									</tfoot>
								</table>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
				</div>


			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->



	</div>
	<!-- ./wrapper -->

</body>


<script>
	$(function() {
		$('#example2').DataTable({
			"paging" : true,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"info" : true,
			"autoWidth" : true
		});
	});

	var message ='<%=request.getParameter("Message")%>';

	if (message && message != 'null') {
		alert(message);
	}

	function setValuesAndSubmit() {
		var auctionId = document.getElementById("auction").value;
		document.getElementById("selectedAuctionId").value = auctionId;

		var catList = getValues("Categories");
		document.getElementById("selectedCategoryIdList").value = catList;

		var userList = getValues("Users");
		document.getElementById("selectedUserIdList").value = userList;
		if (!auctionId) {
			alert("auction needs to be Selected");
			return false;
		}
		if (catList.length == 0) {
			alert("categories need to be Selected");
			return false;
		}
		if (userList.length == 0) {
			alert("users need to be Selected");
			return false;
		}

		document.forms["auctionmapform"].submit();
	}

	function getValues(objName) {
		var results = "";
		var arr = new Array();
		arr = document.getElementsByName(objName);

		for (var i = 0; i < arr.length; i++) {
			var obj = document.getElementsByName(objName).item(i);

			if (i > 0 && obj.checked && results.length > 0) {
				results += "$";
			}
			if (obj.checked) {
				results += obj.getAttribute("id");
			}
		}
		return results;
	}
	$(document).ready(function() {
		$('#selectAll').on('click', function() {
			if ($(this).is(':checked')) {
				$('.minimal').each(function() {
					this.checked = true;
				});
			} else {
				$('.minimal').each(function() {
					this.checked = false;
				});
			}
		})
	});

	$(document).ready(function() {
		$('#CategoriesList').on('click', function() {
			if ($(this).is(':checked')) {
				$('.categoriesclass').each(function() {
					this.checked = true;
				});
			} else {
				$('.categoriesclass').each(function() {
					this.checked = false;
				});
			}
		})
	});
</script>

















<%-- 


<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/admin/initcache" var="admin_initcache_url" />
<spring:url value="admin/closeAuction" var="close_auction_url" />
<body>
	<!-- { middle } -->
	<section class="main">
		<div class="container">
			<div class="table-container">
				<div class="top-line">
					<div class="col-xs-12 col-sm-6 nopad">
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a
								aria-controls="home" role="tab" data-toggle="tab"
								href="#summary">User Auction Mapping</a></li>
							<!-- <li><a aria-controls="home" role="tab" data-toggle="tab"
								href="#bidder">Bidder Wise</a></li> -->
						</ul>
					</div>
					<div class="clearfix"></div>
				</div>
				<!-- { tab-Effects } -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="summary">
						<!-- <div class="mark-check1">
							<div class="col-sx-12 col-sm-12 select-date">
								<form role="form">
									<div class="col-xs-12 col-sm-4 col-md-3 col-lg-2 tetrt">
										Select Date:&nbsp; <span>Form</span>
									</div>
									<div class="col-xs-12 col-sm-3 col-md-3 col-lg-2">
										<input type="date" placeholder="Date" id="inputdate31"
											class="form-control">
									</div>
									<div class="col-xs-12 col-sm-1 tetrt">To</div>
									<div class="col-xs-12 col-sm-3 col-md-3 col-lg-2">
										<input type="date" placeholder="Date" id="inputdate41"
											class="form-control">
									</div>
									<div class="col-xs-12 col-sm-1 col-md-2 col-lg-2">
										<input type="button" class="btn btn-primary" Value="Go">
									</div>
								</form>
							</div>
						</div> -->
						<div class="table-responsive user-map">
							<table class="table table-bordered table-striped text-center">
								<tr>
									<td colspan="3"><select name="auction" id="auction">
											<option value="-1">Select</option>
											<c:forEach var="auction1" items="${AuctionList}">
												<option id="${auction1.auctionId}"
													value="${auction1.auctionId}">
													<c:out value="${auction1.name}" />
												</option>
											</c:forEach>
									</select></td>
									<td colspan="2"><input type="checkbox" id="CategoriesList"
										name="CategoriesList" class="CategoriesList"> Select
										All <c:forEach var="category" items="${CategoryList}">
											<input type="checkbox" id="${category.categoryId}"
												name="Categories" class="categoriesclass">${category.categoryName}
				</c:forEach></td>
								</tr>
								<tr>

									<th>Sr. No.</th>
									<th>Select All <input type="checkbox" name="selectAll"
										id="selectAll" onclick="selectAllUser();"></th>
									<th>User Name</th>
									<th>Full Name</th>
									<th>Email</th>
								</tr>
								<c:forEach items="${UserList}" var="user" varStatus="status">
									<tr>
										<td>${status.index+1}</td>
										<td><input type="checkbox" id="${user.userId}"
											name="Users" class="username"></td>
										<td>${user.username}</td>
										<td>${user.name}</td>
										<td>${user.email}</td>
									</tr>
								</c:forEach>
								<tr>
									<td colspan="5" align="center"><form
											action="auctionmapping" name="auctionmapform" method="post">
											<table>
												<tr>
													<td><input type="hidden" id="selectedAuctionId"
														name="selectedAuctionId" /> <input type="hidden"
														id="selectedCategoryIdList" name="selectedCategoryIdList" />
														<input type="hidden" id="selectedUserIdList"
														name="selectedUserIdList" /></td>
													<td></td>
													<td align="right"><input type="button" value="Submit"
														onclick="setValuesAndSubmit()" /></td>
												</tr>
											</table>

										</form></td>
								</tr>

							</table>



						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /container -->
	</section>


</body>


<script>
	var message ='<%=request.getParameter("Message")%>';

	if (message && message != 'null') {
		alert(message);
	}

	function setValuesAndSubmit() {
		var auctionId = document.getElementById("auction").value;
		document.getElementById("selectedAuctionId").value = auctionId;

		var catList = getValues("Categories");
		document.getElementById("selectedCategoryIdList").value = catList;

		var userList = getValues("Users");
		document.getElementById("selectedUserIdList").value = userList;
		if (!auctionId) {
			alert("auction needs to be Selected");
			return false;
		}
		if (catList.length == 0) {
			alert("categories need to be Selected");
			return false;
		}
		if (userList.length == 0) {
			alert("users need to be Selected");
			return false;
		}

		document.forms["auctionmapform"].submit();
	}

	function getValues(objName) {
		var results = "";
		var arr = new Array();
		arr = document.getElementsByName(objName);

		for (var i = 0; i < arr.length; i++) {
			var obj = document.getElementsByName(objName).item(i);

			if (i > 0 && obj.checked && results.length > 0) {
				results += "$";
			}
			if (obj.checked) {
				results += obj.getAttribute("id");
			}
		}
		return results;
	}
	$(document).ready(function() {
		$('#selectAll').on('click', function() {
			if ($(this).is(':checked')) {
				$('.username').each(function() {
					this.checked = true;
				});
			} else {
				$('.username').each(function() {
					this.checked = false;
				});
			}
		})
	});

	$(document).ready(function() {
		$('#CategoriesList').on('click', function() {
			if ($(this).is(':checked')) {
				$('.categoriesclass').each(function() {
					this.checked = true;
				});
			} else {
				$('.categoriesclass').each(function() {
					this.checked = false;
				});
			}
		})
	});
</script>



 --%>