<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<section class="main">
	<div class="container">
		<div class="form-container form-container-cr user-registraton">
			<h1>
				<i class="fa fa-user"></i> Create Auction By Uploading File
			</h1>
			<form class="form-horizontal" id="fileUpload" name="fileUpload"
				method="POST" action="uploadFile" enctype="multipart/form-data">


				<c:if test="${not empty message}">
					<div class="form-group">
						<div class="col-xs-12 col-sm-8">
							<c:out value="${message}"></c:out>
						</div>

					</div>


				</c:if>


				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">Select
						Auction</label>
					<div class="col-xs-12 col-sm-8">
						<select name="auctionId" id="auctionId">
							<option value="-1">Select</option>
							<c:forEach var="auction1" items="${AuctionList}">
								<option value="${auction1.auctionId}">
									<c:out value="${auction1.name}" />
								</option>
							</c:forEach>
						</select>
					</div>
				</div>


				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">File
						to upload</label>
					<div class="col-xs-12 col-sm-8">
						<input type="file" name="file" id="file"
							onchange="checkfile(this);" class="form-control" name="firstName">
						<!-- <input type="hidden" id="selectedAuctionId"
							name="selectedAuctionId" /> -->
					</div>
				</div>



				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-8">
						<button type="button" class="btn btn-primary" id="button"
							name="button" onclick="checkfile1();">Upload</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="downloadfile">Download
							Excel Format</a>
					</div>

				</div>
			</form>
		</div>
	</div>
	<!-- /container -->
</section>
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
