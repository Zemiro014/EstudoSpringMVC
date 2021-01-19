<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- Modern combined and minimized CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- Additional themes -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<title>Sign Up</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			// Cancel
			$(".cencle").on("click", function(){
				
				location.href = "/";
						    
			})
		
			$("#submit").on("click", function(){
				if($("#userPass").val()==""){
					alert("Please enter a password.");
					$("#userPass").focus();
					return false;
				}
				if($("#userName").val()==""){
					alert("Please enter your name.");
					$("#userName").focus();
					return false;
				}
				
				$.ajax({
					url : "/member/passChk",
					type : "POST",
					dateType : "json",
					data : $("#updateForm").serializeArray(),
					success: function(data){
						
						if(data==true){
							if(confirm("Do you want to edit your membership?")){
								$("#updateForm").submit();
							}
							
						}else{
							alert("The password is incorrect.");
							return;
							
						}
					}
				})
				
			});	
		})
	</script>
	<body>
		<section id="container">
			<form id="updateForm" action="/member/memberUpdate" method="post">
				<div class="form-group has-feedback">
					<label class="control-label" for="userId">ID: </label>
					<input class="form-control" type="text" id="userId" name="userId" value="${member.userId}" readonly="readonly"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPass">Password: </label>
					<input class="form-control" type="password" id="userPass" name="userPass" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userName">User name:</label>
					<input class="form-control" type="text" id="userName" name="userName" value="${member.userName}"/>
				</div>
				<div class="form-group has-feedback">
					<button class="btn btn-success" type="submit" id="submit">Member information modification</button>
					<button class="cencle btn btn-danger" type="button">Cancel</button>
				</div>
			</form>
		</section>
		
	</body>
	
</html>