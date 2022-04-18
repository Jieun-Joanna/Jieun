<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓 회원가입 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	function join(){	
		var uid = $('#uid').val();
		var pwd = $('#pwd').val();
		var repwd = $('#repwd').val();
		var name = $('#name').val();
		var phone = $('#phone').val();
		var email = $('#email').val();
		
		if(uid==""){
			alert('아이디를 입력하세요.');
			return false;
		}
		
		// 아이디: 영문 대소문자, 숫자 포함 4~12자
		var uidCheck = /^[a-zA-Z0-9]{4,12}$/;
		if(!(uidCheck.test(uid))){
			alert('아이디는 4~12자리의 영문 대소문자와 숫자로만 입력 가능합니다.');
			return false;
		}
		
		if(pwd==""){
			alert('비밀번호를 입력하세요.');
			return false;
		}
		
		// 비밀번호: 영문 대소문자, 숫자, 특수문자 포함 8~16자 (?=.*[!@#$%^&*-_=+])
		var pwdCheck = /^[a-zA-Z0-9]{8,16}$/;
		if(!(pwdCheck.test(pwd))){
			alert('비밀번호는 8~16자리의 영문 대소문자와 숫자로만 입력 가능합니다.');
			return false;
		}
		
		if(repwd==""){
			alert('비밀번호 재확인을 입력하세요.');
			return false;
		}
		
		if(pwd!=repwd){
			alert('비밀번호가 일치하지 않습니다. 다시 확인 해주세요.'); 
			return false;
		}
		
		if(name==""){
			alert('이름을 입력하세요.');
			return false;
		}
		
		if(phone==""){
			alert('전화번호를 입력하세요.');
			return false;
		}
		/* 전화번호에 숫자만 입력하는 정규식
		var phoneCheck = /^[0-9]$/;
		if(!(phoneCheck.test(phone))){
			alert('전화번호는 숫자만 입력 가능합니다.');
			return false;
		}*/
		
		/*var numCheck = /^\d{10,11}$/;
		if(!(numCheck.test(phone))){
			alert('전화번호는 10~11자리 숫자로만 입력 가능합니다.');
			return false;
		}*/
		
		if(email==""){
			alert('이메일 주소를 입력하세요.');
			return false;
		}
		
		var serData = $('#join_form').serialize();
		$.ajax({
			url:'/user/join',
			method:'post',
			cache:false,
			data:serData,
			dataType:'json',
			success:function(res){
				alert(res.joined? "회원가입 성공" : "회원가입 실패");
				location.href='/user/login';
			},
			err:function(xhr,status,err){
				alert('에러: '+err);
			}
		});
		return false;
	}
</script>
<script>
	/* 아이디 중복 검사 */
	function checkid(){
		var uid = $('#uid').val();
				
		var obj = {};
		obj.uid = uid;
		$.ajax({
			url:'/user/idcheck',
			method:'post',
			cache:false,
			data:obj,
			dataType:'json',
			success:function(res){
				if(res.existed){
					alert('이미 존재하는 아이디입니다. 다른 아이디를 사용해주세요.');
					$('#uid').val('');
				} else {
					alert('사용 가능한 아이디입니다.');
				}
			},
			err:function(xhr,status,err){
				alert('에러: '+err);
			}
		});
	}
</script>
<style>
	body {margin:auto; padding:auto; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);}
	h3 {text-align:center;}
	form {border:1px solid black; border-radius: 5px; width:300px; padding:10px; 
		margin-left: auto; margin-right: auto;}
	input {width:200px;}
	div {font-weight: bolder;}
	span {font-size:small; color: red;}
</style>
</head>
<body>
<h3>회원가입</h3>
<form id="join_form" onsubmit="return join();">
	<div>아이디 <br><input class="id_input" type="text" id="uid" name="uid"> &nbsp;
		<button type="button" onclick="checkid()">중복검사</button></div>
		<span>*영문 대소문자, 숫자 포함 4~12자</span>
	<div>비밀번호 <br><input type="password" id="pwd" name="pwd"></div>
		<span>*영문 대소문자, 숫자, 특수문자 포함 8~16자</span>
	<div>비밀번호 재확인 <br><input type="password" id="repwd" name="repwd"></div>
	<div>이름 <br><input type="text" id="name" name="name"></div>
	<div>전화번호 <br><input type="text" id="phone" name="phone" placeholder="(-)없이 번호만 입력"></div>
	<div>이메일 주소 <br><input type="text" id="email" name="email"></div>
<p>
	<button type="submit">가입하기</button>
</form>
</body>
</html>