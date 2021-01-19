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
	 	<title>Notice Board</title>
	 	<style type="text/css">
			li {list-style: none; float: left; padding: 6px;}
		</style>
		
	</head>
	<body>
		<script>
		$( document ).ready(function() {
			$('#searchBtn').click(function() {
			      self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType="+$("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
			    	//window.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
			    });
		});
		</script>
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
				<form role="form" method="post" action="/board/write">
					<table class="table table-hover">
						<tr><th>Number</th><th>Title</th><th>E-mail</th><th>Contents</th><th>Date</th><th>Number of views</th></tr>
						
						<c:forEach items="${list}" var="list">
							<tr>
								<td><c:out value="${list.idx}" /></td>
								<td>
									<a href="/board/readView?idx=${list.idx}&
															page=${scri.page}&
															perPageNum=${scri.perPageNum}&
															searchType=${scri.searchType}&
															keyword=${scri.keyword}"><c:out value="${list.title}" /></a>
								</td>
								<td><c:out value="${list.writer}" /></td>
								<td><c:out value="${list.content}" /></td>
									<td><c:out value="${list.regdate}" /></td>
								<td><c:out value="${list.hit}" /></td>
							</tr>
						</c:forEach>
						
					</table>
					
					<div class="search row">
						<div class="col-xs col-sm-2">						
						    <select name="searchType" class="form-control">
						      <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
						      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>Title</option>
						      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>Contents</option>
						      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>E-mail</option>
						      <option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>Title + Content</option>
						    </select>
						</div>
						<div class="col-xs-10 col-sm-10">
							<div class="input-group">
								<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
								<span class="input-group-btn">
									<button id="searchBtn" type="button" class="btn btn-default"> Search </button>
								</span>
							</div>
						</div> 
					    
					    
 					</div>
 					
					<div class="col-md-offset-3">
					  <ul class="pagination">
					    <c:if test="${pageMaker.prev}">
					    	<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}"> Previous</a></li>
					    </c:if> 
					
					    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
								<li <c:out value="${pageMaker.cri.page == idx ? 'class=info' : ''}" />>
								<a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
						</c:forEach>
					
					    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					    	<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}"> Next</a></li>
					    </c:if> 
					  </ul>
					</div>	
				
				</form>
			</section>
			
			<hr />
		</div>
	</body>
</html>