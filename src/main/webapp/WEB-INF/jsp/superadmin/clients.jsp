<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<body>
	<!-- { middle } -->
	<section class="main">
		<div class="container">
			<div class="table-container">
				<div class="top-line">
					<div class="col-xs-12 col-sm-6 nopad">
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a
								aria-controls="home" role="tab" data-toggle="tab"
								href="#summary">Admin List</a></li>
							<!-- <li><a aria-controls="home" role="tab" data-toggle="tab"
								href="#bidder">Bidder Wise</a></li> -->
						</ul>
					</div>
					<div class="clearfix"></div>
				</div>
				<!-- { tab-Effects } -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="summary">
						<!-- <div class="mark-check1">
							<div class="col-sx-12 col-sm-12 select-date">
								<form role="form">
									<div class="col-xs-12 col-sm-4 col-md-3 col-lg-2 tetrt">
										Select Date:&nbsp; <span>Form</span>
									</div>
									<div class="col-xs-12 col-sm-3 col-md-3 col-lg-2">
										<input type="date" placeholder="Date" id="inputdate31"
											class="form-control">
									</div>
									<div class="col-xs-12 col-sm-1 tetrt">To</div>
									<div class="col-xs-12 col-sm-3 col-md-3 col-lg-2">
										<input type="date" placeholder="Date" id="inputdate41"
											class="form-control">
									</div>
									<div class="col-xs-12 col-sm-1 col-md-2 col-lg-2">
										<input type="button" class="btn btn-primary" Value="Go">
									</div>
								</form>
							</div>
						</div> -->
						<div class="table-responsive user-map">
							<table class="table table-bordered table-striped text-center">
								<tr>

									<th>Sr. No.</th>
									<th>User Name</th>
									<th>Full Name</th>
									<th>Email</th>
									<th>Active/Deactive</th>
								</tr>
								<c:forEach items="${userlist}" var="user" varStatus="status">
									<tr>
										<td>${status.index+1}</td>
										<td>${user.username}</td>
										<td>${user.userDetails.firstName}&nbsp;
											${user.userDetails.lastName}</td>
										<td>${user.email}</td>
										<td><c:choose>

												<c:when test="${user.active==1}">
													<a
														href="useractivedeactive?status=${user.active}&userId=${user.userId}">Deactivate</a>
												</c:when>
												<c:otherwise>
													<a href="useractivedeactive?status=${user.active}&userId=${user.userId}">Activate</a>
												</c:otherwise>

											</c:choose></td>
									</tr>
								</c:forEach>
								<tr>
									<td colspan="5" align="center"></td>
								</tr>

							</table>



						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /container -->
	</section>


</body>

