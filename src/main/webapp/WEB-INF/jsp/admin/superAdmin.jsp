
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
					Auction's <small></small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>Admin
							Auction</a></li>
					<li class="active"></li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
								<h4 class="box-title">Available Auction</h4>



							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example2" class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>Sr. No.</th>
											<th>Auction Id</th>
											<th>Auction Name</th>
											<th>Status</th>
											<th>Auction Start Time</th>
											<th>Auction End Time</th>
											<th>Action</th>


										</tr>
									</thead>
									<tbody>



										<c:forEach items="${AuctionList}" var="auction"
											varStatus="status">
											<tr>
												<td>${status.index+1}</td>
												<td>${auction.auctionId}</td>
												<td>${auction.name}</td>
												<td>${auction.status}</td>
												<td>${auction.auctionStartTime}</td>
												<td>${auction.auctionEndTime}</td>
												<td><c:if test="${auction.status == 'Start'}">
														<c:if test="${aunctionRunningOrClosedPresent == 0}">
															<a
																href="${admin_initcache_url}?auctionId=${auction.auctionId}">Start</a>
														</c:if>
														<c:if test="${aunctionRunningOrClosedPresent == 1}">
     					Close Running or Ended Auction First
     				</c:if>
													</c:if> <c:if test="${auction.status == 'End'}">
														<a
															href="${close_auction_url}?auctionId=${auction.auctionId}">Close</a>
													</c:if> <c:if test="${auction.status == 'Running'}">
														<a
															href="${close_auction_url}?auctionId=${auction.auctionId}">Close</a>
													</c:if></td>
											</tr>


										</c:forEach>




									</tbody>
									<tfoot>
										<tr>
											<th>Sr. No.</th>
											<th>Auction Id</th>
											<th>Auction Name</th>
											<th>Status</th>
											<th>Auction Start Time</th>
											<th>Auction End Time</th>
											<th>Action</th>
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
					<div class="col-xs-12 col-sm-6">
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a
								aria-controls="home" role="tab" data-toggle="tab"
								href="#summary">Auctions</a></li>
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




									<th>Sr. No.</th>
									<th>Auction Id</th>
									<th>Auction Name</th>
									<th>Status</th>
									<th>Auction Start Time</th>
									<th>Auction End Time</th>
									<th>Action</th>
								</tr>

								<c:if test="${ empty AuctionList}">
									<tr>
										<td colspan="7">No Record Found</td>
									</tr>

								</c:if>



								<c:forEach items="${AuctionList}" var="auction"
									varStatus="status">
									<tr>
										<td>${status.index+1}</td>
										<td>${auction.auctionId}</td>
										<td>${auction.name}</td>
										<td>${auction.status}</td>
										<td>${auction.auctionStartTime}</td>
										<td>${auction.auctionEndTime}</td>
										<td><c:if test="${auction.status == 'Start'}">
												<c:if test="${aunctionRunningOrClosedPresent == 0}">
													<a
														href="${admin_initcache_url}?auctionId=${auction.auctionId}">Start</a>
												</c:if>
												<c:if test="${aunctionRunningOrClosedPresent == 1}">
     					Close Running or Ended Auction First
     				</c:if>
											</c:if> <c:if test="${auction.status == 'End'}">
												<a
													href="${close_auction_url}?auctionId=${auction.auctionId}">Close</a>
											</c:if> <c:if test="${auction.status == 'Running'}">
												<a
													href="${close_auction_url}?auctionId=${auction.auctionId}">Close</a>
											</c:if></td>
									</tr>


								</c:forEach>


							</table>
						</div>
					</div>
					<!-- <div role="tabpanel" class="tab-pane" id="bidder">
						<div class="mark-check1">
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
						</div>
						<div class="table-responsive user-map">
							<table class="table table-bordered table-striped text-center">
								<tr>
									<th>Sr. No.</th>
									<th>Lot. No.</th>
									<th>Description</th>
									<th><select>
											<option>All</option>
											<option>1</option>
											<option>2</option>
									</select></th>
									<th>Material Name</th>
									<th>Remark</th>
									<th>Length Range</th>
									<th>Actual Range (Approx)</th>
									<th>Quantity</th>
									<th>Zone</th>
									<th>Company Name</th>
									<th>Bid Price</th>
									<th>Lot's Status<br> <select>
											<option>All</option>
											<option>1</option>
											<option>2</option>
									</select>
									</th>
									<th>Sales Price</th>
									<th>Total Sales (Qty X Sales Price)</th>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td>Total</td>
									<td>0</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td>&#x20b9; 0.0</td>
								</tr>
							</table>
						</div>
					</div> -->
				</div>
			</div>
		</div>
		<!-- /container -->
	</section>


</body>
 --%>


