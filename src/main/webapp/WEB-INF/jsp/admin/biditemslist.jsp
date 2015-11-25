
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
					Bid Items<small>Admin</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>Admin Auction</a></li>
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
								<select name="auctionId" id="auctionId"
									onchange="loadbidItem();">
									<option value="-1">Select</option>
									<c:forEach var="auction" items="${auctionlist}">
										<c:if test="${selectedAuctionId==auction.auctionId }">
											<option value="${auction.auctionId}" selected="selected">
												${auction.name}</option>
										</c:if>
										<option value="${auction.auctionId}">${auction.name}</option>
									</c:forEach>
								</select>


							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example2" class="table table-bordered table-hover">
									<thead>
										<tr>
											<th align="center">Sr. No.</th>
											<th align="center">BID ITEM</th>
											<th align="center">MINIMUM BID PRICE</th>
											<th align="center">MINIMUM BID INCREMENT</th>
											<th align="center">VIEW IMAGE</th>


										</tr>
									</thead>
									<tbody>



										<c:forEach items="${biditemslist}" var="biditem"
											varStatus="status">
											<tr>
												<td>${status.index+1}</td>
												<td>${biditem.name}</td>
												<td>${biditem.minBidPrice}</td>
												<td>${biditem.minBidIncrement}</td>

												<td><a href="${biditem.imageUrl}" target="_blank">
														<img alt="" src="${biditem.imageUrl}" height="80px"
														width="120px">
												</a></td>

												<%-- <td><a href='${biditem.imageUrl}' target="_blank">View
														Image</a></td> --%>

											</tr>
										</c:forEach>




									</tbody>
									<tfoot>
										<tr>
											<th align="center">Sr. No.</th>
											<th align="center">BID ITEM</th>
											<th align="center">MINIMUM BID PRICE</th>
											<th align="center">MINIMUM BID INCREMENT</th>
											<th align="center">VIEW IMAGE</th>
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

	function loadbidItem() {

		window.location.href = "biditemslistbyauction?auctionId="
				+ $('#auctionId').val();

	}
</script>





<%-- <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/admin/initcache" var="admin_initcache_url" />
<spring:url value="admin/closeAuction" var="close_auction_url" />
<body>
	<script type="text/javascript">
		function loadbidItem() {

			window.location.href = "biditemslist?auctionId="
					+ $('#auctionId').val();

		}
	</script>

	<!-- { middle } -->
	<section class="main">
		<div class="container">
			<div class="table-container">
				<div class="top-line">
					<div class="col-xs-12 col-sm-6 nopad">
						 <ul class="nav nav-tabs" role="tablist">
							 <li role="presentation" class="active"><a
								aria-controls="home" role="tab" data-toggle="tab"
								href="#summary">Bid Items</a></li>
							<li><a aria-controls="home" role="tab" data-toggle="tab"
								href="#bidder">Bidder Wise</a></li> 
						</ul> 
					</div>
					<div class="clearfix"></div>
				</div>
				<!-- { tab-Effects } -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="summary">

						<div class="table-responsive user-map">
							<table class="table table-bordered table-striped text-center">
								<tr>
									<td colspan="5"><select name="auctionId" id="auctionId"
										onchange="loadbidItem();">
											<option value="-1">Select</option>
											<c:forEach var="auction" items="${auctionlist}">
												<c:if test="${selectedAuctionId==auction.auctionId }">
													<option value="${auction.auctionId}" selected="selected">
														${auction.name}</option>
												</c:if>
												<option value="${auction.auctionId}">
													${auction.name}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>

									<th align="center">Sr. No.</th>
									<th align="center">BID ITEM</th>
									<th align="center">MINIMUM BID PRICE</th>
									<th align="center">MINIMUM BID INCREMENT</th>
									<th align="center">VIEW IMAGE</th>
								</tr>
								<c:forEach items="${biditemslist}" var="biditem"
									varStatus="status">
									<tr>
										<td>${status.index+1}</td>
										<td>${biditem.name}</td>
										<td>${biditem.minBidPrice}</td>
										<td>${biditem.minBidIncrement}</td>

										<td><a href="${biditem.imageUrl}" target="_blank"> <img alt=""
												src="${biditem.imageUrl}" height="80px" width="120px"></a>

										</td>
										
										<td><a href='${biditem.imageUrl}' target="_blank">View
												Image</a></td>
								
									</tr>
								</c:forEach>
							</table>



						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /container -->
	</section>


</body>




 --%>