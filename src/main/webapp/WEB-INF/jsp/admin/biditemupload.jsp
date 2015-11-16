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



							<form role="form" id="createbiditem" name="createbiditem"
								method="POST" action="createbiditem"
								enctype="multipart/form-data">
								<div class="box-body">
									<%-- <div class="form-group">
										<label for="exampleInputEmail1">Select Auction</label> <select
											name="auctionId" id="auctionId" class="form-control">
											<option value="-1">Select</option>
											<c:forEach var="auction" items="${auctionList}">
												<option value="${auction.auctionId}">
													<c:out value="${auction.name}" />
												</option>
											</c:forEach>
										</select>
									</div> --%>


									<div class="form-group">
										<label for="exampleInputEmail1">Select Category</label> <select
											name="categoryId" id="categoryId" class="form-control">
											<option value="-1">Select</option>
											<c:forEach var="category" items="${categoryList}">
												<option value="${category.categoryId}">
													<c:out value="${category.categoryName}" />
												</option>
											</c:forEach>
										</select>
									</div>


									<div class="form-group">
										<label for="exampleInputEmail1">Select Currency</label> <select
											class="form-control" name="currency" id="currency">
											<option value="-1">Select</option>
											<option value="INR">INDIAN RUPEES</option>
											<option value="DOLLAR">Dollar</option>

										</select>
									</div>




									<div class="form-group">
										<label for="exampleInputEmail1"> Market Type </label> <select
											name="marketId" id="marketId" class="form-control">
											<option value="-1">Select</option>
											<option value="1">FORWARD MARKET</option>
											<option value="2">REVERSE MARKET</option>

										</select>

									</div>
									<div class="form-group">
										<label for="inputname2">Item Name</label> <input type="text"
											name="name" id="name" required="required"
											class="form-control">

									</div>

									<div class="form-group">
										<label for="inputname2">City</label> <input type="text"
											name="city" id="city" required="required"
											class="form-control">

									</div>

									<div class="form-group">
										<label for="inputname2">Zone</label> <input type="text"
											name="zone" id="zone" required="required"
											class="form-control">

									</div>

									<div class="form-group">
										<label for="inputname2">Minimum Bid</label> <input type="text"
											name="minBidPrice" id="minBidPrice" required="required"
											class="form-control">

									</div>

									<div class="form-group">
										<label for="inputname2">Bid Increment Price</label> <input
											type="text" name="minBidIncrement" id="minBidIncrement"
											required="required" class="form-control">

									</div>

									<div class="form-group">
										<label for="inputname2">Initial Start Time(In Minutes)</label>
										<input type="text" name="initialStartTime"
											id="initialStartTime" required="required"
											class="form-control">

									</div>

									<div class="form-group">
										<label for="inputname2">Time Extension (In Minutes)</label> <input
											type="text" name="timeExtn" id="timeExtn" required="required"
											class="form-control">

									</div>


									<div class="form-group">
										<label for="inputname2">Image</label> <input type="file"
											name="file" id="file" onchange="checkfile(this);"
											name="firstName" required="required" class="form-control">


									</div>






								</div>
								<!-- /.box-body -->

								<div class="box-footer">
									<input type="button" class="btn btn-primary"
										value="Create Bid Item" onclick="checkfile1()" />
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
	function checkfile1() {

		var validExts = new Array(".jpg", ".png");
		var fileExt = document.getElementById("file").value;
		fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
		if (validExts.indexOf(fileExt) < 0) {
			alert("Invalid file selected, valid files are of "
					+ validExts.toString() + " types.");
			return false;
		}

		/* if ($('#auctionId').val() == -1) {
			alert("Please Select Auction");
			return false;
		} */

		if ($('#categoryId').val() == -1) {
			alert("Please Select Category");
			return false;
		}

		if ($('#currency').val() == -1) {
			alert("Please Select Currency");
			return false;
		}
		if (isNaN($('#minBidPrice').val())) {
			alert("Please Enter Minimum Bid Price. It should be a Number");
			return false;
		}

		if (isNaN($('#minBidIncrement').val())) {
			alert("Please Enter Minimum Bid increment Price. It should be a Number");
			return false;
		}

		if (isNaN($('#initialStartTime').val())) {
			alert("Please Enter Initial Start time. It should be a Number(In Minutes)");
			return false;
		}

		if (isNaN($('#timeExtn').val())) {
			alert("Please Enter Initial Time Extention time. It should be a Number(In seconds)");
			return false;
		}

		$('#createbiditem').submit();

	}
	function checkfile(sender) {
		var validExts = new Array(".jpg", ".png");
		var fileExt = sender.value;
		fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
		if (validExts.indexOf(fileExt) < 0) {
			alert("Invalid file selected, valid files are of "
					+ validExts.toString() + " types.");
			return false;
		} else
			return true;
	}
</script>


<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<section class="main">
	<div class="container">
		<div class="form-container form-container-cr user-registraton">
			<h1>
				<i class="fa fa-user"></i> Upload Bid Item
			</h1>
			<form id="createbiditem" name="createbiditem" method="POST"
				action="createbiditem" enctype="multipart/form-data"
				class="form-horizontal">


				<c:if test="${not empty message}">
					<div class="form-group">
						<div class="col-xs-12 col-sm-8">
							<c:out value="${message}"></c:out>
						</div>

					</div>
				</c:if>


				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">Select
						Auction</label>
					<div class="col-xs-12 col-sm-8">
						<select name="auctionId" id="auctionId" style="width: 180px">
							<option value="-1">Select</option>
							<c:forEach var="auction" items="${auctionList}">
								<option value="${auction.auctionId}">
									<c:out value="${auction.name}" />
								</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">Select
						Category</label>
					<div class="col-xs-12 col-sm-8">
						<select name="categoryId" id="categoryId" style="width: 180px">
							<option value="-1">Select</option>
							<c:forEach var="category" items="${categoryList}">
								<option value="${category.categoryId}">
									<c:out value="${category.categoryName}" />
								</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">Select
						Currency</label>
					<div class="col-xs-12 col-sm-8">
						<select name="currency" id="currency" style="width: 180px">
							<option value="-1">Select</option>
							<option value="INR">INDIAN RUPEES</option>
							<option value="DOLLAR">Dollar</option>

						</select>
					</div>
				</div>

				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">
						Market Type </label>
					<div class="col-xs-12 col-sm-8">
						<select name="marketId" id="marketId" style="width: 180px">
							<option value="-1">Select</option>
							<option value="1">FORWARD MARKET</option>
							<option value="2">REVERSE MARKET</option>

						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">Item
						Name</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" name="name" id="name" required="required">
					</div>
				</div>

				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">City</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" name="city" id="city" required="required">
					</div>
				</div>


				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">Item
						Zone</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" name="zone" id="zone" required="required">
					</div>
				</div>
				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">Minimum
						Bid Price </label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" name="minBidPrice" id="minBidPrice"
							required="required">
					</div>
				</div>





				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">
						Bid Increment Price </label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" name="minBidIncrement" id="minBidIncrement"
							required="required">
					</div>
				</div>

				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">
						Initial Start Time(In Minutes) </label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" name="initialStartTime" id="initialStartTime"
							required="required">
					</div>
				</div>
				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">
						Time Extention (In Minutes)</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" name="timeExtn" id="timeExtn"
							required="required">
					</div>
				</div>




				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">Image</label>
					<div class="col-xs-12 col-sm-8">
						<input type="file" name="file" id="file"
							onchange="checkfile(this);" name="firstName" required="required"
							style="width: 180px">
						<!-- <input type="hidden" id="selectedAuctionId"
							name="selectedAuctionId" /> -->
					</div>
				</div>



				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-8">
						<input type="button" class="btn btn-primary"
							value="Create Bid Item" onclick="checkfile1()">
					</div>

				</div>
			</form>
		</div>
	</div>
	<!-- /container -->
</section>
<script>
	function checkfile1() {

		var validExts = new Array(".jpg", ".png");
		var fileExt = document.getElementById("file").value;
		fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
		if (validExts.indexOf(fileExt) < 0) {
			alert("Invalid file selected, valid files are of "
					+ validExts.toString() + " types.");
			return false;
		}
		alert("Auction Id" + $('#auctionId').val());

		if ($('#auctionId').val() == -1) {
			alert("Please Select Auction");
			return false;
		}

		if ($('#categoryId').val() == -1) {
			alert("Please Select Category");
			return false;
		}

		if ($('#currency').val() == -1) {
			alert("Please Select Currency");
			return false;
		}
		if (isNaN($('#minBidPrice').val())) {
			alert("Please Enter Minimum Bid Price. It should be a Number");
			return false;
		}

		if (isNaN($('#minBidIncrement').val())) {
			alert("Please Enter Minimum Bid increment Price. It should be a Number");
			return false;
		}

		if (isNaN($('#initialStartTime').val())) {
			alert("Please Enter Initial Start time. It should be a Number(In Minutes)");
			return false;
		}

		if (isNaN($('#timeExtn').val())) {
			alert("Please Enter Initial Time Extention time. It should be a Number(In seconds)");
			return false;
		}

		$('#createbiditem').submit();

	}
	function checkfile(sender) {
		var validExts = new Array(".jpg", ".png");
		var fileExt = sender.value;
		fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
		if (validExts.indexOf(fileExt) < 0) {
			alert("Invalid file selected, valid files are of "
					+ validExts.toString() + " types.");
			return false;
		} else
			return true;
	}
</script>
 --%>