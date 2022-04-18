<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	function logout(){
		if(!confirm('로그아웃 하시겠습니까?')) return;
		$.ajax({
			url:'/user/logout',
			method:'get',
			cache:false,
			dataType:'text',
			success:function(res){
				alert(eval(res) ? "로그아웃 성공" : "로그아웃 실패!");
				location.href='/radish';
			},
			err:function(xhr,status,err){
				alert('에러: '+err);
			}
		});
		return false;
	}
</script>
<style>
	body {background-color: rgba(219,242,185,0.3); margin:auto; padding:auto; 
		position: absolute;  top: 50%; left: 50%; transform: translate(-50%, -50%);}
	h3 {text-align:center;}
	button {text-align:center;}
</style>
</head>
<body>
<h3>열무마켓 메인 홈페이지</h3>
<c:choose>
	<c:when test="${uid == null}">
		<button type="button" onclick="location.href='/user/join'">회원가입</button>&nbsp; 
			<button type="button" onclick="location.href='/user/login'">로그인</button>&nbsp;
	</c:when>
		
	<c:when test="${uid != null}">	
		<c:if test="${uid == 'admin'}">
			[관리자 계정입니다] &nbsp;
			<button type="button" onclick="logout()">로그아웃</button>
			<button type="button" onclick="location.href='/user/list'">회원 관리하기</button>
		</c:if>
			
		<c:if test="${uid != 'admin'}">
			[${uid}님 환영합니다] &nbsp;
			<button type="button" onclick="logout()">로그아웃</button>
			<button type="button" onclick="location.href='/user/myinfo'">마이페이지</button>
			<button type="button" onclick="location.href='/bbs/interest/show'">찜 목록</button>
		</c:if>
	</c:when>
</c:choose>
	<button type="button" onclick="location.href='/bbs/list/page/1'">게시판 보기</button>
</body>
</html>