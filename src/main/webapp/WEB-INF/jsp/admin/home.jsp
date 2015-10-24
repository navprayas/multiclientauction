<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/admin/superAdmin" var="admin_url" />



<script src="${js_url}/jsapi.js"></script>
<script>
	var parentArray = new Array();
	$(document).ready(
			function() {
				var arr = new Array('Total Auction', 'Auction Id',
						'Completed Auction', 'Auction Id', 'Pending Auction',
						'AuctionId');
				parentArray.push(arr);

				$.ajax({
					url : "adminauctionlist",
					async : false,
					success : function(data) {
						result = jQuery.parseJSON(data);
						
						for (var i = 0; i < result.length; i++) {
							var arr;
							arr = new Array(result[i].name,
									parseInt(result[i].auctionId),
									result[i].name,
									parseInt(result[i].auctionId),
									result[i].name,
									parseInt(result[i].auctionId));
							parentArray.push(arr);
							if (result[i].status == 'Closed') {
								arr = new Array(null, null, result[i].name,
										parseInt(result[i].auctionId), null,
										null);
							} else {
								arr = new Array(null, null, null, null,
										result[i].name,
										parseInt(result[i].auctionId));
							}

							parentArray.push(arr);
						}
					}
				});

			});

	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	google.setOnLoadCallback(drawChart);
	function drawChart() {
		console.log(parentArray);
		var data = google.visualization.arrayToDataTable(parentArray);

		var options = {
			title : 'Auction List',
			is3D : true
		};

		var chart = new google.visualization.PieChart(document
				.getElementById('piechart'));

		chart.draw(data, options);
	}
</script>
<body>

	<div id="piechart" style="width: 900px; height: 500px;"></div>

</body>
