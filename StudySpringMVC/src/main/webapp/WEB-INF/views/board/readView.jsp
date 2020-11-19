<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>게시판</title>
	</head>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='readForm']");
			
			// Update 
			$(".update_btn").on("click", function(){
				formObj.attr("action", "/board/updateView");
				formObj.attr("method", "get");
				formObj.submit();				
			})
			
			// delete
			$(".delete_btn").on("click", function(){
				var deleteYN = confirm("Are you sure you want to delete it?");
				
				if(deleteYN == true)
				{
					formObj.attr("action", "/board/delete");
					formObj.attr("method", "post");
					formObj.submit();
				}				
			})
			
			// Cancel
			$(".list_btn").on("click", function(){
				
				location.href = "/board/list";
			})
		})
	</script>
	
	<body>
	
		<div id="root">
			<header>
				<h1>Notice Board</h1>
			</header>
			<hr />			 
			<div>
				<%@include file="nav.jsp" %>
			</div>
			<hr />
			
			<section id="container">
				<form name="readForm" role="form" method="post">
					<input type="hidden" id="idx" name="idx" value="${read.idx}" />
				</form>
				<table>
					<tbody>
						<tr>
							<td>
								<label for="title">Title</label><input type="text" id="title" name="title" value="${read.title}" readonly="readonly" />
							</td>
						</tr>	
						<tr>
							<td>
								<label for="content">Content</label><textarea id="content" name="content" readonly="readonly"><c:out value="${read.content}" /></textarea>
							</td>
						</tr>
						<tr>
							<td>
								<label for="writer">E-mail</label><input type="text" id="writer" name="writer" value="${read.writer}"  readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<label for="regdate">Date</label>
								<fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd" />					
							</td>
						</tr>		
					</tbody>			
				</table>
				<div>
					<button type="submit" class="update_btn">Update</button>
					<button type="submit" class="delete_btn">Delete</button>
					<button type="submit" class="list_btn">Cancel</button>	
				</div>
			</section>
			<hr />
		</div>
	</body>
</html>