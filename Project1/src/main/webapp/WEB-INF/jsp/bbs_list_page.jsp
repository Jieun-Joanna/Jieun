<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓 : 게시판</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<style>
	body {position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);}
	h3 {text-align:center;}
	table{border:1px solid black; padding:0.5em; margin-left: auto; margin-right: auto; 
		 border-spacing: 0; border-collapse: collapse;}
	th {border:1px solid black; background-color: #eee;}
	th:nth-child(2){width:20em;}
	td {border:1px solid black;}
	td{padding:0.2em 0.5em; text-align:center;}
	a { text-decoration:none; }
	a:hover { color:red; }
	a:active { color:gold; } 
</style>
</head>
<body>
<h3>게시판 목록</h3>
<button type="button" onclick="location.href='/bbs/upload'">글쓰기</button> 
	<button type="button" onclick="location.href='/bbs/list/page/1'">전체 목록</button>
	<button type="button" onclick="location.href='/radish'">홈으로 가기</button>
<p>
<table>
<tr>
	<th>번호</th>
	<th>글 제목</th>
	<th>작성자</th>
	<th>작성일</th>
	<th>조회수</th>
</tr>
<c:forEach var="b" items="${pageInfo.list}">
<tr>
	<td>${b.num}</td>
	<td><a href="/bbs/detail/${b.num}">${b.title}</a></td>
	<td>${b.author}</td>
	<td>${b.wdate}</td>
	<td>${b.hitcount}</td>
</tr>
</c:forEach>
</table>
<p>
<div id="pagination">
	<c:forEach var="i" items="${pageInfo.navigatepageNums}">	
		<c:choose>
			<c:when test="${i==pageInfo.pageNum}">
				[${i}] 
			</c:when>		
			<c:otherwise>
				<c:if test="${!srch}">
					[<a href="/bbs/list/page/${i}">${i}</a>]
				</c:if>
				<c:if test="${srch}">
					[<a href="/bbs/list/search?pgNum=${i}&search=${search}">${i}</a>]
				</c:if>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</div>
<p>
<form action="/bbs/list/search" method="get">
	<input type="hidden" id="pgNum" name="pgNum" value="${pageInfo.pageNum}">
	<input type="text" id="search" name="search"><button type="submit">검색</button>
</form>
</body>
</html>