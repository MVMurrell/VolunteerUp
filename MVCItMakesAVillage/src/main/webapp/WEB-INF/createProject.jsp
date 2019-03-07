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
<title>Create Project</title>
</head>
<body>
<%@include file="navBar.jsp"%>
<br>
<br>
<br>
<br>
    <header>
    </header>
    <div class=container id="loginbox">
        <div class=row>
            <div class="col-sm-4">
      			<h2>Create Project</h2>
                <form action="createProject.do" method="post">
                    <div class="form-group">
                        <label id="title">Title</label> <input class="form-control" type="text" required
                            id="title" name="title"></input>
                    </div>
                    <div class="form-group">
						<!-- Street 1 -->
						<label for="street1_id" class="control-label">Street
							Address </label> 
							<input type="text" class="form-control" id="street1_id"
							name="street" placeholder="123 Main St." required>
					</div>
					<div class="form-group">
						<!-- City-->
						<label for="city_id" class="control-label">City</label> 
						<input type="text" class="form-control" id="city_id" name="city"
							placeholder="Townville" required>
					</div>

					<div class="form-group">
						<!-- State Button -->
						<label for="stateId" class="control-label">State</label> 
						<select class="form-control" id="stateId" name="stateId" required>
							<c:forEach items="${ stateList}" var="state">
								<option value="${state.id }">${state.name}</option>
							</c:forEach>
						</select>
					</div>

					<div class="form-group">
						<!-- Zip Code-->
						<label for="zip_id" class="control-label">Zip Code</label> 
						<input type="number" class="form-control" id="zip_id" name="zip"
							placeholder="12345" required>
					</div>
                    
                    <div class="form-group">
                        <label id="sDate">Start Date</label> <input type="date"
                            id="sDate" required name="sDate"></input>
                    </div>
                    <div class="form-group">
                        <label id="eDate">End Date</label> <input type="date"
                            id="eDate" required name="eDate"></input>
                    </div>
                    <div class="form-group">
                        <label id="sTime">Time</label> <input type="time" id="sTime"
                            required name="sTime"></input>
                    </div>
                    <div class="form-group">
                        <label id="volunteersNeeded">Volunteers Needed</label> 
                        <input type="number" 
                            id="volunteersNeeded" 
                            required
                            name="volunteersNeeded" 
                            min="0" 
                            size="5" 
                            maxlength="5"></input>
                    </div>
                    <div class="form-group">
                        <label id="hoursNeeded">Hours Needed</label> 
                        <input type="number" 
                        	   id="hoursNeeded" 
                        	   min="0" 
                       		   name="hoursNeeded" 
                       		   size="5" 
                       		   maxlength="5"></input>
                    </div>
                    <div class="form-group">
                        <label id="description">Project Description</label>
                        <br>
                        <textarea id="description" name="description" cols="45" rows="4"
                            required placeholder="Tell us about your Project"></textarea>
                    </div>
                    
                    <h3>Choose Categories</h3>
                    <div class="form-group">
                        <c:forEach items="${catList}" var="cat">
                            ${cat.name }: 
                            <input value="${cat.id }" type="checkbox" name="cat" id="cat">
                            <br>
                        </c:forEach>
                
                    </div>
                    <%-- <h3>Choose Items/Skills Needed:</h3>
                    <div class="form-group">
                    	<select name="itemId">
                    		<option>None</option>
	                        <c:forEach items="${itemList}" var="item">
	                            
	                            <option value="${item.id }">${item.name }</option>
	                        </c:forEach>
                    	</select>
                        <input type="number" id="itemQuantity" name="itemQuantity" min="1" value="1" required />
                    	
                
                    </div> --%>
                    
                    
                    <div>
                        <input type="hidden" value="${user.id}" id="ownerId" name="ownerId" />
                    </div>
                    <div>
                        <input type="hidden" value="true" id="active" name="active" />
                    </div>
                    
                    <input type="submit" class="btn btn-primary" value="Create Project" />
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
    <!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
        integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
        crossorigin="anonymous"></script>
    <script
        src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
        integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
        crossorigin="anonymous"></script> -->
</body>
</html>