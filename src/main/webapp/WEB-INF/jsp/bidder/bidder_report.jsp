
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<%@page import="java.util.Date"%>

<script type="text/javascript">
	function getResultForCategory(categoryId) {
		var location1 = "${bidder_report_url}/report/" + categoryId;
		window.location.href = location1;
	}
	$(function() {
		// Dialog			

		$('.desc').dialog({
			autoOpen : false,
			width : 'auto',
		});
		$('.bids').dialog({
			autoOpen : false,
			width : 'auto',
		});
		$('.removediv').dialog({
			autoOpen : false,
			width : 'auto',
		});
		$('.change').dialog({
			autoOpen : false,
			width : 'auto',
			height : 110,
		});

		// Dialog Link

		$('.description').click(function() {

			//$('.desc').dialog('open');
			$('#dialog_' + $(this).attr('id')).dialog('open');
			return false;
		});
		$('.autobid').click(function() {

			$('.bids').dialog('open');
			return false;
		});
		$('.remove').click(function() {

			$('.removediv').dialog('open');
			return false;
		});
		$('.changepass').click(function() {

			$('.change').dialog('open');
			return false;
		});

	});

	$(function() {
		$(".desc").dialog({
			bgiframe : false,
			modal : true,

		});

		$(".bids").dialog({
			bgiframe : false,
			modal : true,

		});

		$(".removediv").dialog({
			bgiframe : false,
			modal : true,
		});
		$(".change").dialog({
			bgiframe : false,
			modal : true,

		});
	});
</script>




<body>
	<div class="container">
		<!-- <div class="mark-check1">
			<table class="table table-bordered table-striped text-center">
				<tr>
					<td></td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</div> -->
		<div class="table-responsive user-map hktk">
			<table class="table table-bordered table-striped text-center">
				<tr>
					<td>Sr. No</td>
					<td>Description</td>
					<td>Lot No.</td>

					<td>Category Name</td>

					<td>Material Name</td>
					<td>Remark</td>
					<td>Length Range</td>
					<td>Actual Length<br /> (Approx)
					</td>
					<td>Quantity</td>
				</tr>
				<c:forEach items="${wonList}" var="bidItem" varStatus="status">
					<tr class="table">
						<td>${status.index+1}</td>
						<td align="center" valign="middle" class="DetailBorRight">

							<div class="modal fade" id="dialog_desc${status.index+1}"
								tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="dialog_desc${status.index+1}">Description</h4>
										</div>
										<div class="modal-body">



											<div id="dialog_desc${status.index+1}" class="desc"
												title="Item Description">
												<table
													class="table table-bordered table-striped text-center">
													<tr>
														<td><form name="form1" method="post" action="">
																<table
																	class="table table-bordered table-striped text-center">
																	<tr></tr>
																	<tr>
																		<td>Sr. No.</td>
																		<td>Category</td>
																		<td>Lot No.</td>
																		<td>Materials Name</td>
																		<td>Remark</td>
																		<td>Length Range</td>
																		<td>Actual Length (Approx)</td>
																		<td>Qty</td>
																	</tr>
																	<tr>
																		<td>${status.index+1}.</td>
																		<td>${bidItem.category.categoryName}</td>
																		<td>${bidItem.bidItemId}</td>
																		<td>${bidItem.name}</td>
																		<c:if test="${fn:length(bidItem.itemLots) == 1}">
																			<c:forEach items="${bidItem.itemLots}"
																				var="itemLotUnique" varStatus="status2">
																				<td>${itemLotUnique.remark}</td>
																				<td>${itemLotUnique.lengthRange}</td>
																				<td>${itemLotUnique.actualLengh}</td>
																			</c:forEach>
																		</c:if>
																		<c:if test="${fn:length(bidItem.itemLots) > 1}">
																			<td>&nbsp;</td>
																			<td>&nbsp;</td>
																			<td>&nbsp;</td>
																		</c:if>
																		<td>${bidItem.totalQuantity}${bidItem.unit}</td>
																	</tr>


																	<c:if test="${fn:length(bidItem.itemLots) > 1}">
																		<c:forEach items="${bidItem.itemLots}" var="itemLot"
																			varStatus="status1">
																			<tr>
																				<td>${status1.index+1}</td>
																				<td>${bidItem.category.categoryName}</td>
																				<td>${itemLot.lotId}</td>
																				<td>${itemLot.name}</td>
																				<td>${itemLot.remark}</td>
																				<td>${itemLot.lengthRange}</td>
																				<td>${itemLot.actualLengh}</td>
																				<td>${itemLot.quantity}${itemLot.unit}</td>
																			</tr>
																		</c:forEach>
																	</c:if>
																</table>
															</form></td>
													</tr>
												</table>
											</div>



										</div>
									</div>
								</div>
							</div> <input type="submit" name="button3" id="desc${status.index+1}"
							value="Desc" data-toggle="modal"
							data-target="#dialog_desc${status.index+1}" />
						</td>
						<td align="center" valign="middle" class="DetailBorRight">${bidItem.bidItemId}</td>
						<td align="center" valign="middle" class="DetailBorRight">${bidItem.category.categoryName}</td>
						<td align="center" valign="middle" class="DetailBorRight"><a
							href="#services" class="LinkSelected">${bidItem.name}</a></td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.remark}</td>
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lengthRange}</td>
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.actualLengh}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" class="DetailBorRight">${bidItem.totalQuantity}
							${bidItem.unit}</td>
					</tr>



					<!--        <td align="center" valign="middle" class="DetailBorRight">${bidItem.totalQuantity} ${bidItem.unit}</td>-->



				</c:forEach>

			</table>
		</div>
		
	</div>
</body>
