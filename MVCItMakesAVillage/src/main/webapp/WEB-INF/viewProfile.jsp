<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300" rel="stylesheet">
  
<link rel="stylesheet" type="text/css" href="profile.css">
<title>${userView.volunteer.firstName} Profile</title>
</head>
<body>
	<%@include file="navBar.jsp"%>
		<br>
		<br>
		<br>
	<header>
		<div class="row">
			<div class="col-sm-5"></div>
			<div class="col-sm-5">
				<h2>${userView.volunteer.firstName}'s Profile</h2>
			</div>
		
		</div>
	</header>
	<br>
	<br>
	<div class=container>
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-4">
			<br>
				<div class="profilePicture">
					<c:if test="${not empty userView.volunteer.pictureURL }">
						<img src="${userView.volunteer.pictureURL}" class="img-fluid">
					</c:if>
					<c:if test="${empty userView.volunteer.pictureURL }">
						<img src="https://pbs.twimg.com/profile_images/821849411991044096/lQFa_Vly_400x400.jpg" class="img-fluid" >
					</c:if>
				</div>
					<br>
					<br>
				<ul class="list-group">
					<li class="list-group-item">Name: ${userView.volunteer.firstName}
						${userView.volunteer.lastName}</li>
					<li class="list-group-item">About: ${userView.volunteer.about}</li>
				</ul>
				<br>
				
			</div>
			<div class="col-sm-4">
				
				<h3>Projects ${userView.volunteer.firstName } is In</h3>
				<div data-spy="scroll" data-target="#project-scrollbox"
					data-offset="0">
					<c:forEach items="${userView.volunteer.projects}" var="project">
						<ul class="list-group">
							<li class="list-group-item"><h3>${project.title}</h3>
								<c:if test="${project.active }"> 
				  					<h4>Project is Open</h4>
				  				</c:if>
				  				<c:if test="${not project.active }"> 
				  					<h4>Project is Closed</h4>
				  				</c:if>
				  				 <br>
				  				<strong>Owner Name: </strong>${project.owner.firstName} ${project.owner.lastName} 
				  				 <br>
				  				 <strong>Contact Phone: </strong> ${project.owner.phone }
				  				 <br>
				  				 <strong>Contact Email: </strong> ${project.owner.user.email }
				  				 <br>
				  				 
				  				 <strong>Location: </strong>
					  				 ${project.address.city }
					  				 <br>
					  				 ${project.address.state.name }
					  				 <br>
				  				 <br>
				  				<strong>StartDate: </strong>${project.startDate}
				  				 <br>
				  				<strong>EndDate: </strong>${project.endDate}
				  				 <br>
				  				<strong>Time: </strong>${project.time}
				  				 <br>
				  				<c:if test="${(project.volunteersNeeded - fn:length(project.volunteers)) > 0}">
				  					<strong>Volunteers still needed: </strong>
				  					${project.volunteersNeeded - fn:length(project.volunteers) }
				  				</c:if>
				  				<c:if test="${(project.volunteersNeeded - fn:length(project.volunteers)) <= 0}">
				  					<strong>Volunteer:</strong>
				  					Volunteer Goal Met
				  				</c:if>
								<div class="bottomButton">
								
									<form action="viewProject.do" method="get">
										<input type="hidden" value="${project.id }" name="projectId">
										<input type="submit" class="btn btn-primary" value="View Project">
			
									</form>
								</div>
								
							</li>
						</ul>
					</c:forEach>
				</div>
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

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
</body>
</html>