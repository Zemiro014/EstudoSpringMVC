<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	
	 	<title>Notice Board UpdateView</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			$(document).on("click","#fileDel", function(){
				$(this).parent().remove();
			})
			
			fn_addFile();
			
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/board/readView?idx=${update.idx}"
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
			
		function fn_valiChk()
		{
			var updateForm = $("form[name='updateForm'] .chk").length;
			for(var i = 0; i<updateForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
		
 		function fn_addFile()
 		{
			var fileIndex = 1;
			//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"Add"+"</button></div>");
			$(".fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button class='btn btn-danger' type='button' style='float:right;' id='fileDelBtn'>"+"Delete"+"</button></div>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
		}
 		
 		var fileNoArry = new Array();
 		var fileNameArry = new Array();
 		
 		function fn_del(value, name)
 		{ 			
 			fileNoArry.push(value);
 			fileNameArry.push(name);
 			$("#fileNoDel").attr("value", fileNoArry); // In this condition attr is being used to define the variable "value" of the selected element "fileNoDel"
 			$("#fileNameDel").attr("value", fileNameArry);// In this condition attr is being used to define the variable "value" of the selected element "fileNameDel"
 															// attr can also be used to return a value
 		}
	</script>
	<body>
	
		<div class="container">
			<header>
				<h1> Notice Board</h1>
			</header>
			<hr />
			 
			<div>
				<%@include file="nav.jsp" %>
			</div>
			<hr />
			
			<section id="container">
				<form name="updateForm" role="form" method="post" action="/board/update" enctype="multipart/form-data">
					<input type="hidden" name="idx" value="${update.idx}" readonly="readonly"/>
					<input type="hidden" id="page" name="page" value="${scri.page}"> 
					<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
					<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
					<input type="hidden" id="fileNoDel" name="fileNoDel[]" value=""> 
					<input type="hidden" id="fileNameDel" name="fileNameDel[]" value=""> 
					<table class="table table-hover">
						<tbody>
							<tr>
								<td>
									<label for="title">Title:</label><input type="text" id="title" name="title" value="${update.title}" class="chk form-control" title="Please enter your title."/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="content">Content:</label>
									<textarea id="content" name="content" class="chk form-control" title="Please enter your content."><c:out value="${update.content}" /></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer">E-mail</label>
									<input class="form-control" type="text" id="writer" name="writer" value="${update.writer}" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>								 
									<label class="form-control" for="regdate">Creation date: </label><c:out value="${update.regdate}" />		
								</td>
							</tr>
							<tr>
								<td id="fileIndex">
									<c:forEach var="file" items="${file}" varStatus="var">
									<div>
										<input class="form-control" type="hidden" id="FILE_ID" name="FILE_ID_${var.index}" value="${file.FILE_ID}">
										<input class="form-control" type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_ID_${var.index}">
										<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
										<button class="btn btn-danger" id="fileDel" onclick="fn_del('${file.FILE_ID}','FILE_ID_${var.index}');" type="button">delete</button><br>
									</div>
									</c:forEach>
								</td>
							</tr>
						</tbody>			
					</table>
					<div class="form-group has-feedback">
						<button type="button" class="update_btn btn btn-success">Save</button>
						<button type="button" class="cancel_btn btn btn-primary">Cancel</button>
						<button type="button" class="fileAdd_btn btn btn-warning">Add file</button>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>