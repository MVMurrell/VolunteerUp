
<link rel="stylesheet" type="text/css" href="index.css">
<nav class="navbar navbar-fixed-top">
<ul>
	<a class="navbar-brand " href="home.do"> <img
		src="http://www.iagreenstar.org/new/wp-content/uploads/hands.png"
		width="35" height="35" class="d-inline-block align-top" alt="logo"></a>
	</ul>
	<ul class="nav navbar-nav navbar-left">
		<li class="nav-item navh"><a class="nav-link " href="home.do">VolunteerUp</a></li>
	</ul>

	<ul class="nav navbar-nav navbar-left">
		<c:if test="${not empty user && user.role == 'admin'}">
			<li class="nav-item"><a class="nav-link" href="admin.do">Admin
					page</a></li>
		</c:if>
	</ul>
	<ul class="nav navbar-nav navbar-left">
		<c:if test="${user != null}">
			<li class="nav-item"><a
				class="nav-link glyphicon glyphicon-user" href="account.do">Account</a></li>
		</c:if>
	</ul>
	

	<ul class="nav navbar-nav navbar-right">
		<c:if test="${empty user}">
			<li class="nav-item"><a
				class="nav-link glyphicon glyphicon-log-in log" href="login.do">
					Login/Register</a></li>

		</c:if>
	</ul>
	<ul class="nav navbar-nav navbar-right">
		<c:if test="${not empty user}">
			<li class="navbar-right"><a
				class="nav-link glyphicon glyphicon-log-in log" href="logout.do">
					Logout</a></li>
		</c:if>
	</ul>
</nav>

