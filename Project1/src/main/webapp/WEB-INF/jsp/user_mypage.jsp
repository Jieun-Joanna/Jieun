<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓 : 마이페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	function delete_(){
		if(!confirm('정말로 탈퇴하시겠어요?')) return;
		$.ajax({
			url:'/user/delete',
			method:'get',
			dataType:'json',
			success:function(res){
				alert(res.deleted ? "회원탈퇴 성공" : "회원탈퇴 실패!");
				location.href='/radish';
			},
			err:function(xhr,status,err){
				alert('에러: '+err);
			}
		});
	}
</script>
<style>
	body {margin:auto; padding:auto; position: absolute;  top: 50%; left: 50%; transform: translate(-50%, -50%);}
	h3 {text-align:center;}
	table{border:1px solid black; padding:0.5em; width:400px;
		border-spacing: 0; border-collapse: collapse;}
	th {border:1px solid black; background-color: #eee;}
	th:nth-child(2){width:20em;}
	td {border:1px solid black;}
	td{padding:0.2em 0.5em;}
</style>
</head>
<body>
<h3>열무마켓 마이페이지</h3>
<table>
<tr>
	<th>아이디</th>
	<td>${uid}</td>
</tr>
<tr>
	<th>이름</th>
	<td>${mp.name}</td>
</tr>
<tr>
	<th>휴대폰 번호</th>
	<td>${mp.phone}</td>
</tr>
<tr>
	<th>이메일 주소</th>
	<td>${mp.email}</td>
</tr>
</table>
<p>
	<div><button type="button" onclick="location.href='/user/checkpwd'">회원정보 수정하기</button>
		<button type="button" onclick="delete_();">회원 탈퇴하기</button> 
		<button type="button" onclick="location.href='/radish'">홈으로 가기</button></div>
</body>
</html>