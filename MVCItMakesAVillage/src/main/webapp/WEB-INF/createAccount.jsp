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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
  
  <link rel="stylesheet" type="text/css" href="profile.css">
  <title>Volunteer Site - Create Account</title>
</head>
<body>
	<%@include file="navBar.jsp"%>
	  
	  <br>
	   <br>
	    <br>
	     <br>

	<header> </header>
	<div class="container">
		<div class="row">
			<div class="col-sm-4" >
			</div>
			<div class="col-sm-4" >
				<h4>Create Account</h4>
				<br>
				<form action="createAccount.do" method="POST">
				<div class="form-group">
					<label for="email">Email:</label> 
					<input type="email" id="email"
						   maxlength="45" name="email" placeholder="email" required>
				</div>
				<div class="form-group">
					<label for="userName">Username:</label> 
					<input type="text" id="userName"
						   maxlength="45" name="userName" placeholder="username" required>
				</div>
				<div class="form-group">
					<label for="password">Password:</label> 
					<input type="password" id="password"
						   maxlength="45" name="password" placeholder="password" required>
				</div>
				<input type="submit" class="btn btn-primary" value="Submit" />
				</form>
				<c:if test="${usernameInUse }">
	  				<div class="usernameInUse">Username is taken. Please try again.</div>
	  			</c:if>
				<c:if test="${emailInUse }">
	  				<div class="emailInUse">Email is already in use. Please try again.</div>
	  			</c:if>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="footer">
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