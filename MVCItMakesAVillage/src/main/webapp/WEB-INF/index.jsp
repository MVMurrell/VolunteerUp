<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300|Roboto+Condensed"
	rel="stylesheet">

<link rel="stylesheet" type="text/css" href="index.css">
<title>Home</title>
</head>
<body>
	<%@include file="navBar.jsp"%>
	<div class="bg-img">
		<br> <br>
		<div class="ticker">
			<strong>Hours Pledged: </strong> ${hoursPledged } <strong>Hours
				Contributed: </strong> ${hoursContributed} <strong>Total Projects: </strong>
			${projects } <strong>Total Volunteers: </strong> ${volunteers}
		</div>
		<div class="headerText">
			<h1>Organize Projects in Your Community</h1>
		</div>

		<div class="row" id="centered">
			<div class="col-sm-5">
				<div class="containerKW">
					<form action="searchKW.do" method="get" id="searchByKW">
						<div class="KWHeader">
							<label for="keyword">Search by Keyword(s): </label>
						</div>
						<c:if test="${notFound }">
							<div class="notFoundMessage">No Projects Found</div>
						</c:if>
						<br> <input type="text" name="keyword" id="keyword"
							placeholder="Search" maxlength="45" /> <input type="submit"
							value="Search" class="btn btn-primary" />
					</form>
					<br>
					<c:if test="${not empty user }">
						<form action="searchLocal.do" path="get">
							<input type="submit" value="Search Local Projects"
								class="btn btn-primary" />
						</form>
					</c:if>
				</div>
			</div>
			<div class="col-sm-5">
				<form action="searchCat.do" method="get" id="searchByCat"
					class="containerCategory">
					<div class="CategoryHeader">
						<label for="keyword">Search by Category </label>
					</div>
					<br>
					<c:if test="${notFound }">
						<div class="notFoundMessage">No Projects Found</div>
					</c:if>
					<c:if test="${needCategory }">
						<div class="needCategoryMessage">Please pick a category</div>
					</c:if>
					<br>

					<c:forEach var="cat" items="${catList}">
						<!-- <div class="form-check form-check-inline"></div> -->
						<strong>${cat.name}:</strong>
						<input id="keyword" name="keyword" type="checkbox"
							value="${cat.name}">

					</c:forEach>
					<br> <br> <br> <input type="submit" value="Search"
						class="btn btn-primary" />
				</form>
			</div>
		</div>
	</div>

	<%-- <div class="container">
        <form form-check form-check-inline action="searchCat.do" method="get"
            id="searchByCat" class="containerCategory">
            <label class="categoryHeader" for="keyword">Search by
                Category </label>
            <c:forEach var="cat" items="${catList}">
                    <strong>${cat.name}:</strong>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" id="inlineCheckbox1" name="keyword"
                        type="checkbox" value="${cat.name}"> <label
                        class="form-check-label" for="inlineCheckbox1">${cat.name}:</label>
                </div>
            </c:forEach>
            <input type="submit" value="Search" class="btn1 btn-primary" />
        </form>
    </div> --%>
	<br>
	<br>
	<br>
	<br>
	<div class="containerProject">
		<div class="row">
			<div class="col-sm-1"></div>
			<div class="col-sm-4">
				<c:if test="${not empty projectList }">
					<c:if test="${(fn:length(projectList)) > 1}">
						<h2 class="projectListHeader">Your Project Search Results</h2>
					</c:if>
					<c:if test="${(fn:length(projectList)) == 1}">
						<h2 class="projectListHeader">Your Project Search Result</h2>
					</c:if>
					<c:forEach var="project" items="${projectList}">
						<strong>${project.title}</strong>
						<br>
						<%-- <strong>Owner Name: </strong>${project.owner.firstName} ${project.owner.lastName} 
                         <br>
                        <strong>Address: </strong>${project.address }
                         <br> --%>
						<Strong>Location: </Strong>${project.address.city }, ${project.address.state}
                         <br>
						<strong>StartDate: </strong>${project.startDate}
                         <br>
						<%-- <strong>EndDate: </strong>${project.endDate}
                         <br>
                        <strong>Time: </strong>${project.time}
                         <br> --%>
						<strong>Category: </strong>
						<c:forEach items="${project.categories}" var="cat"
							varStatus="loop">
                            ${cat.name}
                            <c:if test="${!loop.last}">,</c:if>
						</c:forEach>
						<br>

						<c:if test="${project.active }">
							<strong>Project is: </strong>
							<span class="open">OPEN</span>
						</c:if>
						<c:if test="${not project.active }">
							<strong>Project is: </strong>
							<span class="closed">CLOSED</span>
						</c:if>
						<br>
						<c:if
							test="${(project.volunteersNeeded - fn:length(project.volunteers)) <= 0}">
							<strong>Volunteer:</strong>
                            Volunteer Goal Met
						<br>
						</c:if>
						<c:if
							test="${(project.volunteersNeeded - fn:length(project.volunteers)) > 0}">
							<strong>Volunteers still needed: </strong>
                            ${project.volunteersNeeded - fn:length(project.volunteers) }
                        </c:if>
						<div cla ss="bottomButton">
							<form action="viewProject.do" method="get">
								<input type="hidden" value="${project.id }" name="projectId">
								<input type="submit" class="btn btnP btn-primary"
									value="View Project">
							</form>
						</div>

						<br>
					</c:forEach>
				</c:if>

			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="footer id="footer">
		<a href="about.do"> About</a>
		
	</div>
	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
</body>
</html>