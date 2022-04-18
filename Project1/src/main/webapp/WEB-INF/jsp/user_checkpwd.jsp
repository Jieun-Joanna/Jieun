<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓 : 비밀번호 확인</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	function checkpwd(){
		var pwd = $('#pwd').val();
		if(pwd==''){
			alert('비밀번호를 입력하세요.');
			return false;
		}
		var obj = {};
		obj.pwd = pwd;
		
		$.ajax({
			url:'/user/checkpwd',
			method:'post',
			cache:false,
			data:obj,
			dataType:'json',
			success:function(res){
				if(res.checked){
					location.href='/user/update';
				} else{
					alert('비밀번호가 일지하지 않습니다. 다시 확인해주세요.');	
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
	form {border:1px solid black; border-radius: 5px; width:600px; padding:10px; 
		margin-left: auto; margin-right: auto;}
</style>
</head>
<body>
<h3>비밀번호 확인하기</h3>
<form onsubmit="return checkpwd();">
<div>[${uid}]님의 정보를 안전하게 보호하기 위하여 비밀번호를 다시 한번 확인합니다.</div>
<table>
<tr>
	<th>아이디</th>
	<td>${uid}</td>
</tr>
<tr>
	<th>비밀번호</th>
	<td><input type="password" id="pwd" name="pwd"></td>
</tr>
</table>
<div><button type="submit">확인</button> <button type="reset">취소</button></div>	
</form>
</body>
</html>