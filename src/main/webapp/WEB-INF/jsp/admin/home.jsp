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
				<div id="piechart" style="width: 900px; height: 500px;"></div>


			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->



	</div>
	<!-- ./wrapper -->

</body>

	<script src="${js_url}/jsapi.js"></script>
	<script>
		var parentArray = new Array();
		$(document).ready(
				function() {
					var arr = new Array('Total Auction', 'Auction Id',
							'Completed Auction', 'Auction Id',
							'Pending Auction', 'AuctionId');
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
											parseInt(result[i].auctionId),
											null, null);
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