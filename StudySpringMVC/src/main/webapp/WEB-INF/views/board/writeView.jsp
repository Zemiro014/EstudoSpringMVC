<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
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
		</script>
		
	 	<title>Notice Board</title>
	</head>
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
				<form role="writeForm" method="post" action="/board/write">
					<table>
						<tbody>
							<tr>
								<td>
									<label for="title">Title</label><input type="text" id="title" name="title" class="chk" title="Nao sei o que e."/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="content">Content</label><textarea id="content" name="content" class="chk" title="Nao sei o que e."></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer">E-mail</label><input type="text" id="writer" name="writer" class="chk" title="Nao sei o que e."/>
								</td>
							<tr>
								<td>						
									<button class="write_btn" type="submit">OK</button>
								</td>
							</tr>			
						</tbody>			
					</table>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>