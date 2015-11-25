<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>

<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<spring:url value="/observer" var="observer_home_url" />
<spring:url value="/observer/approveH1" var="observer_h1_url" />
<spring:url value="/observer/marketlist" var="observer_market_url" />
<spring:url value="/observer/active" var="observer_active_url" />

<spring:url value="/observer/closed" var="Paginationform_url" />


<script type="text/javascript">
	
	function onSubmit(pageNo) {
		document.paginationForm.category.value = document.forms["categoryform"].category.value;
		document.paginationForm.page.value=pageNo;
		document.paginationForm.submit();
	}
	
	function MM_openBrWindow(theURL,winName,features) { //v2.0
		  window.open(theURL,winName,features);
	}
	function getResultForCategory()
	{
		document.forms["categoryform"].submit(); 
	}
	
	/*function submitFormH1(bidItemid, bidAmount, bidderName){
		var location1 = "${observer_h1_url}?bidItemid="+bidItemid+"&bidAmount="+bidAmount+"&bidderName="+bidderName;
		window.location.href = location1			
	}*/
	function submitFormH1H2H3(bidItemid, bidAmount, bidderName, bidStatus){
		
		
		document.observerForm.bidItemId.value = bidItemid;
		document.observerForm.bidAmount.value = bidAmount;
		document.observerForm.bidderName.value = bidderName;
		document.observerForm.categoryId.value = document.getElementById("category").value;
		document.observerForm.pageO.value = document.paginationForm.page.value;
		
		document.observerForm.bidStatus.value = bidStatus;
		document.observerForm.submit();
					
	}


</script>

<script type="text/javascript">
			$(function(){
				// Dialog			
				
				$('.desc').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.partici').dialog({
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
				$('.textension').dialog({
					autoOpen: false,
					width:'auto',
					height:310,
				});
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
				});
				
				$('.h1btn').dialog({
					autoOpen: false,
					width:'auto',
					close: function(ev, ui) 
	                {
	                    $(this).close;
	                },
				});
				$('.h2btn').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.rejectbtn').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.description').click(function(){
				
					//$('.desc').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.partcipents').click(function(){
				
					$('.partici').dialog('open');
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
				$('.time').click(function(){
				
					$('.textension').dialog('open');
					return false;
				});
				$('.changepass').click(function(){
				
					$('.change').dialog('open');
					return false;
				});
				$('.h1').click(function(){
				
					//$('.h1btn').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.h2').click(function(){
				
					//$('.h2btn').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.reject').click(function(){
				
					//$('.rejectbtn').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
			});
		</script>
<script type="text/javascript">
	
	$(function() {
		$(".desc").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".partici").dialog({
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
		$(".textension").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".change").dialog({
			bgiframe: false,
			modal: true,
			
		});
		
		$(".h1btn").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
		$(".h2btn").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
		$(".rejectbtn").dialog({
			bgiframe: false,
			modal: true,
			
		});

	});
	</script>
<script language="javascript">
function blah( oCB )
{    for( oElem = oCB; oElem.tagName!= "TR"; oElem = oElem.parentNode );
    oElem.className = oCB.checked? "selected": "";
}
</script>
</head>


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

						<div class="table-responsive user-map nofound itemlist">
							<table class="table table-bordered table-striped text-center">
								<tr>
									<td colspan="3"><input type="radio" name="radio"
										id="radio" value="1"
										onclick="getPageForMarketType(this.value)" /> <a
										href="${observer_market_url}">&nbsp;Market List</a></td>
									<td colspan="3"><input type="radio" name="radio"
										id="radio2" value="2"
										onClick="getPageForMarketType(this.value)" /><a
										href="${observer_active_url}">&nbsp;Active Market</a></td>
									<td colspan="3"><input type="radio" checked name="radio"
										id="radio3" value="3"
										onclick="getPageForMarketType(this.value)" /> <a
										href="${observer_close_url}">&nbsp;Closed Market</a></td>
									<td colspan="7" align="right"><strong>Total No.
											of Forward Markets in Active List: <c:out
												value="${fn:length(bidItemsList)}" />
									</strong></td>
								</tr>
							</table>
						</div>
					</form>
				</div>

				<form:form action="${Paginationform_url}" name="paginationForm">
					<input type="hidden" name="page"
						value="<c:out value='${navigationInfo.currentPage}' />" />
					<input type="hidden" name="category" value="0" />
				</form:form>
				<div class="table-responsive user-map nofound itemlist">
					<table
						class="table table-bordered table-striped text-center tfhnml">

						<tr>
							<td><display:table name="navigationInfo"
									requestURI="${Paginationform_url}" excludedParams="*"
									cellspacing="0px" cellpadding="0px 0px 0px 0px">
									<display:setProperty name="paging.banner.onepage" value="<br/>"></display:setProperty>
									<display:setProperty name="basic.msg.empty_list" value=""></display:setProperty>
									<display:setProperty name="basic.msg.empty_list_row" value=""></display:setProperty>
									<display:setProperty name="paging.banner.first">
										<table>
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
										<table id="pagetable">
											<tr>
												<td><div>
														<span class="pagelinks"> <a href="#"
															onclick="javascript: onSubmit('1')" id="id5">First</a> |
															<a href="#"
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
										<table id="pagetable">
											<tr>
												<td><div>
														<span class="pagelinks"> <a href="#"
															onclick="javascript: onSubmit('1')" id="id5">First</a> |
															<a href="#"
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
				<div class="table-responsive user-map nofound itemlist">
					<form action="${observer_h1_url}" method="post"
						modelAttribute="observerVO" name="observerForm">
						<input type="hidden" name="bidItemId" value="" /> <input
							type="hidden" name="bidAmount" value="" /> <input type="hidden"
							name="bidderName" value="" /> <input type="hidden"
							name="bidStatus" value="" /> <input type="hidden"
							name="categoryId" value="" /> <input type="hidden" name="pageO"
							value="<c:out value='${navigationInfo.currentPage}' />" />
					</form>

					<table class="table table-bordered table-striped text-center">

						<tr>
							<td><a href="#">Sr. No</a></td>
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
							<td><a href="#">Close Date &amp; Time</a></td>
							<td><a href="#">Current Price(INR)</a></td>
							<td><a href="#">H1</a></td>
							<td><a href="#">Reserved Price(INR)</a></td>
							<td><a href="#">Last Price(INR)</a></td>
							<td><a href="#">Bid <br /> Approval
							</a></td>
							<td><a href="#">Winning<br /> Firm Name
							</a></td>

							<td><a href="#">View Image </a></td>




						</tr>
						<c:forEach items="${bidsList}" var="bid" varStatus="status">
							<tr class="table">
								<td height="40" align="center" valign="middle"
									class="DetailBorRight"><div
										id="seqId${bid.bidItem.bidItemId}">${bid.bidItem.serialNo}.</div></td>
								<td align="center" valign="middle">



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
														class="table-responsive user-map" title="Item Description">
														<table
															class="table table-bordered table-striped text-center">
															<tr>
																<td align="left" valign="top"><form name="form1"
																		method="post" action="" style="margin: 0px;">
																		<table
																			class="table table-bordered table-striped text-center">

																			<tr>
																				<td>Sr. No.</td>
																				<td>Category</td>
																				<td>Lot No.</td>
																				<td>Material Name</td>
																				<td>Remark</td>
																				<td>Length Range</td>
																				<td>Actual Length (Approx)</td>
																				<td>Qty</td>
																				<td>Zone</td>
																			</tr>
																			<tr>
																				<td>${bid.bidItem.serialNo}.</td>
																				<td><div
																						id="categoryName${bid.bidItem.bidItemId}">
																						${bid.bidItem.category.categoryName}</div></td>
																				<c:forEach items="${bid.bidItem.itemLots}"
																					var="itemLotUnique" varStatus="status2">
																					<c:if test="${status2.index+1 == 1}">
																						<td>${itemLotUnique.lotNo}</td>
																					</c:if>
																				</c:forEach>
																				<td>${bid.bidItem.name}</td>
																				<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
																					<c:forEach items="${bid.bidItem.itemLots}"
																						var="itemLotUnique" varStatus="status2">
																						<td>${itemLotUnique.remark}</td>
																						<td>${itemLotUnique.lengthRange}</td>
																						<td>${itemLotUnique.actualLengh}</td>
																					</c:forEach>
																				</c:if>
																				<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
																					<td>&nbsp;</td>
																					<td>&nbsp;</td>
																					<td>&nbsp;</td>
																				</c:if>
																				<td>${bid.bidItem.totalQuantity}
																					${bid.bidItem.unit}</td>
																				<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
																					<c:forEach items="${bid.bidItem.itemLots}"
																						var="itemLotUnique" varStatus="status2">
																						<td>${itemLotUnique.zone}</td>
																					</c:forEach>
																				</c:if>
																				<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
																					<td>&nbsp;</td>
																				</c:if>
																			</tr>
																			<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
																				<c:forEach items="${bid.bidItem.itemLots}"
																					var="itemLot" varStatus="status1">
																					<tr>
																						<td>${status1.index+1}.</td>
																						<td>${bid.bidItem.category.categoryName}</td>
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
													</div>

												</div>
											</div>
										</div>

									</div> <input type="submit" name="button7" id="desc${status.index+1}"
									value="Desc" data-toggle="modal"
									data-target="#dialog_desc${status.index+1}" />
								</td>
								<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique"
									varStatus="status2">
									<c:if test="${status2.index+1 == 1}">
										<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
									</c:if>
								</c:forEach>
								<td align="center" valign="middle" class="DetailBorRight"><div
										id="categoryName${bid.bidItem.bidItemId}">${bid.bidItem.category.categoryName}</div></td>
								<td align="center" valign="middle" class="DetailBorRight">
									<div id="bidItemName${bid.bidItem.bidItemId}"
										style="display: none">${bid.bidItem.name}</div> <a href="#"
									class="LinkSelected"
									onclick="javascript:setIdForBiddingHistory(${bid.bidItem.bidItemId});">${bid.bidItem.name}</a>
								</td>
								<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
									<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique"
										varStatus="status2">
										<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.remark}</td>
										<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lengthRange}</td>
										<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.actualLengh}</td>
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
									<td align="center" valign="middle"
										style="border-right: 1px solid #fff;">&nbsp;</td>
									<td align="center" valign="middle"
										style="border-right: 1px solid #fff;">&nbsp;</td>
									<td align="center" valign="middle"
										style="border-right: 1px solid #fff;">&nbsp;</td>
								</c:if>
								<td align="center" valign="middle" class="DetailBorRight"><div
										id="totalQuantity${bid.bidItem.bidItemId}">
										${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</div></td>
								<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
									<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique"
										varStatus="status2">
										<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.zone}</td>
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
									<td align="center" valign="middle"
										style="border-right: 1px solid #fff;">&nbsp;</td>
								</c:if>
								<td align="center" valign="middle" class="DetailBorRight">
									${bid.bidItem.bidEndTime}</td>
								<td align="center" valign="middle" class="DetailBorRight">${bid.bidItem.currentMarketPrice}</td>
								<td align="center" valign="middle" class="DetailBorRight">${bid.bidderName}</td>
								<td align="center" valign="middle" class="DetailBorRight">
									<div id="Item${bid.bidItem.bidItemId}" style="display: none">${bid.bidItem.minBidPrice}</div>
								</td>
								<td align="center" valign="middle" class="DetailBorRight">
									<div id="minBidIncrement${bid.bidItem.bidItemId}"
										style="display: none">${bid.bidItem.minBidIncrement}</div>
								</td>
								<td align="center" valign="middle" class="DetailBorRight">


									<div class="modal fade" id="dialog_h1btn${status.index+1}"
										tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title" id="myModalLabel">H1</h4>
												</div>
												<div class="modal-body">






													<div id="dialog_h1btn${status.index+1}" class="h1btn"
														title="Bid Approval : H1">

														<table
															class="table table-bordered table-striped text-center">
															<tr>
																<td align="left" valign="top"><form name="form1"
																		method="post" action="" style="margin: 0px;">
																		<table width="400" border="0" cellspacing="0"
																			cellpadding="0">

																			<tr>
																				<td colspan="8" align="center" valign="middle"
																					style="border-right: 1px solid #fff;"><table
																						width="100%" border="0" cellspacing="0"
																						cellpadding="0">
																						<tr>

																							<td width="66%" height="25" align="center"
																								bgcolor="#dee7d6" class="td">${status.index+1}.
																								&nbsp;&nbsp;${bid.bidItem.name}
																								&nbsp;&nbsp;&nbsp;&nbsp;${bid.bidItem.totalQuantity}
																								${bid.bidItem.unit}</td>
																						</tr>
																						<c:if test="${not empty bid.bidId}">
																							<tr>
																								<td height="25" colspan="2" align="center"
																									bgcolor="#EFEFE7" class="td">Are you sure,
																									you want to grant bid to H1</td>
																							</tr>
																							<tr>
																								<td height="30" colspan="2" align="center"
																									bgcolor="#DEE7D6" class="td"><input
																									type="button" name="button"
																									onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount}','${bid.bidderName}','H1');"
																									value="Yes" /> <input type="button"
																									name="button2" value="No"
																									onclick="$('#dialog_h1btn${status.index+1}').dialog('close');return false;" /></td>
																							</tr>
																						</c:if>
																						<c:if test="${empty bid.bidId}">
																							<tr>
																								<td height="25" colspan="2" align="center"
																									bgcolor="#EFEFE7" class="td">No bidding on
																									this bid.</td>
																							</tr>
																						</c:if>
																					</table></td>
																			</tr>
																		</table>
																	</form></td>
															</tr>
														</table>
													</div>

												</div>
											</div>
										</div>
									</div> <c:if test="${empty bid.bidItem.isProcessed}">
										<input type="submit" name="button7"
											id="h1btn${status.index+1}" value="H1" data-toggle="modal"
											data-target="#dialog_h1btn${status.index+1}" />
									</c:if>

									<div class="modal fade" id="dialog_h2btn${status.index+1}"
										tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title" id="dialog_h2btn${status.index+1}">H2/H3</h4>
												</div>
												<div class="modal-body">




													<div id="dialog_h2btn${status.index+1}" class="h2btn"
														title="Bid Approval : H2/H3">

														<table
															class="table table-bordered table-striped text-center">
															<tr>
																<td><form name="form1" method="post" action="">
																		<table
																			class="table table-bordered table-striped text-center">

																			<tr>
																				<td colspan="8" align="left" valign="middle"><table
																						class="table table-bordered table-striped text-center">
																						<tr>
																							<td>${status.index+1}.</td>
																							<td>&nbsp;&nbsp;${bid.bidItem.name}&nbsp;&nbsp;&nbsp;
																								${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</td>
																						</tr>
																						<c:if
																							test="${not empty bid.bidAmount2 || not empty bid.bidAmount3}">
																							<tr>
																								<td><p>&nbsp;</p></td>
																								<td>Bidder Rank</td>
																								<td>Bidding Company</td>
																								<td>Bidder Name</td>
																								<td>Bid Amount</td>
																							</tr>
																						</c:if>
																						<c:if test="${not empty bid.bidAmount2}">
																							<tr>
																								<td><input type="radio" name="radioH2"
																									id="radioH2" value="H2"
																									onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount2}','${bid.bidderName2}','H2');" /></td>
																								<td>H2</td>
																								<td>${bid.bidderName2}</td>
																								<td>${bid.bidderName2}</td>
																								<td>INR ${bid.bidAmount2}</td>
																							</tr>
																						</c:if>
																						<c:if test="${not empty bid.bidAmount3}">
																							<tr>
																								<td><input type="radio" name="radioH2"
																									id="radioH2" value="H3"
																									onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount3}','${bid.bidderName3}','H3');" /></td>
																								<td>H3</td>
																								<td>${bid.bidderName3}</td>
																								<td>${bid.bidderName3}</td>
																								<td>INR ${bid.bidAmount3}</td>
																							</tr>
																						</c:if>
																						<c:if
																							test="${empty bid.bidAmount3 && empty bid.bidAmount2}">
																							<tr>
																								<td colspan="5">&nbsp;&nbsp; No H2, H3
																									Value present for this bid.</td>
																							</tr>
																						</c:if>
																					</table></td>
																			</tr>
																			<tr>
																				<td colspan="8">&nbsp;</td>
																			</tr>
																		</table>
																	</form></td>
															</tr>
														</table>
													</div>

												</div>
											</div>
										</div>
									</div> <c:if test="${empty bid.bidItem.isProcessed}">
										<input type="submit" name="button7"
											id="h2btn${status.index+1}" value="H2/H3" data-toggle="modal"
											data-target="#dialog_h2btn${status.index+1}" />
									</c:if>


									<div class="modal fade" id="dialog_rejectbtn${status.index+1}"
										tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title" id="myModalLabel">Reject</h4>
												</div>
												<div class="modal-body">



													<div id="dialog_rejectbtn${status.index+1}"
														class="rejectbtn" title="Bid Approval :&nbsp; Reject">

														<table
															class="table table-bordered table-striped text-center">
															<tr>
																<td align="left" valign="top"><form name="form1"
																		method="post" action="" style="margin: 0px;">
																		<table
																			class="table table-bordered table-striped text-center">

																			<tr>
																				<td colspan="8"><table
																						class="table table-bordered table-striped text-center">
																						<tr>

																							<td>${status.index+1}.
																								&nbsp;&nbsp;${bid.bidItem.name}
																								&nbsp;&nbsp;&nbsp;&nbsp;${bid.bidItem.totalQuantity}
																								${bid.bidItem.unit}</td>
																						</tr>
																						<tr>
																							<td>Are you sure, you want to Reject the bid</td>
																						</tr>
																						<tr>
																							<td colspan="2"><input type="button"
																								name="button"
																								onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount}','${bid.bidderName}','Rejected');"
																								value="Yes" /> <input type="button"
																								name="button" data-dismiss="modal" value="No" />
																								<!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">No</button> --></td>
																						</tr>
																					</table></td>
																			</tr>
																		</table>
																	</form></td>
															</tr>
														</table>
													</div>

												</div>
											</div>
										</div>
									</div> <c:if test="${empty bid.bidItem.isProcessed}">
										<input type="submit" name="button7"
											id="rejectbtn${status.index+1}" value="Reject"
											data-toggle="modal"
											data-target="#dialog_rejectbtn${status.index+1}" />
									</c:if> <c:if test="${not empty bid.bidItem.isProcessed}">
										<c:out value="${bid.bidItem.isProcessed}" />
									</c:if>
								</td>
								<td align="center" class="DetailBorLast"><c:if
										test="${not empty bid.bidItem.isProcessed}">
										<c:if test="${bid.bidItem.isProcessed == 'H1'}">
											<c:out value="${bid.bidderName}"></c:out>
										</c:if>
										<c:if test="${bid.bidItem.isProcessed == 'H2'}">
											<c:out value="${bid.bidderName2}"></c:out>
										</c:if>
										<c:if test="${bid.bidItem.isProcessed == 'H3'}">
											<c:out value="${bid.bidderName3}"></c:out>
										</c:if>

									</c:if></td>

								<td><a href="${bid.bidItem.imageUrl}" target="_blank"> <img
										alt="" src="${bid.bidItem.imageUrl}" height="75px" width="120px"
										onclick="window.open('${bid.bidItem.imageUrl}', 'Large', 'width=500, height=350'); return false;"></a></td>



							</tr>
						</c:forEach>
					</table>

					<%
						if (request.getAttribute("H1Approved") != null && !(Boolean) request.getAttribute("H1Approved")) {
							out.println(
									"<script>function printErrorH1Approved() { alert('Approval Could not happened. Please check with support team.') } printErrorH1Approved();</script>");
						}
					%>

				</div>



			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->



	</div>
	<!-- ./wrapper -->

</body>




<%-- <body>
	<div id="dhtmltooltip"></div>
	<%@ include file="/WEB-INF/jsp/observer/observer_top.jsp"%>

	<div class="container">

		<div class="mark-check1 mktlstcl">
			<form id="form1" name="form1" method="post" action=""
				style="margin: 0px;">

				<div class="table-responsive user-map nofound itemlist">
					<table class="table table-bordered table-striped text-center">
						<tr>
							<td colspan="3"><input type="radio" name="radio" id="radio"
								value="1" onclick="getPageForMarketType(this.value)" /> <a
								href="${observer_market_url}">&nbsp;Market List</a></td>
							<td colspan="3"><input type="radio" name="radio" id="radio2"
								value="2" onClick="getPageForMarketType(this.value)" /><a
								href="${observer_active_url}">&nbsp;Active Market</a></td>
							<td colspan="3"><input type="radio" checked name="radio"
								id="radio3" value="3" onclick="getPageForMarketType(this.value)" />
								<a href="${observer_close_url}">&nbsp;Closed Market</a></td>
							<td colspan="7" align="right"><strong>Total No. of
									Forward Markets in Active List: <c:out
										value="${fn:length(bidItemsList)}" />
							</strong></td>
						</tr>
					</table>
				</div>
			</form>
		</div>

		<form:form action="${Paginationform_url}" name="paginationForm">
			<input type="hidden" name="page"
				value="<c:out value='${navigationInfo.currentPage}' />" />
			<input type="hidden" name="category" value="0" />
		</form:form>
		<div class="table-responsive user-map nofound itemlist">
			<table class="table table-bordered table-striped text-center tfhnml">

				<tr>
					<td><display:table name="navigationInfo"
							requestURI="${Paginationform_url}" excludedParams="*"
							cellspacing="0px" cellpadding="0px 0px 0px 0px">
							<display:setProperty name="paging.banner.onepage" value="<br/>"></display:setProperty>
							<display:setProperty name="basic.msg.empty_list" value=""></display:setProperty>
							<display:setProperty name="basic.msg.empty_list_row" value=""></display:setProperty>
							<display:setProperty name="paging.banner.first">
								<table>
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
								<table id="pagetable">
									<tr>
										<td><div>
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
								<table id="pagetable">
									<tr>
										<td><div>
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
		<div class="table-responsive user-map nofound itemlist">
			<form action="${observer_h1_url}" method="post"
				modelAttribute="observerVO" name="observerForm">
				<input type="hidden" name="bidItemId" value="" /> <input
					type="hidden" name="bidAmount" value="" /> <input type="hidden"
					name="bidderName" value="" /> <input type="hidden"
					name="bidStatus" value="" /> <input type="hidden"
					name="categoryId" value="" /> <input type="hidden" name="pageO"
					value="<c:out value='${navigationInfo.currentPage}' />" />
			</form>

			<table class="table table-bordered table-striped text-center">

				<tr>
					<td><a href="#">Sr. No</a></td>
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
					<td><a href="#">Close Date &amp; Time</a></td>
					<td><a href="#">Current Price(INR)</a></td>
					<td><a href="#">H1</a></td>
					<td><a href="#">Reserved Price(INR)</a></td>
					<td><a href="#">Last Price(INR)</a></td>
					<td><a href="#">Bid <br /> Approval
					</a></td>
					<td><a href="#">Winning<br /> Firm Name
					</a></td>
				</tr>
				<c:forEach items="${bidsList}" var="bid" varStatus="status">
					<tr class="table">
						<td height="40" align="center" valign="middle"
							class="DetailBorRight"><div
								id="seqId${bid.bidItem.bidItemId}">${bid.bidItem.serialNo}.</div></td>
						<td align="center" valign="middle">



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
												class="table-responsive user-map" title="Item Description">
												<table
													class="table table-bordered table-striped text-center">
													<tr>
														<td align="left" valign="top"><form name="form1"
																method="post" action="" style="margin: 0px;">
																<table
																	class="table table-bordered table-striped text-center">

																	<tr>
																		<td>Sr. No.</td>
																		<td>Category</td>
																		<td>Lot No.</td>
																		<td>Material Name</td>
																		<td>Remark</td>
																		<td>Length Range</td>
																		<td>Actual Length (Approx)</td>
																		<td>Qty</td>
																		<td>Zone</td>
																	</tr>
																	<tr>
																		<td>${bid.bidItem.serialNo}.</td>
																		<td><div
																				id="categoryName${bid.bidItem.bidItemId}">
																				${bid.bidItem.category.categoryName}</div></td>
																		<c:forEach items="${bid.bidItem.itemLots}"
																			var="itemLotUnique" varStatus="status2">
																			<c:if test="${status2.index+1 == 1}">
																				<td>${itemLotUnique.lotNo}</td>
																			</c:if>
																		</c:forEach>
																		<td>${bid.bidItem.name}</td>
																		<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
																			<c:forEach items="${bid.bidItem.itemLots}"
																				var="itemLotUnique" varStatus="status2">
																				<td>${itemLotUnique.remark}</td>
																				<td>${itemLotUnique.lengthRange}</td>
																				<td>${itemLotUnique.actualLengh}</td>
																			</c:forEach>
																		</c:if>
																		<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
																			<td>&nbsp;</td>
																			<td>&nbsp;</td>
																			<td>&nbsp;</td>
																		</c:if>
																		<td>${bid.bidItem.totalQuantity}
																			${bid.bidItem.unit}</td>
																		<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
																			<c:forEach items="${bid.bidItem.itemLots}"
																				var="itemLotUnique" varStatus="status2">
																				<td>${itemLotUnique.zone}</td>
																			</c:forEach>
																		</c:if>
																		<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
																			<td>&nbsp;</td>
																		</c:if>
																	</tr>
																	<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
																		<c:forEach items="${bid.bidItem.itemLots}"
																			var="itemLot" varStatus="status1">
																			<tr>
																				<td>${status1.index+1}.</td>
																				<td>${bid.bidItem.category.categoryName}</td>
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
											</div>

										</div>
									</div>
								</div>

							</div> <input type="submit" name="button7" id="desc${status.index+1}"
							value="Desc" data-toggle="modal"
							data-target="#dialog_desc${status.index+1}" />
						</td>
						<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique"
							varStatus="status2">
							<c:if test="${status2.index+1 == 1}">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
							</c:if>
						</c:forEach>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="categoryName${bid.bidItem.bidItemId}">${bid.bidItem.category.categoryName}</div></td>
						<td align="center" valign="middle" class="DetailBorRight">
							<div id="bidItemName${bid.bidItem.bidItemId}"
								style="display: none">${bid.bidItem.name}</div> <a href="#"
							class="LinkSelected"
							onclick="javascript:setIdForBiddingHistory(${bid.bidItem.bidItemId});">${bid.bidItem.name}</a>
						</td>
						<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
							<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.remark}</td>
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lengthRange}</td>
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.actualLengh}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="totalQuantity${bid.bidItem.bidItemId}">
								${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</div></td>
						<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
							<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.zone}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" class="DetailBorRight">
							${bid.bidItem.bidEndTime}</td>
						<td align="center" valign="middle" class="DetailBorRight">${bid.bidItem.currentMarketPrice}</td>
						<td align="center" valign="middle" class="DetailBorRight">${bid.bidderName}</td>
						<td align="center" valign="middle" class="DetailBorRight">
							<div id="Item${bid.bidItem.bidItemId}" style="display: none">${bid.bidItem.minBidPrice}</div>
						</td>
						<td align="center" valign="middle" class="DetailBorRight">
							<div id="minBidIncrement${bid.bidItem.bidItemId}"
								style="display: none">${bid.bidItem.minBidIncrement}</div>
						</td>
						<td align="center" valign="middle" class="DetailBorRight">


							<div class="modal fade" id="dialog_h1btn${status.index+1}"
								tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="myModalLabel">H1</h4>
										</div>
										<div class="modal-body">






											<div id="dialog_h1btn${status.index+1}" class="h1btn"
												title="Bid Approval : H1">

												<table
													class="table table-bordered table-striped text-center">
													<tr>
														<td align="left" valign="top"><form name="form1"
																method="post" action="" style="margin: 0px;">
																<table width="400" border="0" cellspacing="0"
																	cellpadding="0">

																	<tr>
																		<td colspan="8" align="center" valign="middle"
																			style="border-right: 1px solid #fff;"><table
																				width="100%" border="0" cellspacing="0"
																				cellpadding="0">
																				<tr>

																					<td width="66%" height="25" align="center"
																						bgcolor="#dee7d6" class="td">${status.index+1}.
																						&nbsp;&nbsp;${bid.bidItem.name}
																						&nbsp;&nbsp;&nbsp;&nbsp;${bid.bidItem.totalQuantity}
																						${bid.bidItem.unit}</td>
																				</tr>
																				<c:if test="${not empty bid.bidId}">
																					<tr>
																						<td height="25" colspan="2" align="center"
																							bgcolor="#EFEFE7" class="td">Are you sure,
																							you want to grant bid to H1</td>
																					</tr>
																					<tr>
																						<td height="30" colspan="2" align="center"
																							bgcolor="#DEE7D6" class="td"><input
																							type="button" name="button"
																							onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount}','${bid.bidderName}','H1');"
																							value="Yes" /> <input type="button"
																							name="button2" value="No"
																							onclick="$('#dialog_h1btn${status.index+1}').dialog('close');return false;" /></td>
																					</tr>
																				</c:if>
																				<c:if test="${empty bid.bidId}">
																					<tr>
																						<td height="25" colspan="2" align="center"
																							bgcolor="#EFEFE7" class="td">No bidding on
																							this bid.</td>
																					</tr>
																				</c:if>
																			</table></td>
																	</tr>
																</table>
															</form></td>
													</tr>
												</table>
											</div>

										</div>
									</div>
								</div>
							</div> <c:if test="${empty bid.bidItem.isProcessed}">
								<input type="submit" name="button7" id="h1btn${status.index+1}"
									value="H1" data-toggle="modal"
									data-target="#dialog_h1btn${status.index+1}" />
							</c:if>

							<div class="modal fade" id="dialog_h2btn${status.index+1}"
								tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="dialog_h2btn${status.index+1}">H2/H3</h4>
										</div>
										<div class="modal-body">




											<div id="dialog_h2btn${status.index+1}" class="h2btn"
												title="Bid Approval : H2/H3">

												<table
													class="table table-bordered table-striped text-center">
													<tr>
														<td><form name="form1" method="post" action="">
																<table
																	class="table table-bordered table-striped text-center">

																	<tr>
																		<td colspan="8" align="left" valign="middle"><table
																				class="table table-bordered table-striped text-center">
																				<tr>
																					<td>${status.index+1}.</td>
																					<td>&nbsp;&nbsp;${bid.bidItem.name}&nbsp;&nbsp;&nbsp;
																						${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</td>
																				</tr>
																				<c:if
																					test="${not empty bid.bidAmount2 || not empty bid.bidAmount3}">
																					<tr>
																						<td><p>&nbsp;</p></td>
																						<td>Bidder Rank</td>
																						<td>Bidding Company</td>
																						<td>Bidder Name</td>
																						<td>Bid Amount</td>
																					</tr>
																				</c:if>
																				<c:if test="${not empty bid.bidAmount2}">
																					<tr>
																						<td><input type="radio" name="radioH2"
																							id="radioH2" value="H2"
																							onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount2}','${bid.bidderName2}','H2');" /></td>
																						<td>H2</td>
																						<td>${bid.bidderName2}</td>
																						<td>${bid.bidderName2}</td>
																						<td>INR ${bid.bidAmount2}</td>
																					</tr>
																				</c:if>
																				<c:if test="${not empty bid.bidAmount3}">
																					<tr>
																						<td><input type="radio" name="radioH2"
																							id="radioH2" value="H3"
																							onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount3}','${bid.bidderName3}','H3');" /></td>
																						<td>H3</td>
																						<td>${bid.bidderName3}</td>
																						<td>${bid.bidderName3}</td>
																						<td>INR ${bid.bidAmount3}</td>
																					</tr>
																				</c:if>
																				<c:if
																					test="${empty bid.bidAmount3 && empty bid.bidAmount2}">
																					<tr>
																						<td colspan="5">&nbsp;&nbsp; No H2, H3 Value
																							present for this bid.</td>
																					</tr>
																				</c:if>
																			</table></td>
																	</tr>
																	<tr>
																		<td colspan="8">&nbsp;</td>
																	</tr>
																</table>
															</form></td>
													</tr>
												</table>
											</div>

										</div>
									</div>
								</div>
							</div> <c:if test="${empty bid.bidItem.isProcessed}">
								<input type="submit" name="button7" id="h2btn${status.index+1}"
									value="H2/H3" data-toggle="modal"
									data-target="#dialog_h2btn${status.index+1}" />
							</c:if>


							<div class="modal fade" id="dialog_rejectbtn${status.index+1}"
								tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="myModalLabel">Reject</h4>
										</div>
										<div class="modal-body">



											<div id="dialog_rejectbtn${status.index+1}" class="rejectbtn"
												title="Bid Approval :&nbsp; Reject">

												<table
													class="table table-bordered table-striped text-center">
													<tr>
														<td align="left" valign="top"><form name="form1"
																method="post" action="" style="margin: 0px;">
																<table
																	class="table table-bordered table-striped text-center">

																	<tr>
																		<td colspan="8"><table
																				class="table table-bordered table-striped text-center">
																				<tr>

																					<td>${status.index+1}.
																						&nbsp;&nbsp;${bid.bidItem.name}
																						&nbsp;&nbsp;&nbsp;&nbsp;${bid.bidItem.totalQuantity}
																						${bid.bidItem.unit}</td>
																				</tr>
																				<tr>
																					<td>Are you sure, you want to Reject the bid</td>
																				</tr>
																				<tr>
																					<td colspan="2"><input type="button"
																						name="button"
																						onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount}','${bid.bidderName}','Rejected');"
																						value="Yes" /> <input type="button" name="button"
																						data-dismiss="modal" value="No" /> <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">No</button> --></td>
																				</tr>
																			</table></td>
																	</tr>
																</table>
															</form></td>
													</tr>
												</table>
											</div>

										</div>
									</div>
								</div>
							</div> <c:if test="${empty bid.bidItem.isProcessed}">
								<input type="submit" name="button7"
									id="rejectbtn${status.index+1}" value="Reject"
									data-toggle="modal"
									data-target="#dialog_rejectbtn${status.index+1}" />
							</c:if> <c:if test="${not empty bid.bidItem.isProcessed}">
								<c:out value="${bid.bidItem.isProcessed}" />
							</c:if>
						</td>
						<td align="center" class="DetailBorLast"><c:if
								test="${not empty bid.bidItem.isProcessed}">
								<c:if test="${bid.bidItem.isProcessed == 'H1'}">
									<c:out value="${bid.bidderName}"></c:out>
								</c:if>
								<c:if test="${bid.bidItem.isProcessed == 'H2'}">
									<c:out value="${bid.bidderName2}"></c:out>
								</c:if>
								<c:if test="${bid.bidItem.isProcessed == 'H3'}">
									<c:out value="${bid.bidderName3}"></c:out>
								</c:if>

							</c:if></td>
					</tr>
				</c:forEach>
			</table>

			<%
				if (request.getAttribute("H1Approved") != null && !(Boolean) request.getAttribute("H1Approved")) {
					out.println(
							"<script>function printErrorH1Approved() { alert('Approval Could not happened. Please check with support team.') } printErrorH1Approved();</script>");
				}
			%>

		</div>
	</div>
</body>
 --%>