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
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous"> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="profile.css">
<link href="https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300" rel="stylesheet">
<title>Edit Project</title>
</head>
<body>
	<%@include file="navBar.jsp"%>
	<br>
	<br>
	<br>
	<header>
	</header>
	<div class=container>
		<div class=row>
			<div class="col-sm-4">
				<h2>Edit Project</h2>
				<form action="editProject.do" method="post">
					<div class="form-group">
						<label id="title">Title</label> <input type="text" id="title"
							name="title" required value="${project.title }"></input>
					</div>
					
					<div class="form-group">
						<label id="active">Project Status</label> 
						<input type="radio" id="active"
							name="active" value="true"  checked="checked" required>Open
						<input type="radio" id="active"
							name="active" value="false">Closed
					</div>
					<div class="form-group">
						<label id="sDate">Start Date</label> <input type="date" id="sDate"
							required name="sDate" value="${project.startDate}"></input>
					</div>
					<div class="form-group">
						<label id="eDate">End Date</label> <input type="date" id="eDate"
							required name="eDate" value="${project.endDate}"></input>
					</div>
					<div class="form-group">
						<label id="sTime">Time</label> <input type="time" id="sTime"
							name="sTime" required value="${project.time}"></input>
					</div>
					<div class="form-group">
						<label id="volunteersNeeded">Volunteers Needed</label>
						<input type="number" required id="volunteersNeeded"
							name="volunteersNeeded" size="5" maxlength="5" min="0"
							value="${project.volunteersNeeded}"></input>
					</div>
					<div class="form-group">
						<label id="hoursNeeded">Hours Needed</label> <input type="number"
							id="hoursNeeded" required name="hoursNeeded"
							value="${project.hoursNeeded}" size="5" maxlength="5" min="0"></input>
					</div>
					<div class="form-group">
						<label id="description">Project Description</label> <br>
						<textarea id="description" required name="description" cols="45"
							rows="4">${project.description}</textarea>
					</div>
					<div class="form-group">
						<!-- Street 1 -->
						<label for="street1_id" class="control-label">Street
							Address </label> <input type="text" class="form-control" id="street1_id"
							name="street" value="${ project.address.street}">
					</div>
					<div class="form-group">
						<!-- City-->
						<label for="city_id" class="control-label">City</label> <input
							type="text" class="form-control" id="city_id" name="city"
							value="${ project.address.city}">
					</div>

					<div class="form-group">
						<!-- State Button -->
						<label for="stateId" class="control-label">State</label> 
						<select class="form-control" id="stateId" name="stateId" >
							<c:forEach items="${ stateList}" var="state">
								<c:choose>
									<c:when test="${state.id == project.address.state.id }">
									
										<option value="${state.id }" selected> ${state.name}</option>
									</c:when>
									<c:otherwise>
										<option value="${state.id }">${state.name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>

					<div class="form-group">
						<!-- Zip Code-->
						<label for="zip_id" class="control-label">Zip Code</label> <input
							type="number" class="form-control" id="zip_id" name="zip"
							value="${ project.address.zip}">
					</div>

					<h4>Edit Categories</h4>
					<div class="form-group">
						<c:forEach items="${pCatList}" var="cat">
							${cat.name }: 
							<input value="${cat.id }" type="checkbox" name="cat" id="cat"
								checked>
							<br>
						</c:forEach>
						<c:forEach items="${rCatList}" var="cat">
							${cat.name }: 
							<input value="${cat.id }" type="checkbox" name="cat" id="cat" >
							<br>
						</c:forEach>


					</div>
					
					<%-- <div>
						<input type="hidden" value="${sessions.user.id}" id="ownerId"
							name="ownerId" />
					</div> --%>
					
					
					<div>
						<input type="hidden" value="true" id="active" name="active" />
					</div>
					<div>
						<input type="hidden" value="${project.id }" id="projectId" name="id" />
					</div>
					<input type="submit" class="btn btn-primary" value="Save Changes" />
				</form>
				<br>
				<br>
				<br>
			</div>
			<div class="col-sm-4">
			
				<c:if test="${not empty currentItemsNeeded }">
					<h4>Edit Items needed for the Project</h4>
					<form action="editItemsNeeded.do" method="post">
						<select name="itemId">
							<c:forEach items="${currentItemsNeeded}" var="needed">
							<option value="${needed.id }">${needed.item}-${needed.quantity }</option>
							</c:forEach>
						</select>		
						<input type="hidden"  value="${project.id }" name="projectId">		
						<input type="number" min="0" required name="quantity">		
						<input type="submit" value="Submit" class="btn btn-primary">		
					</form>
				</c:if>
				<br>
				<h4>Add Item needed for the Project</h4>
				<form action="addItemsNeeded.do" method="post">
					<select name="itemId">
						<c:forEach items="${remainingItems}" var="needed">
						<option value="${needed.id }">${needed}</option>
						</c:forEach>
					</select>	
					<input type="hidden"  value="${project.id }" name="projectId">		
					<input type="number" min="1" required name="quantity">		
					<input type="submit" value="Submit" class="btn btn-primary">		
				</form>
			
			
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