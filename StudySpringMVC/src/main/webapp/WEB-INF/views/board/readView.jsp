<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
						<!-- Bootstrap -->
		<!-- Modern combined and minimized CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- Additional themes -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>Notice Board - ReadView</title>
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
			
			location.href = "/board/list?page=${scri.page}"
							+"&perPageNum=${scri.perPageNum}"
							+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
			})
			
			$(".replyWriteBtn").on("click", function(){
				  var formObj = $("form[name='replyForm']");
				  formObj.attr("action", "/board/replyWrite");
				  formObj.submit();
				});
			
			//Edit Comment View
			$(".replyUpdateBtn").on("click", function(){
				location.href = "/board/replyUpdateView?idx=${read.idx}"
								+ "&page=${scri.page}"
								+ "&perPageNum=${scri.perPageNum}"
								+ "&searchType=${scri.searchType}"
								+ "&keyword=${scri.keyword}"
								+ "&id_r="+$(this).attr("data-id_r");
			});
					
		//Delete Comment View
			$(".replyDeleteBtn").on("click", function(){
				location.href = "/board/replyDeleteView?idx=${read.idx}"
					+ "&page=${scri.page}"
					+ "&perPageNum=${scri.perPageNum}"
					+ "&searchType=${scri.searchType}"
					+ "&keyword=${scri.keyword}"
					+ "&id_r="+$(this).attr("data-id_r");
			});
		})
		
		function fn_fileDown(fileId)
		{
			var formObj = $("form[name='readForm']");
			$("#FILE_ID").attr("value", fileId);
			formObj.attr("action", "/board/fileDown");
			formObj.submit();
		}
	</script>
	
	<body>	
		<div class="container">
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
					  <input type="hidden" id="page" name="page" value="${scri.page}"> 
					  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
					  <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
					  <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
					  <input type="hidden" id="FILE_ID" name="FILE_ID" value=""> 
				</form>
				
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">Title</label>
					<input type="text" id="title" name="title" class="form-control" value="${read.title}" readonly="readonly" />
				</div>
				
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">Content</label>
					<textarea id="content" name="content" class="form-control" readonly="readonly"><c:out value="${read.content}" /></textarea>
				</div>
				
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">E-mail</label>
					<input type="text" id="writer" name="writer" class="form-control" value="${read.writer}"  readonly="readonly"/>
				</div>
				
				<div class="form-group">
					<label for="regdate" class="col-sm-2 control-label">Date</label>
					<c:out value="${read.regdate}" />
				</div>
				<span>Lista de arquivos</span>
				<div class="form-group" style="border:1px solid #dbdbdb">
					<c:forEach var="file" items="${file}">
						<a href="#" onclick="fn_fileDown('${file.FILE_ID}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
					</c:forEach>
				</div>
				<div>
					<button type="submit" class="update_btn btn btn-warning">Update</button>
					<button type="submit" class="delete_btn btn btn-danger">Delete</button>
					<button type="submit" class="list_btn btn btn-primary">  Cancel</button>	
				</div>
				
				<!-- comment -->
				<div id="reply">
				  <ol class="replyList">
				    <c:forEach items="${replyList}" var="replyList">
				      <li>
					        <p>
						        E-mail : ${replyList.writer}<br/>
						        Creation date :  <fmt:formatDate value="${replyList.regdate}" pattern="yyyy-MM-dd"/>
					        </p>				
					        <p>${replyList.content}</p>				        
							<div>
							  <button type="button" class="replyUpdateBtn btn btn-warning" data-id_r="${replyList.id_r}">Modify</button>
							  <button type="button" class="replyDeleteBtn btn btn-danger" data-id_r="${replyList.id_r}">delete</button>
							</div>
				      </li>
				    </c:forEach>   
				  </ol>
				</div>					
				
				<form name="replyForm" method="post" class="form-horizontal">
				  <input type="hidden" id="idx" name="idx" value="${read.idx}" />
				  <input type="hidden" id="page" name="page" value="${scri.page}">
				  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}">
				  <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}">
				  <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">
				
				  <div class="form-group">
				    <label for="writer" class="col-sm-2 control-label">Comment author:</label>
				    <div class="col-sm-10">
				    	<input type="text" id="writer" name="writer" class="form-control"/>
				    </div>
				  </div>
				  
				  <div class="form-group" >
				    <label for="content" class="col-sm-2 control-label">Comment content:</label>
				    <div class="col-sm-10">
				    	<input type="text" id="content" name="content" class="form-control"/>
				    </div>				    
				  </div>
				  
				  <div class="form-group">
					  <div class="col-sm-offset-2 col-sm-10">
					  	<button type="button" class="replyWriteBtn btn btn-success">Save comment</button>
					  </div>				 	 
				  </div>
				</form>						
			</section>
			<hr />
		</div>
	</body>
</html>
