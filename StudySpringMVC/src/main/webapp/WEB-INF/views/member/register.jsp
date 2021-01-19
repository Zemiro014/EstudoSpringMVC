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
			if($("#userId").val()==""){
				alert("Please enter your ID.");
				$("#userId").focus();
				return false;
			}
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
			var idChkVal = $("#idChk").val();
			if(idChkVal == "N"){
				alert("Please click the duplicate check button.");
			}else if(idChkVal == "Y"){
				$("#regForm").submit();
			}
		});
	})
	
	function fn_idChk(){
		$.ajax({
			url : "/member/idChk",
			type : "post",
			dataType : "json",
			data : {"userId" : $("#userId").val()},
			success : function(data)
			{
				if(data == 1)
				{
					alert("This is a duplicate ID.");
				}
				else if(data == 0)
				{
					$("#idChk").attr("value", "Y");
					alert("Username is available.");
				}
			}
		})
	}
	</script>
	<body class="container">
		<section id="container">
			<form action="/member/register" method="post" id="regForm">
				<div class="form-group has-feedback">
					<label class="control-label" for="userId">ID:</label>
					<input class="form-control" type="text" id="userId" name="userId" />
					<button class="idChk btn btn-primary" type="button" id="idChk" onclick="fn_idChk();" value="N">Check Duplicity of ID</button>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPass">Password: </label>
					<input class="form-control" type="password" id="userPass" name="userPass" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userName">Name: </label>
					<input class="form-control" type="text" id="userName" name="userName" />
				</div>
				
			</form>
				<div class="form-group has-feedback">
					<button class="btn btn-success" type="button" id="submit">Sign Up</button>
					<button class="cencle btn btn-danger" type="button">Cancel</button>
				</div>
		</section>
		
	</body>
	
</html>