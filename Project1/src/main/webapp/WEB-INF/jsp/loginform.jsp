<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓 : 로그인</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	if('${msg}'){
		alert('${msg}');
	}
</script>
<script>
	function login(){
		var uid = $('#uid').val();
		var pwd = $('#pwd').val();
		if(uid=="" || pwd==""){
			alert('아이디와 비밀번호를 입력하세요');
			return false;
		}
		
		var formdata = $('#login_form').serialize();
		$.ajax({
			url:'/user/login',
			method:'post',
			cache:false,
			data:formdata,
			dataType:'json',
			success:function(res){
				if(res.login){
					alert('로그인 성공');
					location.href='/radish';
				} else{
					alert('로그인 실패!');	
				}			
			},
			err:function(xhr,status,err){
				alert('에러: '+err);
			}
		});
		
		return false;
	}
</script>
<style>
	body {position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);}
	h3 {text-align:center;}
	form {border:1px solid black; border-radius: 5px; width:300px; padding:10px; 
		margin-left: auto; margin-right: auto;}
</style>
</head>
<body>
<h3>열무마켓 로그인 페이지</h3>
<form id="login_form" onsubmit="return login();">
	<div><label>아이디: <input type="text" id="uid" name="uid"></label></div>
	<div><label>비밀번호: <input type="password" id="pwd" name="pwd"></label></div>
<p>
	<div><button type="submit">로그인</button> <button type="reset">취소</button></div>
<p>
	<div>아직 회원이 아니신가요? <button type="button" onclick="location.href='/user/join'">회원가입</button></div>
</form>
</body>
</html>