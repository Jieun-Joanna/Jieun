<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓 : 회원정보 수정하기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	function update(){
		var name = $('#name').val();
		var phone = $('#phone').val();
		var email = $('#email').val();
		
		if(name==""){
			alert('이름을 입력하세요.');
			return false;
		}
		
		if(phone==""){
			alert('전화번호를 입력하세요.');
			return false;
		}
		
		if(email==""){
			alert('이메일 주소를 입력하세요.');
			return false;
		}

		var serData = $('#update_form').serialize();
		$.ajax({
			url:'/user/update',
			method:'post',
			cache:false,
			data:serData,
			dataType:'json',
			success:function(res){
				alert(res.updated? "회원정보 수정 성공" : "회원정보 수정 실패!");
				location.href='/user/myinfo';
			},
			err:function(xhr,status,err){
				alert('에러: '+err);
			}
		});
		return false;
	}
	
	function updatePwd(){
		var pwd = $('#pwd').val();
		var repwd = $('#repwd').val();
		
		/* 비밀번호 설정시 정규식 이용해서 적용하기(회원가입이랑 동일하게 해서 복붙하자)*/
		var pwdCheck = /^[a-zA-Z0-9]{8,16}$/;
		// if문
		
		/* 유효성검사로 pwd와 repwd가 일치하는지 검사하기 */
		if(pwd!=repwd){
			alert('새 비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
			return;
		}
		
		if(!confirm('비밀번호를 변경하시겠습니까?')){
			return;
		}
		
		var obj = {};
		obj.pwd = pwd;
		$.ajax({
			url:'/user/update/pwd',
			method:'post',
			cache:false,
			data:obj,
			dataType:'json',
			success:function(res){
				if(res.pwdupdated){
					alert("비밀번호 수정 성공");
					location.href='/user/myinfo';
				} else {
					alert("비밀번호 수정 실패!");
				}				
			},
			err:function(xhr,status,err){
				alert('에러: '+err);
			}
		});
	}
	
</script>
<style>
	body {position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);}
	h3 {text-align:center;}
	table{border:1px solid black; padding:0.5em; width:400px; margin-left: auto; margin-right: auto;
		border-spacing: 0; border-collapse: collapse;}
	th {border:1px solid black; background-color: #eee;}
	th:nth-child(2){width:20em;}
	td {border:1px solid black;}
	td{padding:0.2em 0.5em;}
</style>
</head>
<body>
<h3>회원정보 수정하기</h3>
<form id="update_form" onsubmit="return update();">
<table>
<tr>
	<th>아이디</th>
	<td>${uid}</td>
</tr>
<tr>
	<th>이름</th>
	<td><input type="text" id="name" name="name" value="${user.name}"></td>
</tr>
<tr>
	<th>새 비밀번호</th>
	<td><input type="password" id="pwd" name="pwd"></td>
</tr>
<tr>
	<th>새 비밀번호 재확인</th>
	<td><input type="password" id="repwd" name="repwd"> <button type="button" onclick="updatePwd();">변경</button></td>
</tr>
<tr>
	<th>휴대폰번호</th>
	<td><input type="text" id="phone" name="phone" value="${user.phone}"></td>
</tr>
<tr>
	<th>이메일 주소</th>
	<td><input type="text" id="email" name="email" value="${user.email}"></td>
</tr>
</table>
<p>
	<div><button type="submit">수정하기</button> <button type="reset">취소하기</button> 
		<button type="button" onclick="location.href='/radish'">홈으로 가기</button></div>
</form>
</body>
</html>