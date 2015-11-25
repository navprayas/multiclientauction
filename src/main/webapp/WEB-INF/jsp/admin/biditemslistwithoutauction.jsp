
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
					Bid Item Mapping <small>Auction</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>Auction</a></li>
					<li class="active">Bid Item Mapping</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
								<div class="form-group">
									<label for="exampleInputEmail1">Select Auction</label> <select
										name="auctionId" id="auctionId"
										class="form-control select2 select2-hidden-accessible">
										<option value="-1">Select</option>
										<c:forEach var="auction" items="${auctionlist}">
											<c:if test="${selectedAuctionId==auction.auctionId }">
												<option value="${auction.auctionId}" selected="selected">
													${auction.name}</option>
											</c:if>
											<option value="${auction.auctionId}">${auction.name}</option>
										</c:forEach>
									</select>
									<div class="box-footer">
										<input type="button" name="Update BidItem" value="update"
											id="updatebiditem" onclick="updateBidItem();"
											class="btn btn-primary">
									</div>
								</div>


							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example2" class="table table-bordered table-hover">
									<thead>
										<tr>
											<th align="center">Sr.No.</th>
											<th align="center">SELECT BID ITEM</th>
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
												<td><input type="radio" name="biditemid"
													class="minimal" value="${biditem.bidItemId}"></td>
												<td>${biditem.name}</td>
												<td>${biditem.minBidPrice}</td>
												<td>${biditem.minBidIncrement}</td>
												<td><a href="${biditem.imageUrl}" target="_blank">
														<img alt="" src="${biditem.imageUrl}" height="80px"
														width="120px">
												</a></td>
											</tr>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<th align="center">Sr.No.</th>
											<th align="center">SELECT BID ITEM</th>
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

	function updateBidItem() {
		var ids = "";

		$('input[type=radio]').each(function() {
			if (this.checked) {
				ids = this.value;
			}
		});

		var auctionId = $('#auctionId').val();
		if (auctionId == -1) {
			alert("Please Select Auction ");
			return false;
		}
		if (ids != "") {

			$.ajax({
				url : "updatebiditemauction?auctionId=" + auctionId
						+ "&bidItemId=" + ids,
				method : "get",
				success : function(data) {
					alert(data);
					location.reload();
				}
			});
		} else {
			alert("Please Select Bid Item");
		}
	}
</script>




