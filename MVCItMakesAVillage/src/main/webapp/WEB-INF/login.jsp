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

<title>Volunteer Site - Login </title>
</head>
<body>
	<%@include file="navBar.jsp"%>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="container">
		<div class="row">
		<div class="col-sm-2"></div>
			<div id="login" class="col-sm-4" >
				<!-- <h4>Create Account</h4> -->
				<c:if test="${loginFail }">
					<div class="message"> Username or password is incorrect</div>
				</c:if>	
				<c:if test="${activeFail }">
					<div class="message"> Account has been deactivated.
						<br>
						<form action="reactivate.do" method="post">
							<input type="hidden" id="id" name="id" value="${userId }">
							<input type="submit" class="btn btn-primary" value="Re-Activate Account">
						</form>
					
					</div>
				</c:if>	
				<h2 class="logInheader">Log In</h2>
				<form action="login.do" method="POST">
				<div class="form-group">
					<label id="userName">Username:</label> 
					<input type="text" id="username"
						   name="userName" placeholder="username"></input>
				</div>
				<div class="form-group">
					<label id="password">Password:</label> 
					<input type="password" id="password"
						   name="password" placeholder="password"></input>
				</div>
				<div class="form-group">
				<input type="submit" class="btn btn-primary" value="Submit" />
				</div>
				</form>
			</div>
			
			
			<div id="register" class="col-sm-4">
			<h2 class="registerHeader">Create Account</h2>
				<form action="createAccount.do" method="GET">
				<div class="form-group">
				<input type="submit" class="btn btn-primary" value="Create Account" />
				</div>
				</form>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="footer" id="footer">
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