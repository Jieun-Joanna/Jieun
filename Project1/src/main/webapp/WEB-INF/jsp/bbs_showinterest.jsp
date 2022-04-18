<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓 : 찜 목록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	function delete_(lnum){
		if(!confirm('찜 목록에서 삭제하시겠습니까?')){
			return;
		}
		location.href='/bbs/interest/del/'+lnum;
	}
	
	function delAll(){
		if(!confirm('찜 목록을 비우시겠습니까?')){
			return;
		}
		location.href='/bbs/interest/delall';
	}
</script>
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
<h3>찜 목록 보기</h3>
<table>
<tr>
	<th>글 번호</th>
	<th>제목</th>
	<th>작성자</th>
	<th>작성일</th>
</tr>
<c:forEach var="bbs" items="${list}">
<tr>
	<td>${bbs.num}</td>
	<td><a href="/bbs/detail/${bbs.num}">${bbs.title}</a></td>
	<td>${bbs.author}</td>
	<td>${bbs.wdate}</td>
	<td><input type="hidden" name="lnum" value="${bbs.lnum}">
		<button type="button" onclick="delete_(${bbs.lnum});">삭제</button></td>
</tr>
</c:forEach>
</table>
<p>
<div><button type="button" onclick="delAll();">찜 목록 비우기</button> 
	<button type="button" onclick="location.href='/bbs/list/page/1'">계속 둘러보기</button></div>
</body>
</html>