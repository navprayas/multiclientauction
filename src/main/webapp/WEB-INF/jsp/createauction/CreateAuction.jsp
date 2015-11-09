<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<link type="text/css" rel="stylesheet"
	href="${css_url}/dhtmlgoodies_calendar.css?random=20051112"
	media="screen"></link>
<script type="text/javascript"
	src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
<body class="hold-transition skin-blue sidebar-mini">




	<div class="wrapper">


		<!-- Left side column. contains the logo and sidebar -->


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Create Auction <small>Home</small>
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
								<h3 class="box-title">Auction Details</h3>
							</div>



							<form role="form" id="createAuction" name="createAuction"
								method="post" action="createAuction"
								modelAttribute="firmDetails">
								<div class="box-body">
									<c:if test="${not empty auctionDetails.auctionId}">

										<input type="hidden" name="auctionId" id="auctionId"
											value="${auctionDetails.auctionId}" />


									</c:if>


									<div class="form-group">


										<label for="exampleInputEmail1">Auction Name</label> <input
											type="text" class="form-control" id="name" name="name"
											placeholder="Auction Name" value="${auctionDetails.name}">
									</div>



									<div class="form-group">


										<label for="exampleInputEmail1">Status</label> <select
											name="status" id="status" class="form-control">
											<option
												<c:if test="${auctionDetails.status=='0'}">selected='selected'</c:if>
												value="0">select</option>
											<option
												<c:if test="${auctionDetails.status=='Start'}">selected='selected'</c:if>
												value="Start">Start</option>
											<option
												<c:if test="${auctionDetails.status=='Running'}">selected='selected'</c:if>
												value="Running">Running</option>
										</select>
									</div>



									<div class="form-group">


										<label for="exampleInputEmail1">Is Approved</label> <select
											name="isApproved" id="isApproved" class="form-control">
											<option
												<c:if test="${auctionDetails.isApproved=='-1'}">selected='selected'</c:if>
												value="-1">select</option>
											<option
												<c:if test="${auctionDetails.isApproved=='1'}">selected='selected'</c:if>
												value="1">Yes</option>
											<option
												<c:if test="${auctionDetails.isApproved=='0'}">selected='selected'</c:if>
												value="0">No</option>
										</select>

									</div>







									<div class="form-group">


										<label for="exampleInputEmail1">Created Date</label> <input
											type="text" class="form-control pull-right"
											id="createdTimeFormat" name="createdTimeFormat"
											placeholder="Select Date"
											value="${auctionDetails.createdTime}" readonly
											onclick="displayCalendar(document.createAuction.createdTimeFormat,'yyyy/mm/dd',this)">
									</div>















								</div>
								<!-- /.box-body -->

								<div class="box-footer">
									<button type="button" class="btn btn-primary"
										onclick="checkAuction();">Submit</button>
								</div>
							</form>

						</div>
					</div>

					<div class="col-md-6">
						<div class="box">
							<div class="box-header">
								<h3 class="box-title">Available Auction</h3>

								<div class="box-tools">
									<ul class="pagination pagination-sm no-margin pull-right">
										<li><a href="#">&laquo;</a></li>
										<li><a href="#">1</a></li>
										<li><a href="#">2</a></li>
										<li><a href="#">3</a></li>
										<li><a href="#">&raquo;</a></li>
									</ul>
								</div>
							</div>
							<!-- /.box-header -->
							<div class="box-body no-padding">
								<table class="table">
									<tr>
										<th style="width: 10px">#</th>
										<th>Auction Name</th>
										<th>Status</th>
										<th style="width: 40px">Date</th>
									</tr>
									<tr>
										<td>1.</td>
										<td>Update software</td>
										<td>
											<div class="progress progress-xs">
												<div class="progress-bar progress-bar-danger"
													style="width: 55%"></div>
											</div>
										</td>
										<td><span class="badge bg-red">55%</span></td>
									</tr>
									<tr>
										<td>2.</td>
										<td>Clean database</td>
										<td>
											<div class="progress progress-xs">
												<div class="progress-bar progress-bar-yellow"
													style="width: 70%"></div>
											</div>
										</td>
										<td><span class="badge bg-yellow">70%</span></td>
									</tr>
									<tr>
										<td>3.</td>
										<td>Cron job running</td>
										<td>
											<div class="progress progress-xs progress-striped active">
												<div class="progress-bar progress-bar-primary"
													style="width: 30%"></div>
											</div>
										</td>
										<td><span class="badge bg-light-blue">30%</span></td>
									</tr>
									<tr>
										<td>4.</td>
										<td>Fix and squish bugs</td>
										<td>
											<div class="progress progress-xs progress-striped active">
												<div class="progress-bar progress-bar-success"
													style="width: 90%"></div>
											</div>
										</td>
										<td><span class="badge bg-green">90%</span></td>
									</tr>

									<tr>
										<td>5.</td>
										<td>Fix and squish bugs</td>
										<td>
											<div class="progress progress-xs progress-striped active">
												<div class="progress-bar progress-bar-success"
													style="width: 90%"></div>
											</div>
										</td>
										<td><span class="badge bg-green">90%</span></td>
									</tr>


									<tr>
										<td>6.</td>
										<td>Fix and squish bugs</td>
										<td>
											<div class="progress progress-xs progress-striped active">
												<div class="progress-bar progress-bar-success"
													style="width: 90%"></div>
											</div>
										</td>
										<td><span class="badge bg-green">90%</span></td>
									</tr>


									<tr>
										<td>7.</td>
										<td>Fix and squish bugs</td>
										<td>
											<div class="progress progress-xs progress-striped active">
												<div class="progress-bar progress-bar-success"
													style="width: 90%"></div>
											</div>
										</td>
										<td><span class="badge bg-green">90%</span></td>
									</tr>


								</table>
							</div>
							<!-- /.box-body -->
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
	function checkAuction() {

		var Name = document.getElementById("name").value;
		var CreatedTimeFormat = document.getElementById("createdTimeFormat").value;
		var Status = document.getElementById("status").value;
		var IsApproved = document.getElementById("isApproved").value;

		if (Name == "") {
			alert(" Name Cannot Be Blank.");
			return false;
		}

		if (Status == 0) {
			alert(" Select Status.");
			return false;
		}
		if (IsApproved == -1) {
			alert(" Select IsApproved.");
			return false;
		}
		if (CreatedTimeFormat == "") {
			alert("Created Time Cannot Be Blank.");
			return false;
		}
		document.createAuction.submit();

	}
</script>








<%-- 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/" var="static_url" />
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/admin/superAdmin" var="admin_url" />
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" rel="stylesheet"
	href="${css_url}/dhtmlgoodies_calendar.css?random=20051112"
	media="screen"></link>
<script type="text/javascript"
	src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
	<link href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet">
<section class="main">


	<div class="container">



		<div class="form-container form-container-cr">

			<h1>
				<i class="fa fa-user"></i> E-Create Auction
			</h1>
			<form role="form" id="createAuction" name="createAuction"
				method="post" action="createAuction" modelAttribute="firmDetails">

				<c:if test="${not empty auctionDetails.auctionId}">

					<input type="hidden" name="auctionId" id="auctionId"
						value="${auctionDetails.auctionId}" />


				</c:if>


				<div class="form-group">
					<label for="exampleAuctionName">Auction Name</label> <input
						type="text" class="form-control" name="name" id="name"
						value="${auctionDetails.name}" placeholder="Auction Name">
				</div>
				<div class="form-group">
					<label for="exampleInputstatus">Status</label> <select
						name="status" id="status" class="form-control">
						<option
							<c:if test="${auctionDetails.status=='0'}">selected='selected'</c:if>
							value="0">select</option>
						<option
							<c:if test="${auctionDetails.status=='Start'}">selected='selected'</c:if>
							value="Start">Start</option>
						<option
							<c:if test="${auctionDetails.status=='Running'}">selected='selected'</c:if>
							value="Running">Running</option>
					</select>
				</div>
				<div class="form-group">
					<label for="exampleIsapproved">Is Approved</label> <select
						name="isApproved" id="isApproved" class="form-control">
						<option
							<c:if test="${auctionDetails.isApproved=='-1'}">selected='selected'</c:if>
							value="-1">select</option>
						<option
							<c:if test="${auctionDetails.isApproved=='1'}">selected='selected'</c:if>
							value="1">Yes</option>
						<option
							<c:if test="${auctionDetails.isApproved=='0'}">selected='selected'</c:if>
							value="0">No</option>
					</select>
				</div>
				<div class="form-group">
					<label for="exampleCreatedTime">Created Time</label> <input
						type="text" class="form-control" name="createdTimeFormat"
						id="createdTimeFormat" readonly
						onclick="displayCalendar(document.createAuction.createdTimeFormat,'yyyy/mm/dd',this)"
						value="${auctionDetails.createdTime}" placeholder="Created Time">
				</div>
				<div class="form-group form-submit">
					<label style="color: red"><c:if test="${not empty messages}"></c:if> <c:out
							value="${messages}"></c:out> </label>
					<button class="btn btn-primary pull-right" type="submit"
						name="button" id="button" value="Submit"
						onclick="javascript:checkAuction();">Create Auction</button>
					<div class="clearfix"></div>
				</div>
			</form>
		</div>
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
				<c:if test="${not empty auctionlist}">


					<div class="table-responsive user-map">
						<table class="table table-bordered table-striped text-center">
							<tr>
	<th>Sr. No.</th>
								<th>Auction Name</th>
								<th>Auction Status</th>
								<th>Auction Approved</th>
								<th>Modify Auction</th>
							</tr>
							<c:forEach items="${auctionlist}" var="auction"
								varStatus="status">
								<tr>
									<td>${status.index+1}</td>
									<td>${auction.name}</td>
									<td>${auction.status}</td>
									<td><c:choose>

											<c:when test="${auction.isApproved==1}">
					Appoved
					</c:when>
											<c:otherwise>
					Not Approved
					</c:otherwise>
										</c:choose></td>
									<td><a href="editauction?auctionId=${auction.auctionId}">Modify
									</a></td>
								</tr>
							</c:forEach>
						</table>



					</div>


				</c:if>
			</div>
		</div>





	</div>
	<!-- /container -->
</section>

<script>
	function checkAuction() {

		var Name = document.getElementById("name").value;
		var CreatedTimeFormat = document.getElementById("createdTimeFormat").value;
		var Status = document.getElementById("status").value;
		var IsApproved = document.getElementById("isApproved").value;

		if (Name == "") {
			alert(" Name Cannot Be Blank.");
			return false;
		}

		if (Status == 0) {
			alert(" Select Status.");
			return false;
		}
		if (IsApproved == -1) {
			alert(" Select IsApproved.");
			return false;
		}
		if (CreatedTimeFormat == "") {
			alert("Created Time Cannot Be Blank.");
			return false;
		}
		document.createAuction.submit();

	}
</script>

 --%>