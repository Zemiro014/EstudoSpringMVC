<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>	
						<!-- Bootstrap -->
		<!-- Modern combined and minimized CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- Additional themes -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				var formObj = $("form[name='writeForm']");
				
				$(".write_btn").on("click", function(){
					if(fn_valiChk()){
						return false;
					}
					formObj.attr("action", "/board/write");
					formObj.attr("method", "post");
					formObj.submit();
				});
			})
			
			function fn_valiChk(){
				var regForm = $("form[name='writeForm'] .chk").length;
				for(var i = 0; i<regForm; i++){
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
					$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"Delete"+"</button></div>");
				});
				$(document).on("click","#fileDelBtn", function(){
					$(this).parent().remove();					
				});
			}
		</script>
		
	 	<title>Notice Board</title>
	</head>
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
				<form name="writeForm" method="post" action="/board/write" enctype="multipart/form-data">
				
						<c:if test ="${member.userId != null}">							
								<div class="form-group has-feedback">
									<label class="control-label" for="title">Title: </label>
									<input type="text" id="title" name="title" class="chk form-control" title="lease enter the title."/>
								</div>
								
								<div class="form-group has-feedback">
									<label class="control-label" for="content">Content: </label>
									<textarea id="content" name="content" class="chk form-control" title="lease enter the content."></textarea>
								</div>
								
								<div class="form-group has-feedback">
									<label class="control-label" for="writer">E-mail: </label>
									<input type="text" id="writer" name="writer" class="chk form-control" title="Please enter the e-mail."/>
								</div>
								
								<div class="form-group has-feedback">
									<input class="control-label" type="file" name="file">
								</div>
								
								<div id="fileIndex">
								</div>
									
								<div class="form-group has-feedback">					
									<button class="write_btn btn btn-success" type="submit">OK</button>
									<button class="fileAdd_btn btn btn-success" type="button">Add file</button>	
								</div>
						</c:if>
							
							<c:if test="${member.userId == null}">
								<p>You need to log in before.</p>
							</c:if>	
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>