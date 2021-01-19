<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<html>
<head>
	<title>Home</title>
		<!-- Modern combined and minimized CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- Additional themes -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 
</head>

<script type="text/javascript">
	$(document).ready(function(){
		$("#logoutBtn").on("click", function(){
			location.href="member/logout";
		})
		
		$("#registerBtn").on("click",function(){
			location.href="member/register";
		})
		$("#memberUpdateBtn").on("click",function(){
			location.href="member/memberUpdateView";
		})
	})
</script>
<body>
	<div class="container">
		<section id="container">
		
			<div class="form-group has-feedback">
				<a href="/board/list">List Board</a><br />
			</div>
			
			<form name='homeForm' method="post" action="/member/login">
				<c:if test="${member == null}">
					<div class="form-group has-feedback">
						<label class="control-label"  for="userId">User: </label>
						<input class="form-control" type="text" id="userId" name="userId">
					</div>
					<div class="form-group has-feedback">
						<label class="control-label"  for="userPass">Password: </label>
						<input class="form-control" type="password" id="userPass" name="userPass">
					</div>
					<div class="form-group has-feedback">
						<button class="btn btn-success" type="submit">login</button>
						<button class="btn btn-warning" id="registerBtn" type="button">Sign Up</button>
					</div>
				</c:if>
				<c:if test="${member != null }">
					<div class="form-group has-feedback">
						<p>${member.userId} Welcome.</p>
						<button class="btn btn-success" id="memberUpdateBtn" type="button">Member information modification</button>
						<button class="btn btn-success" id="logoutBtn" type="button">Log out</button>
					</div>
				</c:if>
				<c:if test="${msg == false}">
					<p style="color: red;">Login failed! Please check your ID and password.</p>
				</c:if> 
				<br>
				<p>The client locale is {} : ${locale}</p>
				<p>Server time: ${serverTime}</p>
			</form>
		</section>
	</div>
</body>
</html>