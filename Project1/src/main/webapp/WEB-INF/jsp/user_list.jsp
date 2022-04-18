<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원정보 리스트</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	function del(uid){
		if(!confirm('해당 user를 강제 탈퇴 하시겠습니까?')){
			return;
		}
		location.href='/user/delete/'+uid;
	}
</script>
<style>
	body {position: absolute;  top: 50%; left: 50%; transform: translate(-50%, -50%);}
	h3 {text-align:center;}
	table{border:1px solid black; padding:0.5em; 
		border-spacing: 0; border-collapse: collapse;}
	th {border:1px solid black; background-color: #eee;}
	th:nth-child(2){width:15em;}
	td {border:1px solid black;}
	td{padding:0.2em 0.5em; text-align:center;}
</style>
</head>
<body>
<h3>회원정보 리스트</h3>
<table>
<tr>
	<th>회원 아이디</th>
	<th>회원 이름</th>
	<th>전화번호</th>
	<th>이메일 주소</th>
</tr>
<c:forEach var="u" items="${ulist}">
<tr>
	<td>${u.uid}</td>
	<td>${u.name}</td>
	<td>${u.phone}</td>
	<td>${u.email}</td>
	<td>
		<c:if test="${u.uid != 'admin'}">
			<button type="button" onclick="del('${u.uid}');">강제 탈퇴</button>
		</c:if>
	</td>
</tr>
</c:forEach>
</table>
<p>
<button type="button" onclick="location.href='/radish'">메인으로 가기</button>
</body>
</html>