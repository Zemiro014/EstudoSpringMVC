<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>Notice Board</title>
	</head>
		<script type="text/javascript">
			$(document).ready(function(){
				var formObj = $("form[name='updateForm']");
				
				$(".cancel_btn").on("click", function(){
					event.preventDefault();
					location.href = "/board/readView?bno=${update.idx}"
						   + "&page=${scri.page}"
						   + "&perPageNum=${scri.perPageNum}"
						   + "&searchType=${scri.searchType}"
						   + "&keyword=${scri.keyword}";
				})
				
				$(".update_btn").on("click", function(){
					if(fn_valiChk()){
						return false;
					}
					formObj.attr("action", "/board/update");
					formObj.attr("method", "post");
					formObj.submit();
				})
			})
				
			function fn_valiChk(){
				var updateForm = $("form[name='updateForm'] .chk").length;
				for(var i = 0; i<updateForm; i++){
					if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
						alert($(".chk").eq(i).attr("title"));
						return true;
					}
				}
			}		
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
				<form name="updateForm" role="form" method="post" action="/board/update">
					<input type="hidden" name="idx" value="${update.idx}" readonly="readonly"/>
					<table>
						<tbody>
							<tr>
								<td>
									<label for="title">Title</label><input type="text" id="title" name="title" value="${update.title}" class="chk" title="Não sei o que é."/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="content">Content</label><textarea id="content" name="content" class="chk" title="Não sei o que é."><c:out value="${update.content}" /></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer">E-mail</label><input type="text" id="writer" name="writer" value="${update.writer}" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>
									<label for="regdate">Date</label>
									<c:out value="${update.regdate}" />					
								</td>
							</tr>		
						</tbody>			
					</table>
					<div>
						<button type="submit" class="update_btn">Save</button>
						<button type="submit" class="cancel_btn">Cancel</button>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>