<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<body class="hold-transition skin-blue sidebar-mini">




	<div class="wrapper">


		<!-- Left side column. contains the logo and sidebar -->


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Create Auction <small>Home</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>Admin -
							Dashboard</a></li>
					<li class="active">Dashboard</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<!-- left column -->
					<div class="col-md-6">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">File Upload Auction</h3>
							</div>



							<form role="form"  id="fileUpload"
								name="fileUpload" method="POST" action="uploadFile"
								enctype="multipart/form-data">
								<div class="box-body">

									<div class="form-group">
										<label for="exampleInputEmail1">Auction Name</label> <select
											name="auctionId" id="auctionId" class="form-control">
											<option value="-1">Select</option>
											<c:forEach var="auction1" items="${AuctionList}">
												<option value="${auction1.auctionId}">
													<c:out value="${auction1.name}" />
												</option>
											</c:forEach>
										</select>
									</div>

									<div class="form-group">
										<label for="exampleInputEmail1">Auction Name</label> <input
											type="file" name="file" id="file" onchange="checkfile(this);"
											class="form-control" name="firstName">
									</div>




								</div>
								<!-- /.box-body -->

								<div class="box-footer">
									<button type="button" class="btn btn-primary" id="button"
										name="button" onclick="checkfile1();">Upload</button>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="downloadfile">Download
										Excel Format</a>
								</div>
							</form>

						</div>
					</div>
					</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->



	</div>
	<!-- ./wrapper -->

</body>

<script>
	function checkfile1() {
		var validExts = new Array(".xls");
		var fileExt = document.getElementById("file").value;
		fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
		if (validExts.indexOf(fileExt) < 0) {
			alert("Invalid file selected, valid files are of "
					+ validExts.toString() + " types.");
			return false;
		} else
			document.fileUpload.submit();
	}
	function checkfile(sender) {
		var validExts = new Array(".xls");
		var fileExt = sender.value;
		fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
		if (validExts.indexOf(fileExt) < 0) {
			alert("Invalid file selected, valid files are of "
					+ validExts.toString() + " types.");
			return false;
		} else
			return true;
	}
</script>


