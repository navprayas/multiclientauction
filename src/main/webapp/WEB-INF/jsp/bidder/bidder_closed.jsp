<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/bidder/closed/" var="Paginationform_url" />
<spring:url value="/bidder" var="bidder_home_url" />
<spring:url value="/bidder/active" var="bidder_active_url" />
<spring:url value="/bidder/marketlist" var="bidder_market_url" />
<script type="text/javascript">

function getResultForCategory()
{
	document.forms["categoryform"].submit();
}

function onSubmit(pageNo) {
	document.paginationForm.category.value = document.forms["categoryform"].category.value;
	document.paginationForm.page.value=pageNo;
	document.paginationForm.submit();
}

function setPreferenceDisplay(bidId)
{
	blah(document.getElementById("itemRow"+bidId));
}

function display( notifier, str ) {
   	document.getElementById(notifier).innerHTML = str;
}
</script>

<script type="text/javascript">
			$(function(){
				// Dialog			
				$('.dialog').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.amt').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.desc').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.bidhistory').dialog({
					autoOpen: false,
					width:'auto',
					height:310,
				});
				$('.biddetail').dialog({
					autoOpen: false,
					width:'auto',
				});
				
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
				});
				// Dialog Link
				$('.dialog_link').click(function(){
				//alert("");
					$('.dialog').dialog('open');
					return false;
				});
				
				$('.changeamot').click(function(){
				
					$('.amt').dialog('open');
					return false;
				});
				$('.description').click(function(){
				
					//$('.desc').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
			
				$('.history').click(function(){
				
					$('.bidhistory').dialog('open');
					return false;
				});
				$('.detail').click(function(){
					if(document.getElementById("bidItemIdVal")){
						var bidItemId = document.getElementById("bidItemIdVal").value;
						if(bidItemId=="" || bidItemId.length < 1) {
							alert("Please first select the Material name for getting detail for that");
							return false;
						}							
					}
					$('.biddetail').dialog('open');
					return false;
				});
				$('.changepass').click(function(){
				
					$('.change').dialog('open');
					return false;
				});
			});
		</script>
<script type="text/javascript">
	$(function() {
		$(".dialog").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
		
		$(".amt").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
	
		$(".desc").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
	
		$(".bidhistory").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
	
		$(".biddetail").dialog({
			bgiframe: false,
			modal: true,
		});	
		$(".change").dialog({
			bgiframe: false,
			modal: true,
			
		});
		
	});
	</script>

<script language="javascript">
function blah( oCB )
{    for( oElem = oCB; oElem.tagName!= "TR"; oElem = oElem.parentNode );
    oElem.className = oCB.checked? "selected": "table";
}
</script>
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
				<div class="mark-check1 mktlstcl">
			<form id="form1" name="form1" method="post" action=""
				style="margin: 0px;">
				<table class="table table-bordered table-striped text-center">
					<tr>
						<td colspan="3"><input type="radio" name="radio" id="radio"
							value="1" onclick="getPageForMarketType(this.value)" /> <a
							href="${bidder_market_url}">&nbsp;Market List</a></td>
						<td colspan="3"><input type="radio" name="radio" id="radio2"
							value="2" onclick="getPageForMarketType(this.value)" /> <a
							href="${bidder_active_url}">&nbsp;Active Market</a></td>
						<td colspan="3"><input type="radio" checked name="radio"
							id="radio3" value="3" /><a href="#">&nbsp;Closed Market</a></td>
						<td colspan="7" align="right"><strong>Total No. of
								Forward Markets in Active List: <c:out
									value="${fn:length(bidItemsList)}" />
						</strong></td>
					</tr>
				</table>
			</form>
		</div>
		<form:form action="${Paginationform_url}" name="paginationForm">
			<input type="hidden" name="page"
				value="<c:out value='${navigationInfo.currentPage}' />" />
			<input type="hidden" name="category" value="0" />
		</form:form>

		<div class="table-responsive user-map nofound itemlist">
			<table class="table table-bordered table-striped text-center">
				<tr>
					<td><display:table name="navigationInfo"
							requestURI="${Paginationform_url}" excludedParams="*"
							cellspacing="0px" cellpadding="0px 0px 0px 0px">
							<display:setProperty name="paging.banner.onepage" value="<br/>"></display:setProperty>
							<display:setProperty name="basic.msg.empty_list" value=""></display:setProperty>
							<display:setProperty name="basic.msg.empty_list_row" value=""></display:setProperty>
							<display:setProperty name="paging.banner.first">
								<table lass="table table-bordered table-striped text-center">
									<tr>
										<td><div style="width: 100%; text-align: center">
												<span class="pagelinks"> First | Prev&nbsp;<c:out
														value="${navigationInfo.pageSize}" /> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage+1}' />')"
													id="id3">Next&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.pageCount}' />')"
													id="id4">Last</a>
												</span>
											</div></td>
									</tr>
								</table>
							</display:setProperty>
							<display:setProperty name="paging.banner.full">
								<table class="table table-bordered table-striped text-center">
									<tr>
										<td><div style="width: 100%; text-align: center">
												<span class="pagelinks"> <a href="#"
													onclick="javascript: onSubmit('1')" id="id5">First</a> | <a
													href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage-1}' />')"
													id="id6">Prev&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage+1}' />')"
													id="id3">Next&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.pageCount}' />')"
													id="id4">Last </a>
												</span>
											</div></td>
									</tr>
								</table>
							</display:setProperty>
							<display:setProperty name="paging.banner.last">
								<table class="table table-bordered table-striped text-center">
									<tr>
										<td><div style="width: 100%; text-align: center">
												<span class="pagelinks"> <a href="#"
													onclick="javascript: onSubmit('1')" id="id5">First</a> | <a
													href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage-1}' />')"
													id="id6">Prev&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | Next&nbsp;<c:out
														value="${navigationInfo.pageSize}" /> | Last
												</span>
											</div></td>
									</tr>
								</table>
							</display:setProperty>
						</display:table></td>
				</tr>
			</table>
		</div>
		<div class="table-responsive user-map">
			<table class="table table-bordered table-striped text-center">

				<tr>
					<td><a href="#">Select</a></td>
					<td><a href="#">Sr. No</a><a href="#"></a></td>
					<td><a href="#">Description</a></td>
					<td><a href="#">Lot No.</a></td>
					<td>
						<form name="categoryform" action="closed" method="post">
							<select name="category" id="category"
								onChange="getResultForCategory()">
								<option value="0">All</option>
								<c:forEach var="bidderCategory" items="${bidderCategoryList}">
									<c:if
										test="${bidderCategory.bidderCategoryId.category.categoryId==categoryName}">
										<option
											value="${bidderCategory.bidderCategoryId.category.categoryId}"
											selected="selected">
											<c:out
												value="${bidderCategory.bidderCategoryId.category.categoryName}" />
										</option>
									</c:if>
									<c:if
										test="${bidderCategory.bidderCategoryId.category.categoryId!=categoryName}">
										<option
											value="${bidderCategory.bidderCategoryId.category.categoryId}">
											<c:out
												value="${bidderCategory.bidderCategoryId.category.categoryName}" />
										</option>
									</c:if>
								</c:forEach>
							</select>
						</form>
					</td>
					<td><a href="#">Material Name</a></td>
					<td><a href="#">Remark</a></td>
					<td><a href="#">Length Range</a></td>
					<td><a href="#">Actual Length<br /> (Approx)
					</a></td>
					<td><a href="#">Quantity</a></td>
					<td><a href="#">Zone</a></td>
					<td><a href="#">Closed Date &amp; Time</a></td>
					<td><a href="#">Last Bidded Amount<br />(INR)
					</a></td>
					<td><a href="#">Status</a></td>
					<td><a href="#">Image</a></td>
				</tr>
				<c:forEach items="${bidItemsList}" var="bidItem" varStatus="status">
					<tr class="table">
						<td><input id="itemRow${bidItem.bidItemId}"
							<c:if test='${bidItemPrefferMap[bidItem.bidItemId] == 1}'><c:out value="checked"/></c:if>
							onclick="setPreference(this, ${bidItem.bidItemId}); blah(this);"
							type="checkbox" name="checkbox" id="checkbox" /> <script>setPreferenceDisplay('${bidItem.bidItemId}');</script>
						</td>
						<td><div id="seqId${bidItem.bidItemId}">${bidItem.serialNo}.</div></td>
						<td>


							<div class="modal fade" tabindex="-1" role="dialog"
								aria-labelledby="myModalLabel" id="dialog_desc${status.index+1}">
								<div class="modal-dialog" role="document"
									id="desc${status.index+1}">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="dialog_desc${status.index+1}">Description</h4>
										</div>
										<div class="modal-body">



											<table class="table table-bordered table-striped text-center">
												<tr>
													<td align="left" valign="top"><form name="form1"
															method="post" action="" style="margin: 0px;">
															<table
																class="table table-bordered table-striped text-center">
																<tr></tr>
																<tr>
																	<td>Sr. No.</td>
																	<td>Category</td>
																	<td>Lot No.</td>
																	<td>Material Name</td>
																	<td>Remark</td>
																	<td>Length Range</td>
																	<td>Actual Length <br> (Approx)
																	</td>
																	<td>Qty</td>
																	<td>Zone</td>
																</tr>
																<tr>
																	<td>${bidItem.serialNo}.</td>
																	<td>${bidItem.category.categoryName}</td>
																	<c:forEach items="${bidItem.itemLots}"
																		var="itemLotUnique" varStatus="status2">
																		<c:if test="${status2.index+1 == 1}">
																			<td>${itemLotUnique.lotNo}</td>
																		</c:if>
																	</c:forEach>

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
																	<c:if test="${fn:length(bidItem.itemLots) == 1}">
																		<c:forEach items="${bidItem.itemLots}"
																			var="itemLotUnique" varStatus="status2">
																			<td>${bidItem.zone}</td>
																		</c:forEach>
																	</c:if>
																	<c:if test="${fn:length(bidItem.itemLots) > 1}">
																		<td>&nbsp;</td>
																	</c:if>

																</tr>
																<c:if test="${fn:length(bidItem.itemLots) > 1}">
																	<c:forEach items="${bidItem.itemLots}" var="itemLot"
																		varStatus="status1">
																		<tr>
																			<td>${status1.index+1}</td>
																			<td>${bidItem.category.categoryName}</td>
																			<td>${itemLot.lotNo}</td>
																			<td>${itemLot.name}</td>
																			<td>${itemLot.remark}</td>
																			<td>${itemLot.lengthRange}</td>
																			<td>${itemLot.actualLengh}</td>
																			<td>${itemLot.quantity}${itemLot.unit}</td>
																			<td>${itemLot.zone}</td>
																		</tr>
																	</c:forEach>
																</c:if>
															</table>
														</form></td>
												</tr>
											</table>
											<div id="bidStartTime${bidItem.bidItemId}">${bidItem.bidStartTime}</div>
											<div id="minBidIncrement${bidItem.bidItemId}"
												style="display: none">${bidItem.minBidIncrement}</div>
										</div>
									</div>
								</div>
							</div> <input type="submit" name="button3" id="desc${status.index+1}"
							value="Desc" data-toggle="modal"
							data-target="#dialog_desc${status.index+1}" />
						</td>

						<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
							varStatus="status2">
							<c:if test="${status2.index+1 == 1}">
								<td>${itemLotUnique.lotNo}</td>
							</c:if>
						</c:forEach>
						<td>${bidItem.category.categoryName}</td>
						<td>
							<div id="bidItemName${bidItem.bidItemId}">${bidItem.name}</div> <a
							href="#services" class="LinkSelected"
							onclick="javascript:setIdForBiddingHistory(${bidItem.bidItemId});">${bidItem.name}</a>
						</td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td>${itemLotUnique.remark}</td>
								<td>${itemLotUnique.lengthRange}'</td>
								<td>${itemLotUnique.actualLengh}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="totalQuantity${bidItem.bidItemId}">
								${bidItem.totalQuantity} ${bidItem.unit}</div></td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${bidItem.zone}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td>&nbsp;</td>
						</c:if>
						<td><div id="endtimeMain${bidItem.bidItemId}">${bidItem.bidEndTime}</div></td>
						<td><div id="currentMarketPrice${bidItem.bidItemId}">${bidItem.currentMarketPrice}</div></td>
						<td>${bidItem.status}</td>
						<td><%-- <a href="${bidItem.imageUrl}" target="_blank"> --%> <img
								alt="" src="${bidItem.imageUrl}" height="80px" width="120px" onclick="window.open('${bidItem.imageUrl}', 'Large', 'width=500, height=350'); return false;"><!-- </a> --></td>
					</tr>
				</c:forEach>
			</table>
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
<body>
	<div class="container">
		<div class="mark-check1 mktlstcl">
			<form id="form1" name="form1" method="post" action=""
				style="margin: 0px;">
				<table class="table table-bordered table-striped text-center">
					<tr>
						<td colspan="3"><input type="radio" name="radio" id="radio"
							value="1" onclick="getPageForMarketType(this.value)" /> <a
							href="${bidder_market_url}">&nbsp;Market List</a></td>
						<td colspan="3"><input type="radio" name="radio" id="radio2"
							value="2" onclick="getPageForMarketType(this.value)" /> <a
							href="${bidder_active_url}">&nbsp;Active Market</a></td>
						<td colspan="3"><input type="radio" checked name="radio"
							id="radio3" value="3" /><a href="#">&nbsp;Closed Market</a></td>
						<td colspan="7" align="right"><strong>Total No. of
								Forward Markets in Active List: <c:out
									value="${fn:length(bidItemsList)}" />
						</strong></td>
					</tr>
				</table>
			</form>
		</div>
		<form:form action="${Paginationform_url}" name="paginationForm">
			<input type="hidden" name="page"
				value="<c:out value='${navigationInfo.currentPage}' />" />
			<input type="hidden" name="category" value="0" />
		</form:form>

		<div class="table-responsive user-map nofound itemlist">
			<table class="table table-bordered table-striped text-center">
				<tr>
					<td><display:table name="navigationInfo"
							requestURI="${Paginationform_url}" excludedParams="*"
							cellspacing="0px" cellpadding="0px 0px 0px 0px">
							<display:setProperty name="paging.banner.onepage" value="<br/>"></display:setProperty>
							<display:setProperty name="basic.msg.empty_list" value=""></display:setProperty>
							<display:setProperty name="basic.msg.empty_list_row" value=""></display:setProperty>
							<display:setProperty name="paging.banner.first">
								<table lass="table table-bordered table-striped text-center">
									<tr>
										<td><div style="width: 100%; text-align: center">
												<span class="pagelinks"> First | Prev&nbsp;<c:out
														value="${navigationInfo.pageSize}" /> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage+1}' />')"
													id="id3">Next&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.pageCount}' />')"
													id="id4">Last</a>
												</span>
											</div></td>
									</tr>
								</table>
							</display:setProperty>
							<display:setProperty name="paging.banner.full">
								<table class="table table-bordered table-striped text-center">
									<tr>
										<td><div style="width: 100%; text-align: center">
												<span class="pagelinks"> <a href="#"
													onclick="javascript: onSubmit('1')" id="id5">First</a> | <a
													href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage-1}' />')"
													id="id6">Prev&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage+1}' />')"
													id="id3">Next&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.pageCount}' />')"
													id="id4">Last </a>
												</span>
											</div></td>
									</tr>
								</table>
							</display:setProperty>
							<display:setProperty name="paging.banner.last">
								<table class="table table-bordered table-striped text-center">
									<tr>
										<td><div style="width: 100%; text-align: center">
												<span class="pagelinks"> <a href="#"
													onclick="javascript: onSubmit('1')" id="id5">First</a> | <a
													href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage-1}' />')"
													id="id6">Prev&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | Next&nbsp;<c:out
														value="${navigationInfo.pageSize}" /> | Last
												</span>
											</div></td>
									</tr>
								</table>
							</display:setProperty>
						</display:table></td>
				</tr>
			</table>
		</div>
		<div class="table-responsive user-map">
			<table class="table table-bordered table-striped text-center">

				<tr>
					<td><a href="#">Select</a></td>
					<td><a href="#">Sr. No</a><a href="#"></a></td>
					<td><a href="#">Description</a></td>
					<td><a href="#">Lot No.</a></td>
					<td>
						<form name="categoryform" action="closed" method="post">
							<select name="category" id="category"
								onChange="getResultForCategory()">
								<option value="0">All</option>
								<c:forEach var="bidderCategory" items="${bidderCategoryList}">
									<c:if
										test="${bidderCategory.bidderCategoryId.category.categoryId==categoryName}">
										<option
											value="${bidderCategory.bidderCategoryId.category.categoryId}"
											selected="selected">
											<c:out
												value="${bidderCategory.bidderCategoryId.category.categoryName}" />
										</option>
									</c:if>
									<c:if
										test="${bidderCategory.bidderCategoryId.category.categoryId!=categoryName}">
										<option
											value="${bidderCategory.bidderCategoryId.category.categoryId}">
											<c:out
												value="${bidderCategory.bidderCategoryId.category.categoryName}" />
										</option>
									</c:if>
								</c:forEach>
							</select>
						</form>
					</td>
					<td><a href="#">Material Name</a></td>
					<td><a href="#">Remark</a></td>
					<td><a href="#">Length Range</a></td>
					<td><a href="#">Actual Length<br /> (Approx)
					</a></td>
					<td><a href="#">Quantity</a></td>
					<td><a href="#">Zone</a></td>
					<td><a href="#">Closed Date &amp; Time</a></td>
					<td><a href="#">Last Bidded Amount<br />(INR)
					</a></td>
					<td><a href="#">Status</a></td>
					<td><a href="#">Image</a></td>
				</tr>
				<c:forEach items="${bidItemsList}" var="bidItem" varStatus="status">
					<tr class="table">
						<td><input id="itemRow${bidItem.bidItemId}"
							<c:if test='${bidItemPrefferMap[bidItem.bidItemId] == 1}'><c:out value="checked"/></c:if>
							onclick="setPreference(this, ${bidItem.bidItemId}); blah(this);"
							type="checkbox" name="checkbox" id="checkbox" /> <script>setPreferenceDisplay('${bidItem.bidItemId}');</script>
						</td>
						<td><div id="seqId${bidItem.bidItemId}">${bidItem.serialNo}.</div></td>
						<td>


							<div class="modal fade" tabindex="-1" role="dialog"
								aria-labelledby="myModalLabel" id="dialog_desc${status.index+1}">
								<div class="modal-dialog" role="document"
									id="desc${status.index+1}">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="dialog_desc${status.index+1}">Description</h4>
										</div>
										<div class="modal-body">



											<table class="table table-bordered table-striped text-center">
												<tr>
													<td align="left" valign="top"><form name="form1"
															method="post" action="" style="margin: 0px;">
															<table
																class="table table-bordered table-striped text-center">
																<tr></tr>
																<tr>
																	<td>Sr. No.</td>
																	<td>Category</td>
																	<td>Lot No.</td>
																	<td>Material Name</td>
																	<td>Remark</td>
																	<td>Length Range</td>
																	<td>Actual Length <br> (Approx)
																	</td>
																	<td>Qty</td>
																	<td>Zone</td>
																</tr>
																<tr>
																	<td>${bidItem.serialNo}.</td>
																	<td>${bidItem.category.categoryName}</td>
																	<c:forEach items="${bidItem.itemLots}"
																		var="itemLotUnique" varStatus="status2">
																		<c:if test="${status2.index+1 == 1}">
																			<td>${itemLotUnique.lotNo}</td>
																		</c:if>
																	</c:forEach>

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
																	<c:if test="${fn:length(bidItem.itemLots) == 1}">
																		<c:forEach items="${bidItem.itemLots}"
																			var="itemLotUnique" varStatus="status2">
																			<td>${bidItem.zone}</td>
																		</c:forEach>
																	</c:if>
																	<c:if test="${fn:length(bidItem.itemLots) > 1}">
																		<td>&nbsp;</td>
																	</c:if>

																</tr>
																<c:if test="${fn:length(bidItem.itemLots) > 1}">
																	<c:forEach items="${bidItem.itemLots}" var="itemLot"
																		varStatus="status1">
																		<tr>
																			<td>${status1.index+1}</td>
																			<td>${bidItem.category.categoryName}</td>
																			<td>${itemLot.lotNo}</td>
																			<td>${itemLot.name}</td>
																			<td>${itemLot.remark}</td>
																			<td>${itemLot.lengthRange}</td>
																			<td>${itemLot.actualLengh}</td>
																			<td>${itemLot.quantity}${itemLot.unit}</td>
																			<td>${itemLot.zone}</td>
																		</tr>
																	</c:forEach>
																</c:if>
															</table>
														</form></td>
												</tr>
											</table>
											<div id="bidStartTime${bidItem.bidItemId}">${bidItem.bidStartTime}</div>
											<div id="minBidIncrement${bidItem.bidItemId}"
												style="display: none">${bidItem.minBidIncrement}</div>
										</div>
									</div>
								</div>
							</div> <input type="submit" name="button3" id="desc${status.index+1}"
							value="Desc" data-toggle="modal"
							data-target="#dialog_desc${status.index+1}" />
						</td>

						<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
							varStatus="status2">
							<c:if test="${status2.index+1 == 1}">
								<td>${itemLotUnique.lotNo}</td>
							</c:if>
						</c:forEach>
						<td>${bidItem.category.categoryName}</td>
						<td>
							<div id="bidItemName${bidItem.bidItemId}">${bidItem.name}</div> <a
							href="#services" class="LinkSelected"
							onclick="javascript:setIdForBiddingHistory(${bidItem.bidItemId});">${bidItem.name}</a>
						</td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td>${itemLotUnique.remark}</td>
								<td>${itemLotUnique.lengthRange}'</td>
								<td>${itemLotUnique.actualLengh}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="totalQuantity${bidItem.bidItemId}">
								${bidItem.totalQuantity} ${bidItem.unit}</div></td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${bidItem.zone}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td>&nbsp;</td>
						</c:if>
						<td><div id="endtimeMain${bidItem.bidItemId}">${bidItem.bidEndTime}</div></td>
						<td><div id="currentMarketPrice${bidItem.bidItemId}">${bidItem.currentMarketPrice}</div></td>
						<td>${bidItem.status}</td>
						<td><a href="${bidItem.imageUrl}" target="_blank"> <img
								alt="" src="${bidItem.imageUrl}" height="80px" width="120px" onclick="window.open('${bidItem.imageUrl}', 'Large', 'width=500, height=350'); return false;"><!-- </a> --></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<div class="clr"></div>

	<script>


function setPreference(checkBoxObj, bidId)
{
	if(checkBoxObj.checked)
	{
		setPreffered(bidId)
	}
	else
	{
		removePreffered(bidId)
	}
	blah(document.getElementById("itemRow"+bidId));
}
function setPreffered(bidId) 
{
	 $.getJSON("setPreffered", { bidItemId:  bidId }, function(data){});	
}

function removePreffered(bidId) 
{
	 $.getJSON("removePreffered", { bidItemId:  bidId }, function(data){});	
}

</script>

</body>
 --%>