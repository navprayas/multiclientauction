<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/adminthemecontent" var="theme_url" />

<footer class="main-footer">
	<div class="pull-left hidden-xs">
		<b>Copyright &copy; 2015 Navprayas</b>
	</div>
	<div class="pull-right hidden-xs">
		<b> Developed By: <a href="http://cfeindia.com/">CFE India</a></b>
	</div>
	<strong> &nbsp;</strong>
</footer>

<security:authorize ifAnyGranted="ROLE_OBSERVER">


	<script type="text/javascript">
		function getOnlineUsers() {
			var location1 = "${showOnlineUser_url}";
			PopupCenter(location1, 'OnlineUsersList', 700, 400);
		}

		function getBiddingHistory() {
			var bidItemId = "";
			var bidItem = "";
			var quantity = "";
			var seqId = "";
			if (document.getElementById("bidItemIdVal")) {
				bidItemId = document.getElementById("bidItemIdVal").value;
			}
			if (bidItemId == "" || bidItemId.length < 1) {
				alert("Please first select the Material name for getting history for that");
				return false;
			}
			if (document.getElementById("seqId" + bidItemId)) {
				seqId = document.getElementById("seqId" + bidItemId).innerHTML;
			}
			if (document.getElementById("bidItemName" + bidItemId)) {
				bidItem = document.getElementById("bidItemName" + bidItemId).innerHTML;
			}
			if (document.getElementById("categoryName" + bidItemId)) {
				bidItem = bidItem
						+ " "
						+ document.getElementById("categoryName" + bidItemId).innerHTML;
			}
			if (document.getElementById("totalQuantity" + bidItemId)) {
				quantity = document.getElementById("totalQuantity" + bidItemId).innerHTML;
			}
			var location1 = "${bidder_history_url}?bidItemId=" + bidItemId
					+ "&bidItem=" + bidItem + "&quantity=" + quantity
					+ "&seqId=" + seqId;
			PopupCenter(location1, 'BiddingHistory', 700, 400);
		}

		function PopupCenter(pageURL, title1, w, h) {
			var left = (screen.width / 2) - (w / 2);
			var top = (screen.height / 2) - (h / 2);
			var options = 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, width='
					+ w + ', height=' + h + ', top=' + top + ', left=' + left;
			window.open(pageURL, title1, options);
		}

		function setBiddingDetailVal() {
			var bidItemId = "";
			var bidItem = "";
			if (document.getElementById("bidItemIdVal")) {
				bidItemId = document.getElementById("bidItemIdVal").value;
			}

			if (document.getElementById("bidItemName" + bidItemId)) {
				bidItem = document.getElementById("bidItemName" + bidItemId).innerHTML;
			}
			if (document.getElementById("seqId" + bidItemId)) {
				document.getElementById('seq').innerHTML = document
						.getElementById("seqId" + bidItemId).innerHTML;
			}
			if (document.getElementById("bidStartTime" + bidItemId)) {
				document.getElementById('starttime').innerHTML = document
						.getElementById("bidStartTime" + bidItemId).innerHTML;
			}
			if (document.getElementById("endtimeMain" + bidItemId)) {
				document.getElementById('endtime').innerHTML = document
						.getElementById("endtimeMain" + bidItemId).innerHTML;
			}
			if (document.getElementById("categoryName" + bidItemId)) {
				bidItem = bidItem
						+ " "
						+ document.getElementById("categoryName" + bidItemId).innerHTML;
			}
			if (document.getElementById("totalQuantity" + bidItemId)) {
				document.getElementById('quantity').innerHTML = document
						.getElementById("totalQuantity" + bidItemId).innerHTML;
			}
			document.getElementById('BidItemObj').innerHTML = bidItem;
			if (document.getElementById("currentMarketPrice" + bidItemId)) {
				document.getElementById('initOfferPrice').innerHTML = document
						.getElementById("currentMarketPrice" + bidItemId).innerHTML;
			}
			if (document.getElementById("Item" + bidItemId)) {
				document.getElementById('initOfferPrice').innerHTML = document
						.getElementById("Item" + bidItemId).innerHTML;
			}
			if (document.getElementById("minBidIncrement" + bidItemId)) {
				document.getElementById('minIncrPrice').innerHTML = document
						.getElementById("minBidIncrement" + bidItemId).innerHTML;
			}
		}

		function setIdForBiddingHistory(bidItem) {
			document.getElementById("bidItemIdVal").value = bidItem;
		}
	</script>

</security:authorize>