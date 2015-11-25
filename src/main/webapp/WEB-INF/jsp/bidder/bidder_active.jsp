<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/bidder" var="bidder_home_url" />
<spring:url value="/bidder/marketlist" var="bidder_market_url" />
<spring:url value="/bidder/closed" var="bidder_close_url" />
<head>
<script type='text/javascript'>
function changeStyleSelectedHover()
{
	if(document.getElementById("ranktd"))
	{
		document.getElementById("ranktd").style.background = "#d2e4b0";
	}
	if(document.getElementById("currentpricetd"))
	{
	document.getElementById("currentpricetd").style.background = "#d2e4b0";
	}
}
function changeStyleSelectedOut()
{
	if(document.getElementById("ranktd"))
	{
		document.getElementById("ranktd").style.background = "#eaedf4";
	}
	if(document.getElementById("currentpricetd"))
	{
	document.getElementById("currentpricetd").style.background = "#eaedf4";
	}
}
function setNextBidDisabled(nextBidButton)
{
	if(document.getElementById(nextBidButton))
		{
		document.getElementById(nextBidButton).disabled = true;
		document.getElementById(nextBidButton).style.color = "#C0BFBF";
		}
}
	function setPreferenceDisplay(bidId) {
		blah(document.getElementById("itemRow"+bidId));
	}

	function display( notifier, str ) {
    	document.getElementById(notifier).innerHTML = str;
	}
	
	function toHourAndMinuteAndSecond( x ) {
    	return Math.floor(x/3600) + ":" + Math.floor((x%3600)/60) + ":" + x%60;
	}
 	
	var timeSpans = new Array();
	var bidItemIds = new Array();
  	
  	function setTimeLefts( remain, bidItemId) {
		timeSpans.push(remain);
		bidItemIds.push(bidItemId);
  	}

  	function displayTimes()	{
  		var extendTime = document.getElementById("extn").value;
 		var count = document.getElementById("lLCount").value;
  		if(count > 5) { return false; }
   		for(i = 0; i < bidItemIds.length; i++) {
  			ts = timeSpans[i];
  			ex = parseInt(extendTime);
  			diff = 0;
  			if(i == 0 && ex > 0) {
  				diff = ex - ts;
  				if(diff < 0) diff = 0;
   				timeSpans[0] = ex;
  			}
  			else {
  				timeSpans[i] += diff;
  			}
  			
  			if(timeSpans[i] <= 0) {
  				refreshPage();
  			}
  			else {
  				document.getElementById("countdown"+bidItemIds[i]).innerHTML = toHourAndMinuteAndSecond(timeSpans[i]);
  	  			timeSpans[i] -= 1;
  			}
  		}
  		document.getElementById("extn").value = 0;
  		setTimeout("displayTimes()",1000);
  	}

  	function refreshPage() {
  		var count = document.getElementById("lLCount").value;
  		var timee = document.getElementById("lLTime").value;
  		var currentTime = new Date();
  		diff = currentTime.getTime() - parseInt(timee);
  		if(diff < 15000) {
  			document.getElementById("lLCount").value = parseInt(count) + 1;
  			document.getElementById("lLTime").value = currentTime.getTime();
  			return false;
  		}
  		document.getElementById("lLTime").value = currentTime.getTime();
  		window.location.reload(true); 
  	}
</script>

<script type="text/javascript">
function getResultForCategory()
{
	document.forms["categoryform"].submit();
}

/* function getPageForMarketType(marketType)
{
	var location1 = ""
	if(marketType == "1")
		location1 = "${bidder_home_url}/marketlist";
	else if(marketType == "2")
		location1 = "${bidder_home_url}/active";
	else if(marketType == "3")
		location1 = "${bidder_home_url}/closed";		
	window.location.href=location1
} */

window.onload = function() {
}

</script>

<script type="text/javascript">
			$(function(){
				
				// Dialog			
				$('.dialog').dialog({
					autoOpen: false,
					width:'auto',
					close: function(ev, ui) 
	                {
	                    $(this).close;
	                },
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
				$('#dialog_'+$(this).attr('id')).dialog('open');
					$('.dialog').dialog('open');
					return false;
				});
		
				$('.changeamot').click(function(){
					$('#dialog_'+$(this).attr('id')).dialog('open');
					$('.amt').dialog('open');
					return false;
				});
				$('.description').click(function(){
				
					$('.desc').dialog('open');
					//alert(this);
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
    
    changeStyleSelectedHover();
}
</script>
<!--End-->
<style type="text/css">
<!--
.disabledButton {
	background: url("${images_url}/ui-bg_glass_100_f6f6f6_1x400.png")
		repeat-x scroll 50% 50% #F6F6F6;
	border: 1px solid #CCCCCC;
	color: #C0BFBF;
	cursor: pointer;
	font: bold 12px Arial, Helvetica, sans-serif;
	padding: 5px;
	text-decoration: none;
}

.td1 {
	background-color: #e9edf3;
	color: #ff0000;
}

.td3 {
	background-color: #d0d7e7;
	color: #ff0000;
}

.ttip {
	border: 1px solid black;
	font-size: 12px;
	layer-background-color: lightyellow;
	background-color: lightyellow
}
-->
</style>

</head>
<spring:url value="/static/adminthemecontent" var="theme_url" />
<body class="hold-transition skin-blue sidebar-mini"
	onload="displayTimes();">
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

				<input id="extn" type="hidden" name="extn" value="0" /> <input
					id="lLTime" type="hidden" name="lastLoadTime" value="0" /> <input
					id="lLCount" type="hidden" name="freqCounts" value="0" /> <span
					id="pollStatus"></span>
				<div id="error"></div>
				<div class="mark-check1 mktlst">
					<form id="form1" name="form1" method="post" action=""
						style="margin: 0px;">
						<table class="table table-bordered table-striped text-center">
							<tr>
								<td colspan="3"><input type="radio" name="radio" id="radio"
									value="1" onClick="getPageForMarketType(this.value)" /> <a
									href="${bidder_market_url}">&nbsp;Market List</a></td>
								<td colspan="3"><input type="radio" checked name="radio"
									id="radio2" value="2" /> <a href="#">&nbsp;Active Market</a></td>
								<td colspan="3"><input type="radio" name="radio"
									id="radio3" value="3"
									onClick="getPageForMarketType(this.value)" /> <a
									href="${bidder_close_url}">&nbsp;Closed Market</a></td>

								<td colspan="8" align="right"><strong>Total No. of
										Forward Markets in Active List: <c:out
											value="${fn:length(bidItemsList)}" />
								</strong></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="table-responsive user-map nofound itemlist">

					<!-- <table class="table table-bordered table-striped text-center">
				<tr>
					<td width="100%" height="10px" align="right">&nbsp;</td>
				</tr>
			</table> -->

					<table class="table table-bordered table-striped text-center">

						<tr>
							<td><a href="#">Select</a></td>
							<td><a href="#">Sr. No</a></td>
							<td><a href="#">Description</a></td>
							<td><a href="#">Lot No.</a></td>
							<td class="vikd">
								<form name="categoryform" action="active" method="get">
									<select name="category" id="category"
										onchange="getResultForCategory()">

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
							<td><a href="#">Actual Length<br />(Approx)
							</a></td>
							<td><a href="#">Quantity</a></td>
							<td><a href="#">Zone</a></td>
							<td><a href="#">Min Increment</a></td>
							<td><a href="#">Current Price (INR)</a></td>
							<td><a href="#">Rank</a><a href="#"
								onmouseover="changeStyleSelectedHover();"
								onMouseout="changeStyleSelectedOut();"></a></td>
							<td><a href="#">Time Left</a></td>
							<td><a href="#">Next Bid</a><a href="#"></a></td>
							<td><a href="#"> Other Bids</a></td>
							<td><a href="#">Image</a></td>
						</tr>
						<c:forEach items="${bidItemsList}" var="bidItem"
							varStatus="status">
							<div id="bidStartTime${bidItem.bidItemId}" style="display: none">${bidItem.bidStartTime}</div>
							<tr class="table" onmouseover="changeStyleSelectedHover()"
								onmouseout="changeStyleSelectedOut()">
								<td class="DetailBorRight"><input
									id="itemRow${bidItem.bidItemId}"
									<c:if test='${bidItemPrefferMap[bidItem.bidItemId] == 1}'><c:out value="checked"/></c:if>
									onclick="setPreference(this, ${bidItem.bidItemId}); blah(this);"
									type="checkbox" name="checkbox" id="checkbox" /> <script>setPreferenceDisplay('${bidItem.bidItemId}');</script>
								</td>
								<td class="DetailBorRight"><div
										id="seqId${bidItem.bidItemId}">${bidItem.serialNo}.</div></td>
								<td>

									<div class="modal fade" id="dialog_desc${status.index+1}"
										tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title" id="myModalLabel">Description</h4>
												</div>
												<div class="modal-body">
													<div id="dialog_desc${status.index+1}"
														title="Item Description" class="table-responsive user-map">
														<table
															class="table table-bordered table-striped text-center">
															<tr>
																<td align="left" valign="top">
																	<form name="form1" method="post" action="">
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
																						<td><div
																								id="categoryName${bidItem.bidItemId}">${bidItem.category.categoryName}</div></td>
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
																	</form>
																</td>
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
								<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
									varStatus="status2">
									<c:if test="${status2.index+1 == 1}">
										<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
									</c:if>
								</c:forEach>

								<td>${bidItem.category.categoryName}</td>
								<td>
									<div id="bidItemName${bidItem.bidItemId}" style="display: none">${bidItem.name}</div>
									<a href="#" class="LinkSelected"
									onclick="javascript:setIdForBiddingHistory(${bidItem.bidItemId});">${bidItem.name}</a>
								</td>
								<c:if test="${fn:length(bidItem.itemLots) == 1}">
									<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
										varStatus="status2">
										<td>${itemLotUnique.remark}</td>
										<td>${itemLotUnique.lengthRange}</td>
										<td>${itemLotUnique.actualLengh}</td>
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(bidItem.itemLots) > 1}">
									<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
									<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
									<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
								</c:if>
								<td align="center" valign="middle" class="DetailBorRight"><div
										id="totalQuantity${bidItem.bidItemId}">${bidItem.totalQuantity}
										${bidItem.unit}</div></td>
								<c:if test="${fn:length(bidItem.itemLots) == 1}">
									<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
										varStatus="status2">
										<td align="center" valign="middle" class="DetailBorRight">${bidItem.zone}</td>
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(bidItem.itemLots) > 1}">
									<td>&nbsp;</td>
								</c:if>


								<td><div id="minBidIncrement${bidItem.bidItemId}">${bidItem.minBidIncrement}</div></td>
								<td>
									<div id="Item${bidItem.bidItemId}">${bidItem.currentMarketPrice}</div>
								</td>
								<td id="ranktd">
									<div id="rank${bidItem.bidItemId}">
										<c:out value='${bidItemWithRanks[bidItem.bidItemId]}' />
									</div>
								</td>
								<td>
									<div id="countdown${bidItem.bidItemId}"></div> <script>setTimeLefts(parseInt('${bidItem.timeLeft}'), '${bidItem.bidItemId}');</script>

								</td>
								<td><c:choose>
										<c:when
											test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1} '>
											<input type="submit" name="button3"
												id="NextBid${bidItem.bidItemId}" value="Next Bid"
												onclick="doNextBid('${bidItem.bidItemId}', '${bidItem.minBidIncrement}'); return false;"
												disabled="disabled" />
										</c:when>
										<c:otherwise>
											<input type="submit" name="button3"
												id="NextBid${bidItem.bidItemId}" value="Next Bid"
												onclick="doNextBid('${bidItem.bidItemId}', '${bidItem.minBidIncrement}'); return false;" />
										</c:otherwise>
									</c:choose></td>
								<td align="center" class="DetailBorLast"><c:choose>
										<c:when
											test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1}'>
											<div class="modal fade"
												id="dialog_dialog${bidItem.bidItemId}" tabindex="-1"
												role="dialog" aria-labelledby="myModalLabel">
												<div class="modal-dialog" role="document">
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal"
																aria-label="Close">
																<span aria-hidden="true">&times;</span>
															</button>
															<h4 class="modal-title" id="myModalLabel">Bid</h4>
														</div>
														<div class="modal-body">
															<div class="amt" id="dialog_amt${bidItem.bidItemId}"
																title="Change AutoBid">
										</c:when>
										<c:otherwise>

											<div class="modal fade"
												id="dialog_dialog${bidItem.bidItemId}" tabindex="-1"
												role="dialog" aria-labelledby="myModalLabel">
												<div class="modal-dialog" role="document">
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal"
																aria-label="Close">
																<span aria-hidden="true">&times;</span>
															</button>
															<h4 class="modal-title" id="myModalLabel">Bid</h4>
														</div>
														<div class="modal-body">

															<div class="dialog"
																id="dialog_dialog${bidItem.bidItemId}" title="Bid">
										</c:otherwise>
									</c:choose>

									<table class="table table-bordered table-striped text-center">
										<tr>
											<td>
												<form action="" method="post" name="form1" id="form2">
													<table
														class="table table-bordered table-striped text-center">
														<tr>
															<td>${status.index+1}.</td>
															<td>${bidItem.name}
																&nbsp;&nbsp;&nbsp;&nbsp;${bidItem.totalQuantity}
																${bidItem.unit}</td>
														</tr>
														<tr>
															<td>&nbsp; Bid Type</td>
															<td>
																<table
																	class="table table-bordered table-striped text-center">
																	<tr>
																		<td><input type="radio" name="radio"
																			id="NormalBid${bidItem.bidItemId}" value="radio"
																			onclick="changeBidText(1, '${bidItem.bidItemId}')" /></td>
																		<td>Normal Bid</td>
																		<td><input type="radio" name="radio"
																			id="AutoBid${bidItem.bidItemId}" value="radio"
																			onclick="changeBidText(2, '${bidItem.bidItemId}')" /></td>
																		<td>Auto Bid</td>
																	</tr>
																</table>
															</td>
														</tr>
														<tr>
															<td><c:if
																	test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 1}'>
																	<div id="bidAmountText${bidItem.bidItemId}">&nbsp;Bid
																		amount</div>
																</c:if> <c:if
																	test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2}'>
																	<div id="autoBidText${bidItem.bidItemId}">&nbsp;Auto
																		Bid Limit</div>
																</c:if></td>
															<td><input type="text" name="textfield"
																id="Amount${bidItem.bidItemId}" /></td>
														</tr>
														<tr>
															<td>&nbsp;&nbsp;Comments</td>
															<td><textarea name="textfield2"
																	id="Comments${bidItem.bidItemId}"></textarea></td>
														</tr>
														<tr>
															<td>&nbsp;</td>
															<td colspan="2"><input type="submit" name="button"
																id="button" value="Submit"
																onclick="doBid('${bidItem.bidItemId}', '${bidItem.currentMarketPrice}', '${bidItem.minBidIncrement}'); return false;" /></td>
														</tr>
													</table>
												</form>
											</td>
										</tr>
									</table>
									</div>

									</div>
									</div>
									</div>
									</div>



									<div id="bidButtonDiv${bidItem.bidItemId}">
										<c:choose>
											<c:when
												test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1}'>
												<div id='actualAutoBid${bidItem.bidItemId}'>
													<c:out value="${bidItem.amountAutoBid}" />
												</div>
												<script>setNextBidDisabled('NextBid${bidItem.bidItemId}');</script>
												<input type="submit" name="button7"
													id="bidSubmit${bidItem.bidItemId}" value="Change AutoBid"
													onclick="setAttributes(this.value, '${bidItem.bidItemId}','${bidItem.minBidIncrement}'); return false;"
													data-toggle="modal"
													data-target="#dialog_dialog${bidItem.bidItemId}" />
											</c:when>
											<c:otherwise>
												<input type="submit" name="button3"
													id="bidSubmit${bidItem.bidItemId}" value="Bid"
													onclick="setAttributes(this.value, '${bidItem.bidItemId}','${bidItem.minBidIncrement}'); return false;"
													data-toggle="modal"
													data-target="#dialog_dialog${bidItem.bidItemId}" />
											</c:otherwise>
										</c:choose>
									</div></td>

								<td><a href="${bidItem.imageUrl}" target="_blank"> <img
										alt="" src="${bidItem.imageUrl}" height="80px" width="120px"
										onclick="window.open('${bidItem.imageUrl}', 'Large', 'width=500, height=350'); return false;">
										<!-- </a> --></td>

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


<script type="text/javascript">

function isNumber(n) {
	  return !isNaN(parseFloat(n)) && isFinite(n);
	}

function doBid(bidId, curMarketPrice, minBidIncrement)
{
	var location1 = "";
	var NewcurMarketPrice = document.getElementById("Item"+bidId).innerHTML;
	var bidTypeObj = "NormalBid"+bidId
	//alert("bidTypeObj " + bidTypeObj)
	var bidType = 1;
	var bidTypeElem = document.getElementById(bidTypeObj).checked
	if(bidTypeElem)
		{
		bidType = 1;
		}
	else
		{
		bidType = 2;
		}
	var bidAmountObj = "Amount"+bidId
	//alert(bidAmountObj)
	var bidAmount = document.getElementById(bidAmountObj).value
	
	if(!isNumber(bidAmount))
	{
		alert("Amount provided is not a number: " + bidAmount)
		return false;
	}
	var parsedBidAmount = parseFloat(bidAmount)
	var parsedCurMarketPrice = parseFloat(NewcurMarketPrice)
	var parsedMinBidIncrement = parseFloat(minBidIncrement)
	
	if(parsedBidAmount < (parsedCurMarketPrice+parsedMinBidIncrement))
	{
		alert("Amount provided is less than current market price plus minimum bid increment amount")	
		return false;
	}
	
	var calculation = (parsedBidAmount - parsedCurMarketPrice) % parsedMinBidIncrement ;
	//alert("calculation " + calculation)
	if(calculation != 0)
	{
		alert("Not a valid multiple of minimum bid increment")
		return false;
	}
	//alert("Bid Accepted: Please click Refresh for result");
	//alert(bidAmount)
	var commentsObj = "Comments"+bidId;
	//alert(comments)
	var comments = document.getElementById(commentsObj).value
	//onBidClick(bidAmount,bidId);
	var actualBidDialog = document.getElementById('dialog_dialog'+bidId);
	if(actualBidDialog)
	{
		$('#dialog_dialog'+bidId).modal('hide');
	}
	else
	{
		$('#dialog_amt'+bidId).modal('hide');
		
		//$('#dialog_amt'+bidId).dialog("close");
	}
	//CometPusher.onSubmit(bidId, bidType, bidAmount, handleGetData);
	//location1 = "${bidder_home_url}/bid/"+bidId+"/"+bidType+"/"+bidAmount
	//alert("location1 " + location1)
	
	//window.location.href=location1
	var flag;
	if(bidType == 1){
		flag=confirm("Are you sure you want to bid for amount - " + bidAmount + " , then Press OK");
	}
	else {
		flag=confirm("Are you sure you want to put auto bid amount - " + bidAmount + " , then Press OK");
	}
	if(flag == true) {
		$.getJSON("bid", { bidItemId:  bidId,
			bidType: bidType,
  			bidAmount:  bidAmount, comments: comments }, function(data){ 
  				//alert("It worked");
		});	
	 setNextBidDisabled('NextBid'+bidId);
	}
	 
	return false;
	
}

function doNextBid(bidItemId, minIncrementAmount)
{
	var curPriceObject = document.getElementById("Item"+bidItemId).innerHTML;	
	var nextBidPrice = parseFloat(curPriceObject) + parseFloat(minIncrementAmount);
	var flag;
	flag=confirm("Are you sure you want to put next bid for amount - " + nextBidPrice + " , then Press OK");
	//alert("In doNextBid " + bidItemId + " " + nexBidPrice + " " + minIncrementAmount)
	if(flag == true) {
		$.getJSON("bid", { bidItemId:  bidItemId,
			bidType: 1,
				bidAmount:  nextBidPrice, comments: "Next Bid" }, function(data){ 
					//alert("It worked");
	    });
		setNextBidDisabled('NextBid'+bidItemId);
	}	
	
}
function changeBidText(bidType, bidItemId)
{
	if(bidType == 1)
	{
		if(document.getElementById("bidAmountText" + bidItemId))
			document.getElementById("bidAmountText" + bidItemId).style.display = "block";
		if(document.getElementById("autoBidText" + bidItemId))
			document.getElementById("autoBidText" + bidItemId).style.display = "none";
	}
	else
	{
		if(document.getElementById("bidAmountText" + bidItemId))
			document.getElementById("bidAmountText" + bidItemId).style.display = "none";
		if(document.getElementById("autoBidText" + bidItemId))
			document.getElementById("autoBidText" + bidItemId).style.display = "block";
	}
}

function checkRadioButton(bidItemId, bidType)
{
	if(bidType==1)
		document.getElementById("NormalBid" + bidItemId).checked = true;
	else
		document.getElementById("AutoBid" + bidItemId).checked = true;
}
function resetTextColor(bitItemId)
{
		document.getElementById('ranktd').style.background = '#EAEDF4';	
		document.getElementById('currentpricetd').style.background = '#EAEDF4';
		if(document.getElementById("itemRow"+bitItemId) && document.getElementById("itemRow"+bitItemId).checked) 
			changeStyleSelectedHover();
	
}
function update(message){
	//alert(message + " hello")
	var str = message.split(":");
	var bitItemId = str[0];
	
	var rankHtml = str[1];
	document.getElementById('currentpricetd').style.background = '#bbd5e6';
	if(rankHtml != 0)
	{
		var divRank = document.getElementById("rank"+bitItemId);
		document.getElementById('ranktd').style.background = '#bbd5e6';
		divRank.innerHTML = rankHtml; //str[1];
	}
	setTimeout("resetTextColor("+bitItemId+")",3000);
  	updateScreen(bitItemId, str[2]);
  	if(str[2] == "2")
  	{
	  	var divActualAutoBid = document.getElementById("actualAutoBid"+bitItemId);
	  	if(divActualAutoBid)
	  	{
	  		divActualAutoBid.innerHTML = str[3];  		
	  	}
	  	else
	  	{
	  			var bidButtonDiv  = document.getElementById("bidButtonDiv"+bitItemId);
	  			if(bidButtonDiv)
	  			{
	  				var newDiv = document.createElement('div');  			
		  			var divId = "actualAutoBid"+bitItemId;
		  			newDiv.setAttribute("id", divId)
		  			newDiv.innerHTML = str[3];
		  			bidButtonDiv.insertBefore(newDiv, bidButtonDiv.firstChild);	
	  			}
	  			
	  	}
  	}
  	else
  	{
		var actualAutoBidDiv = document.getElementById("actualAutoBid"+bitItemId);
		if(actualAutoBidDiv)
		{
			actualAutoBidDiv.innerHTML = ""
		}
		else
		{
			var bidButtonDiv  = document.getElementById("bidButtonDiv"+bitItemId);
			if(bidButtonDiv)
			{
				//if(bidButtonDiv.firstChild) bidButtonDiv.firstChild.innerHTML = ""
			}
			
		}
  	}
 	
}

function updateScreen(bidItemId, val){
	if(val == "2")
	{
			document.getElementById("bidSubmit"+bidItemId).value = "Change AutoBid";
			document.getElementById("NormalBid" + bidItemId).disabled = true;
			//alert(document.getElementById("NormalBid" + bidItemId).style);
			//document.getElementById("NormalBid" + bidItemId).style.class = "disabledButton";
			
			//document.getElementById("NormalBid" + bidItemId).checked = false;
			document.getElementById("NextBid" + bidItemId).disabled = true;
			//document.getElementById("NextBid" + bidItemId).style.class = "disabledButton";
			document.getElementById("AutoBid" + bidItemId).checked = true;
			document.getElementById("NormalBid" + bidItemId).style.color = "#C0BFBF";
			document.getElementById("NextBid" + bidItemId).style.color = "#C0BFBF";
			changeBidText(2, bidItemId);
	}
	else
	{
			document.getElementById("bidSubmit" + bidItemId).value = "Bid";
			document.getElementById("NormalBid" + bidItemId).disabled = false;
			//document.getElementById("NormalBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
			document.getElementById("NextBid" + bidItemId).disabled = false;
			//document.getElementById("NextBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
			document.getElementById("NormalBid" + bidItemId).checked = true;
			document.getElementById("NormalBid" + bidItemId).style.color = "#1c94c4";
			document.getElementById("NextBid" + bidItemId).style.color = "#1c94c4";
			document.getElementById("NextBid" + bidItemId).enabled = true;
			changeBidText(1, bidItemId);
	}
}

function enableNormalBidButton(bidItemId)
{
	document.getElementById("NormalBid" + bidItemId).checked = true;
	document.getElementById("NormalBid" + bidItemId).enabled = true;
	document.getElementById("NextBid" + bidItemId).enabled = true;
	//document.getElementById("NormalBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
	//document.getElementById("NextBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
	document.getElementById("NormalBid" + bidItemId).style.color = "#1c94c4";
	document.getElementById("NextBid" + bidItemId).style.color = "#1c94c4";
}
function disableNormalBidButton(bidItemId)
{
	document.getElementById("NormalBid" + bidItemId).disabled = true;
	document.getElementById("NextBid" + bidItemId).disabled = true;
	//document.getElementById("NormalBid" + bidItemId).style.class = "disabledButton";
	//document.getElementById("NextBid" + bidItemId).style.class = "disabledButton";
	document.getElementById("NormalBid" + bidItemId).style.color = "#C0BFBF";
	document.getElementById("NextBid" + bidItemId).style.color = "#C0BFBF";
}

function updatePollStatus(pollStatus) {
    //dwr.util.setValue("pollStatus", pollStatus ? "<font color='green'>Online</font>" : "<font color='red'>Offline</font>", {escapeHtml:false});
}

function fn()
{
    dwr.engine.setActiveReverseAjax(true); // Initiate reverse ajax polling
    dwr.engine.setNotifyServerOnPageUnload(true);
    dwr.engine.setErrorHandler(errorHandler); // Optional - Called when a call and all retry attempts fail
    dwr.engine.setPollStatusHandler(updatePollStatus); // Optional - function to call when the reverse ajax status changes (e.g. online to offline)
    updatePollStatus(true); // Optional - We are online right now!  Until DWR determines we are not!    
}
fn();

window.onunload = function() {
	//var param = "<security:authentication property='principal.username'/>"+"bidder_active";
	//removeScriptSession(param);
    dwr.engine.setActiveReverseAjax(false);
}

function errorHandler(message, ex) {
    dwr.util.setValue("error", "<font color='red'>Cannot connect to server. Initializing retry logic.</font>", {escapeHtml:false});
    setTimeout(function() { dwr.util.setValue("error", ""); }, 5000)
}
	  

function setAmount(bidItemId, minIncrementAmount, bidType)
{
	if(bidType == 1)
	{
		var curPriceObject = document.getElementById("Item"+bidItemId).innerHTML;
		
		var nexBidPrice = parseFloat(curPriceObject) + parseFloat(minIncrementAmount);
		
		//alert("nexBidPrice " + nexBidPrice);
		document.getElementById("Amount"+bidItemId).value = nexBidPrice;
	}
	else
	{
		if(document.getElementById("actualAutoBid"+bidItemId))
			{
			var curAutoBid = document.getElementById("actualAutoBid"+bidItemId).innerHTML;
			
			document.getElementById("Amount"+bidItemId).value = curAutoBid;
			}
		
	}
}

function setAttributes(bidButtonType, bitItemId, minBidIncrement)
{
	
	
	if(bidButtonType == "Bid")
	{
		setAmount(bitItemId, minBidIncrement, 1); 
		enableNormalBidButton(bitItemId); 
		changeBidText(1, bitItemId); 	
		checkRadioButton(bitItemId, '1'); 
		var actualAutoBid = document.getElementById("actualAutoBid"+bitItemId)
		if(actualAutoBid)
			actualAutoBid.innerHTML = "";
		
		/* $('#dialog_dialog'+bitItemId).modal({
		    show: 'false'
		});  */
		
		
		$('#dialog_dialog'+bitItemId).on('show.bs.modal');
		/*  $('#dialog_dialog'+bitItemId).modal('toggle');  */
		
	}
	if(bidButtonType == "Change AutoBid")
	{
		setAmount(bitItemId, minBidIncrement, 2); 
		disableNormalBidButton(bitItemId); 
		changeBidText(2, bitItemId);	 
		checkRadioButton(bitItemId, '2');
		$('#dialog_amt'+bitItemId).on('show.bs.modal');
	}
}


function setPreference(checkBoxObj, bidId)
{
	if(checkBoxObj.checked)
	{
		setPreffered(bidId);
	}
	else
	{
		removePreffered(bidId)
	}
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






<%-- <body onload="displayTimes();">
	<%@ include file="/WEB-INF/jsp/bidder/bidder_top.jsp"%>
	<div class="container">

		<input id="extn" type="hidden" name="extn" value="0" /> <input
			id="lLTime" type="hidden" name="lastLoadTime" value="0" /> <input
			id="lLCount" type="hidden" name="freqCounts" value="0" /> <span
			id="pollStatus"></span>
		<div id="error"></div>
		<div class="mark-check1 mktlst">
			<form id="form1" name="form1" method="post" action=""
				style="margin: 0px;">
				<table class="table table-bordered table-striped text-center">
					<tr>
						<td colspan="3"><input type="radio" name="radio" id="radio"
							value="1" onClick="getPageForMarketType(this.value)" /> <a
							href="${bidder_market_url}">&nbsp;Market List</a></td>
						<td colspan="3"><input type="radio" checked name="radio"
							id="radio2" value="2" /> <a href="#">&nbsp;Active Market</a></td>
						<td colspan="3"><input type="radio" name="radio" id="radio3"
							value="3" onClick="getPageForMarketType(this.value)" /> <a
							href="${bidder_close_url}">&nbsp;Closed Market</a></td>

						<td colspan="8" align="right"><strong>Total No. of
								Forward Markets in Active List: <c:out
									value="${fn:length(bidItemsList)}" />
						</strong></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="table-responsive user-map nofound itemlist">

			<!-- <table class="table table-bordered table-striped text-center">
				<tr>
					<td width="100%" height="10px" align="right">&nbsp;</td>
				</tr>
			</table> -->

			<table class="table table-bordered table-striped text-center">

				<tr>
					<td><a href="#">Select</a></td>
					<td><a href="#">Sr. No</a></td>
					<td><a href="#">Description</a></td>
					<td><a href="#">Lot No.</a></td>
					<td class="vikd">
						<form name="categoryform" action="active" method="get">
							<select name="category" id="category"
								onchange="getResultForCategory()">

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
					<td><a href="#">Actual Length<br />(Approx)
					</a></td>
					<td><a href="#">Quantity</a></td>
					<td><a href="#">Zone</a></td>
					<td><a href="#">Min Increment</a></td>
					<td><a href="#">Current Price (INR)</a></td>
					<td><a href="#">Rank</a><a href="#"
						onmouseover="changeStyleSelectedHover();"
						onMouseout="changeStyleSelectedOut();"></a></td>
					<td><a href="#">Time Left</a></td>
					<td><a href="#">Next Bid</a><a href="#"></a></td>
					<td><a href="#"> Other Bids</a></td>
					<td><a href="#">Image</a></td>
				</tr>
				<c:forEach items="${bidItemsList}" var="bidItem" varStatus="status">
					<div id="bidStartTime${bidItem.bidItemId}" style="display: none">${bidItem.bidStartTime}</div>
					<tr class="table" onmouseover="changeStyleSelectedHover()"
						onmouseout="changeStyleSelectedOut()">
						<td class="DetailBorRight"><input
							id="itemRow${bidItem.bidItemId}"
							<c:if test='${bidItemPrefferMap[bidItem.bidItemId] == 1}'><c:out value="checked"/></c:if>
							onclick="setPreference(this, ${bidItem.bidItemId}); blah(this);"
							type="checkbox" name="checkbox" id="checkbox" /> <script>setPreferenceDisplay('${bidItem.bidItemId}');</script>
						</td>
						<td class="DetailBorRight"><div
								id="seqId${bidItem.bidItemId}">${bidItem.serialNo}.</div></td>
						<td>

							<div class="modal fade" id="dialog_desc${status.index+1}"
								tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="myModalLabel">Description</h4>
										</div>
										<div class="modal-body">
											<div id="dialog_desc${status.index+1}"
												title="Item Description" class="table-responsive user-map">
												<table
													class="table table-bordered table-striped text-center">
													<tr>
														<td align="left" valign="top">
															<form name="form1" method="post" action="">
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
																				<td><div id="categoryName${bidItem.bidItemId}">${bidItem.category.categoryName}</div></td>
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
															</form>
														</td>
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
						<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
							varStatus="status2">
							<c:if test="${status2.index+1 == 1}">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
							</c:if>
						</c:forEach>

						<td>${bidItem.category.categoryName}</td>
						<td>
							<div id="bidItemName${bidItem.bidItemId}" style="display: none">${bidItem.name}</div>
							<a href="#" class="LinkSelected"
							onclick="javascript:setIdForBiddingHistory(${bidItem.bidItemId});">${bidItem.name}</a>
						</td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td>${itemLotUnique.remark}</td>
								<td>${itemLotUnique.lengthRange}</td>
								<td>${itemLotUnique.actualLengh}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="totalQuantity${bidItem.bidItemId}">${bidItem.totalQuantity}
								${bidItem.unit}</div></td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${bidItem.zone}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td>&nbsp;</td>
						</c:if>


						<td><div id="minBidIncrement${bidItem.bidItemId}">${bidItem.minBidIncrement}</div></td>
						<td>
							<div id="Item${bidItem.bidItemId}">${bidItem.currentMarketPrice}</div>
						</td>
						<td id="ranktd">
							<div id="rank${bidItem.bidItemId}">
								<c:out value='${bidItemWithRanks[bidItem.bidItemId]}' />
							</div>
						</td>
						<td>
							<div id="countdown${bidItem.bidItemId}"></div> <script>setTimeLefts(parseInt('${bidItem.timeLeft}'), '${bidItem.bidItemId}');</script>

						</td>
						<td><c:choose>
								<c:when
									test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1} '>
									<input type="submit" name="button3"
										id="NextBid${bidItem.bidItemId}" value="Next Bid"
										onclick="doNextBid('${bidItem.bidItemId}', '${bidItem.minBidIncrement}'); return false;"
										disabled="disabled" />
								</c:when>
								<c:otherwise>
									<input type="submit" name="button3"
										id="NextBid${bidItem.bidItemId}" value="Next Bid"
										onclick="doNextBid('${bidItem.bidItemId}', '${bidItem.minBidIncrement}'); return false;" />
								</c:otherwise>
							</c:choose></td>
						<td align="center" class="DetailBorLast"><c:choose>
								<c:when
									test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1}'>
									<div class="modal fade" id="dialog_dialog${bidItem.bidItemId}"
										tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title" id="myModalLabel">Bid</h4>
												</div>
												<div class="modal-body">
													<div class="amt" id="dialog_amt${bidItem.bidItemId}"
														title="Change AutoBid">
								</c:when>
								<c:otherwise>

									<div class="modal fade" id="dialog_dialog${bidItem.bidItemId}"
										tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title" id="myModalLabel">Bid</h4>
												</div>
												<div class="modal-body">

													<div class="dialog" id="dialog_dialog${bidItem.bidItemId}"
														title="Bid">
								</c:otherwise>
							</c:choose>

							<table class="table table-bordered table-striped text-center">
								<tr>
									<td>
										<form action="" method="post" name="form1" id="form2">
											<table class="table table-bordered table-striped text-center">
												<tr>
													<td>${status.index+1}.</td>
													<td>${bidItem.name}
														&nbsp;&nbsp;&nbsp;&nbsp;${bidItem.totalQuantity}
														${bidItem.unit}</td>
												</tr>
												<tr>
													<td>&nbsp; Bid Type</td>
													<td>
														<table
															class="table table-bordered table-striped text-center">
															<tr>
																<td><input type="radio" name="radio"
																	id="NormalBid${bidItem.bidItemId}" value="radio"
																	onclick="changeBidText(1, '${bidItem.bidItemId}')" /></td>
																<td>Normal Bid</td>
																<td><input type="radio" name="radio"
																	id="AutoBid${bidItem.bidItemId}" value="radio"
																	onclick="changeBidText(2, '${bidItem.bidItemId}')" /></td>
																<td>Auto Bid</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td><c:if
															test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 1}'>
															<div id="bidAmountText${bidItem.bidItemId}">&nbsp;Bid
																amount</div>
														</c:if> <c:if
															test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2}'>
															<div id="autoBidText${bidItem.bidItemId}">&nbsp;Auto
																Bid Limit</div>
														</c:if></td>
													<td><input type="text" name="textfield"
														id="Amount${bidItem.bidItemId}" /></td>
												</tr>
												<tr>
													<td>&nbsp;&nbsp;Comments</td>
													<td><textarea name="textfield2"
															id="Comments${bidItem.bidItemId}"></textarea></td>
												</tr>
												<tr>
													<td>&nbsp;</td>
													<td colspan="2"><input type="submit" name="button"
														id="button" value="Submit"
														onclick="doBid('${bidItem.bidItemId}', '${bidItem.currentMarketPrice}', '${bidItem.minBidIncrement}'); return false;" /></td>
												</tr>
											</table>
										</form>
									</td>
								</tr>
							</table>
							</div>

							</div>
							</div>
							</div>
							</div>



							<div id="bidButtonDiv${bidItem.bidItemId}">
								<c:choose>
									<c:when
										test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1}'>
										<div id='actualAutoBid${bidItem.bidItemId}'>
											<c:out value="${bidItem.amountAutoBid}" />
										</div>
										<script>setNextBidDisabled('NextBid${bidItem.bidItemId}');</script>
										<input type="submit" name="button7"
											id="bidSubmit${bidItem.bidItemId}" value="Change AutoBid"
											onclick="setAttributes(this.value, '${bidItem.bidItemId}','${bidItem.minBidIncrement}'); return false;"
											data-toggle="modal"
											data-target="#dialog_dialog${bidItem.bidItemId}" />
									</c:when>
									<c:otherwise>
										<input type="submit" name="button3"
											id="bidSubmit${bidItem.bidItemId}" value="Bid"
											onclick="setAttributes(this.value, '${bidItem.bidItemId}','${bidItem.minBidIncrement}'); return false;"
											data-toggle="modal"
											data-target="#dialog_dialog${bidItem.bidItemId}" />
									</c:otherwise>
								</c:choose>
							</div></td>

						<td><a href="${bidItem.imageUrl}" target="_blank"> <img
								alt="" src="${bidItem.imageUrl}" height="80px" width="120px" onclick="window.open('${bidItem.imageUrl}', 'Large', 'width=500, height=350'); return false;"><!-- </a> --></td>

					</tr>

				</c:forEach>
			</table>
		</div>
	</div>

	<script>
	
function isNumber(n) {
	  return !isNaN(parseFloat(n)) && isFinite(n);
	}

function doBid(bidId, curMarketPrice, minBidIncrement)
{
	var location1 = "";
	var NewcurMarketPrice = document.getElementById("Item"+bidId).innerHTML;
	var bidTypeObj = "NormalBid"+bidId
	//alert("bidTypeObj " + bidTypeObj)
	var bidType = 1;
	var bidTypeElem = document.getElementById(bidTypeObj).checked
	if(bidTypeElem)
		{
		bidType = 1;
		}
	else
		{
		bidType = 2;
		}
	var bidAmountObj = "Amount"+bidId
	//alert(bidAmountObj)
	var bidAmount = document.getElementById(bidAmountObj).value
	
	if(!isNumber(bidAmount))
	{
		alert("Amount provided is not a number: " + bidAmount)
		return false;
	}
	var parsedBidAmount = parseFloat(bidAmount)
	var parsedCurMarketPrice = parseFloat(NewcurMarketPrice)
	var parsedMinBidIncrement = parseFloat(minBidIncrement)
	
	if(parsedBidAmount < (parsedCurMarketPrice+parsedMinBidIncrement))
	{
		alert("Amount provided is less than current market price plus minimum bid increment amount")	
		return false;
	}
	
	var calculation = (parsedBidAmount - parsedCurMarketPrice) % parsedMinBidIncrement ;
	//alert("calculation " + calculation)
	if(calculation != 0)
	{
		alert("Not a valid multiple of minimum bid increment")
		return false;
	}
	//alert("Bid Accepted: Please click Refresh for result");
	//alert(bidAmount)
	var commentsObj = "Comments"+bidId;
	//alert(comments)
	var comments = document.getElementById(commentsObj).value
	//onBidClick(bidAmount,bidId);
	var actualBidDialog = document.getElementById('dialog_dialog'+bidId);
	if(actualBidDialog)
	{
		$('#dialog_dialog'+bidId).modal('hide');
	}
	else
	{
		$('#dialog_amt'+bidId).modal('hide');
		
		//$('#dialog_amt'+bidId).dialog("close");
	}
	//CometPusher.onSubmit(bidId, bidType, bidAmount, handleGetData);
	//location1 = "${bidder_home_url}/bid/"+bidId+"/"+bidType+"/"+bidAmount
	//alert("location1 " + location1)
	
	//window.location.href=location1
	var flag;
	if(bidType == 1){
		flag=confirm("Are you sure you want to bid for amount - " + bidAmount + " , then Press OK");
	}
	else {
		flag=confirm("Are you sure you want to put auto bid amount - " + bidAmount + " , then Press OK");
	}
	if(flag == true) {
		$.getJSON("bid", { bidItemId:  bidId,
			bidType: bidType,
  			bidAmount:  bidAmount, comments: comments }, function(data){ 
  				//alert("It worked");
		});	
	 setNextBidDisabled('NextBid'+bidId);
	}
	 
	return false;
	
}

function doNextBid(bidItemId, minIncrementAmount)
{
	var curPriceObject = document.getElementById("Item"+bidItemId).innerHTML;	
	var nextBidPrice = parseFloat(curPriceObject) + parseFloat(minIncrementAmount);
	var flag;
	flag=confirm("Are you sure you want to put next bid for amount - " + nextBidPrice + " , then Press OK");
	//alert("In doNextBid " + bidItemId + " " + nexBidPrice + " " + minIncrementAmount)
	if(flag == true) {
		$.getJSON("bid", { bidItemId:  bidItemId,
			bidType: 1,
				bidAmount:  nextBidPrice, comments: "Next Bid" }, function(data){ 
					//alert("It worked");
	    });
		setNextBidDisabled('NextBid'+bidItemId);
	}	
	
}
function changeBidText(bidType, bidItemId)
{
	if(bidType == 1)
	{
		if(document.getElementById("bidAmountText" + bidItemId))
			document.getElementById("bidAmountText" + bidItemId).style.display = "block";
		if(document.getElementById("autoBidText" + bidItemId))
			document.getElementById("autoBidText" + bidItemId).style.display = "none";
	}
	else
	{
		if(document.getElementById("bidAmountText" + bidItemId))
			document.getElementById("bidAmountText" + bidItemId).style.display = "none";
		if(document.getElementById("autoBidText" + bidItemId))
			document.getElementById("autoBidText" + bidItemId).style.display = "block";
	}
}

function checkRadioButton(bidItemId, bidType)
{
	if(bidType==1)
		document.getElementById("NormalBid" + bidItemId).checked = true;
	else
		document.getElementById("AutoBid" + bidItemId).checked = true;
}
function resetTextColor(bitItemId)
{
		document.getElementById('ranktd').style.background = '#EAEDF4';	
		document.getElementById('currentpricetd').style.background = '#EAEDF4';
		if(document.getElementById("itemRow"+bitItemId) && document.getElementById("itemRow"+bitItemId).checked) 
			changeStyleSelectedHover();
	
}
function update(message){
	//alert(message + " hello")
	var str = message.split(":");
	var bitItemId = str[0];
	
	var rankHtml = str[1];
	document.getElementById('currentpricetd').style.background = '#bbd5e6';
	if(rankHtml != 0)
	{
		var divRank = document.getElementById("rank"+bitItemId);
		document.getElementById('ranktd').style.background = '#bbd5e6';
		divRank.innerHTML = rankHtml; //str[1];
	}
	setTimeout("resetTextColor("+bitItemId+")",3000);
  	updateScreen(bitItemId, str[2]);
  	if(str[2] == "2")
  	{
	  	var divActualAutoBid = document.getElementById("actualAutoBid"+bitItemId);
	  	if(divActualAutoBid)
	  	{
	  		divActualAutoBid.innerHTML = str[3];  		
	  	}
	  	else
	  	{
	  			var bidButtonDiv  = document.getElementById("bidButtonDiv"+bitItemId);
	  			if(bidButtonDiv)
	  			{
	  				var newDiv = document.createElement('div');  			
		  			var divId = "actualAutoBid"+bitItemId;
		  			newDiv.setAttribute("id", divId)
		  			newDiv.innerHTML = str[3];
		  			bidButtonDiv.insertBefore(newDiv, bidButtonDiv.firstChild);	
	  			}
	  			
	  	}
  	}
  	else
  	{
		var actualAutoBidDiv = document.getElementById("actualAutoBid"+bitItemId);
		if(actualAutoBidDiv)
		{
			actualAutoBidDiv.innerHTML = ""
		}
		else
		{
			var bidButtonDiv  = document.getElementById("bidButtonDiv"+bitItemId);
			if(bidButtonDiv)
			{
				//if(bidButtonDiv.firstChild) bidButtonDiv.firstChild.innerHTML = ""
			}
			
		}
  	}
 	
}

function updateScreen(bidItemId, val){
	if(val == "2")
	{
			document.getElementById("bidSubmit"+bidItemId).value = "Change AutoBid";
			document.getElementById("NormalBid" + bidItemId).disabled = true;
			//alert(document.getElementById("NormalBid" + bidItemId).style);
			//document.getElementById("NormalBid" + bidItemId).style.class = "disabledButton";
			
			//document.getElementById("NormalBid" + bidItemId).checked = false;
			document.getElementById("NextBid" + bidItemId).disabled = true;
			//document.getElementById("NextBid" + bidItemId).style.class = "disabledButton";
			document.getElementById("AutoBid" + bidItemId).checked = true;
			document.getElementById("NormalBid" + bidItemId).style.color = "#C0BFBF";
			document.getElementById("NextBid" + bidItemId).style.color = "#C0BFBF";
			changeBidText(2, bidItemId);
	}
	else
	{
			document.getElementById("bidSubmit" + bidItemId).value = "Bid";
			document.getElementById("NormalBid" + bidItemId).disabled = false;
			//document.getElementById("NormalBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
			document.getElementById("NextBid" + bidItemId).disabled = false;
			//document.getElementById("NextBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
			document.getElementById("NormalBid" + bidItemId).checked = true;
			document.getElementById("NormalBid" + bidItemId).style.color = "#1c94c4";
			document.getElementById("NextBid" + bidItemId).style.color = "#1c94c4";
			document.getElementById("NextBid" + bidItemId).enabled = true;
			changeBidText(1, bidItemId);
	}
}

function enableNormalBidButton(bidItemId)
{
	document.getElementById("NormalBid" + bidItemId).checked = true;
	document.getElementById("NormalBid" + bidItemId).enabled = true;
	document.getElementById("NextBid" + bidItemId).enabled = true;
	//document.getElementById("NormalBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
	//document.getElementById("NextBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
	document.getElementById("NormalBid" + bidItemId).style.color = "#1c94c4";
	document.getElementById("NextBid" + bidItemId).style.color = "#1c94c4";
}
function disableNormalBidButton(bidItemId)
{
	document.getElementById("NormalBid" + bidItemId).disabled = true;
	document.getElementById("NextBid" + bidItemId).disabled = true;
	//document.getElementById("NormalBid" + bidItemId).style.class = "disabledButton";
	//document.getElementById("NextBid" + bidItemId).style.class = "disabledButton";
	document.getElementById("NormalBid" + bidItemId).style.color = "#C0BFBF";
	document.getElementById("NextBid" + bidItemId).style.color = "#C0BFBF";
}

function updatePollStatus(pollStatus) {
    //dwr.util.setValue("pollStatus", pollStatus ? "<font color='green'>Online</font>" : "<font color='red'>Offline</font>", {escapeHtml:false});
}

function fn()
{
    dwr.engine.setActiveReverseAjax(true); // Initiate reverse ajax polling
    dwr.engine.setNotifyServerOnPageUnload(true);
    dwr.engine.setErrorHandler(errorHandler); // Optional - Called when a call and all retry attempts fail
    dwr.engine.setPollStatusHandler(updatePollStatus); // Optional - function to call when the reverse ajax status changes (e.g. online to offline)
    updatePollStatus(true); // Optional - We are online right now!  Until DWR determines we are not!    
}
fn();

window.onunload = function() {
	//var param = "<security:authentication property='principal.username'/>"+"bidder_active";
	//removeScriptSession(param);
    dwr.engine.setActiveReverseAjax(false);
}

function errorHandler(message, ex) {
    dwr.util.setValue("error", "<font color='red'>Cannot connect to server. Initializing retry logic.</font>", {escapeHtml:false});
    setTimeout(function() { dwr.util.setValue("error", ""); }, 5000)
}
	  

function setAmount(bidItemId, minIncrementAmount, bidType)
{
	if(bidType == 1)
	{
		var curPriceObject = document.getElementById("Item"+bidItemId).innerHTML;
		
		var nexBidPrice = parseFloat(curPriceObject) + parseFloat(minIncrementAmount);
		
		//alert("nexBidPrice " + nexBidPrice);
		document.getElementById("Amount"+bidItemId).value = nexBidPrice;
	}
	else
	{
		if(document.getElementById("actualAutoBid"+bidItemId))
			{
			var curAutoBid = document.getElementById("actualAutoBid"+bidItemId).innerHTML;
			
			document.getElementById("Amount"+bidItemId).value = curAutoBid;
			}
		
	}
}

function setAttributes(bidButtonType, bitItemId, minBidIncrement)
{
	
	
	if(bidButtonType == "Bid")
	{
		setAmount(bitItemId, minBidIncrement, 1); 
		enableNormalBidButton(bitItemId); 
		changeBidText(1, bitItemId); 	
		checkRadioButton(bitItemId, '1'); 
		var actualAutoBid = document.getElementById("actualAutoBid"+bitItemId)
		if(actualAutoBid)
			actualAutoBid.innerHTML = "";
		
		/* $('#dialog_dialog'+bitItemId).modal({
		    show: 'false'
		});  */
		
		
		$('#dialog_dialog'+bitItemId).on('show.bs.modal');
		/*  $('#dialog_dialog'+bitItemId).modal('toggle');  */
		
	}
	if(bidButtonType == "Change AutoBid")
	{
		setAmount(bitItemId, minBidIncrement, 2); 
		disableNormalBidButton(bitItemId); 
		changeBidText(2, bitItemId);	 
		checkRadioButton(bitItemId, '2');
		$('#dialog_amt'+bitItemId).on('show.bs.modal');
	}
}


function setPreference(checkBoxObj, bidId)
{
	if(checkBoxObj.checked)
	{
		setPreffered(bidId);
	}
	else
	{
		removePreffered(bidId)
	}
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