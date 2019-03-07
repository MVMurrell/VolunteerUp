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
<title>Volunteer Site - Edit Profile</title>
</head>
<body>
	<%@include file="navBar.jsp"%>
	<br>
	<br>
	<br>
	<header> </header>
	<div class="container">
		<div class="row">
			<div class="col-sm-2" >
			</div>
			<div class="col-sm-4" >
				<h4>Edit Profile</h4>
				<form action="editProfile.do" method="POST">
					<div class="form-group">
						<input type="hidden" id="userid" name="userid"
							   value="${user.id }"></input>
					</div>
					<div class="form-group">
						<label id="firstName">First Name:</label> 
						<input type="text" id="John"
							   required maxlength="45"
							   name="firstName" value=${user.volunteer.firstName }>
					</div>
					<div class="form-group">
						<label id="lastName">Last Name:</label> 
						<input type="text" id="Smith"
							   required maxlength="45"
							   name="lastName" value=${user.volunteer.lastName }>
					</div>
					<div class="form-group">
						<label id="date">Birth date:</label> 
						<input type="date" id="date"
							   required
							   name="date" value =${user.volunteer.dob }>
					</div>
					<div class="form-group">
						<label for="phone">Phone Number:</label> 
						<input type="text" id="phone" maxlength="15"
							   name="phone" value=${user.volunteer.phone }>
					</div>
					<div class="form-group">
						<!-- Street 1 -->
						<label for="street1_id" class="control-label">Street
							Address </label> 
						<input type="text" class="form-control" id="street1_id"
							name="street" value="${user.volunteer.address.street }" required>
					</div>
					<div class="form-group">
						<!-- City-->
						<label for="city_id" class="control-label">City</label> 
						<input type="text" class="form-control" id="city_id" name="city"
							value="${user.volunteer.address.city }" required>
					</div>

					<div class="form-group">
						<!-- State Button -->
						<label for="stateId" class="control-label">State</label> 
						<select class="form-control" id="stateId" name="stateId" required>
							<c:forEach items="${ stateList}" var="state">
								<c:choose>
									<c:when test="${state.id == user.volunteer.address.state.id }">
									
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
						<label for="zip_id" class="control-label">Zip Code</label> 
						<input type="number" class="form-control" id="zip_id" name="zip"
							value="${user.volunteer.address.zip }" required>
					</div>
					<div class="form-group">
						<label for="about">About me:</label> 
						<br>
						<textarea id="about" maxlength="250" 
								  name="about" 
								  required 
								  cols="35" rows="3">${user.volunteer.about } </textarea>
					</div>
					<div class="form-group">
						<label for="pictureURL">Profile Image:</label> 
						<input type="text" id="pictureURL"
							   name="pictureURL" value="${user.volunteer.pictureURL }">
					</div>
					<div class="form-group">
					<input type="submit" class="btn btn-primary" value="Save Changes" />
					</div>
				</form>
			</div>
			<div class="col-sm-1" >
			</div>
			<div class="col-sm-4" >
				<h4>Edit Login Info</h4>
				<form action="editAccount.do" method="POST">
					<div class="form-group">
						<input type="hidden" id="id" name="id"
							   value="${user.id }">
					</div>
					<div class="form-group">
						<label for="userName">Username: </label>
						<input type="text" id="userName" name="userName"
							   maxlength="45" value="${user.userName }">
					</div>
					<div class="form-group">
						<label for="password">Password: </label>
						<input type="password" id="password" name="password"
							   maxlength="45" value="${user.password }">
					</div>
					<div class="form-group">
						<label for="email">Email: </label>
						<input type="email" id="email" name="email"
							   maxlength="45" value="${user.email }">
					</div>
					<input type="submit" class="btn btn-primary" value="Save Changes"/>
				
				</form>
				<form action="deactivate.do" method="post">
							<input type="hidden" id="id" name="id" value="${user.id }">
							<input type="submit" class="btn btn-primary" value="De-Activate Account">
				</form>
				<br>
				<br>
				<br>
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