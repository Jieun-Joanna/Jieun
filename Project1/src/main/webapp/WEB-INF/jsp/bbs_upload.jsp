<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓 게시판 : 글 쓰기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	function upload(){
		if($('#title').val()=='' || $('#content').val()==''){
			alert('필수항목을 입력해주세요');
			return false;
		}
		var form = $('#upload_form')[0];
		var formData = new FormData(form);
		$.ajax({
			url:'/bbs/upload',
			method:'post',
			enctype:'multipart/form-data',
			data:formData,
			dataType:'json',
			processData:false,
			contentType:false,
			cache:false,
			timeout:000000,
			success:function(res){
				alert(res.uploaded? "글 저장 성공" : "글 저장 실패!");
				location.href='/bbs/list/page/1';
			},
			error:function(xhr,status,err){
				alert('에러: '+err);
			}
		});
		return false;
	}
	
</script>
<style>
	body {position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);}
	h3 {text-align:center;}
	form {border:1px solid black; border-radius: 5px; width:400px; padding:10px; 
		margin-left: auto; margin-right: auto;}
	div {font-weight: bolder;}
</style>
</head>
<body>
<h3>중고물품 거래 글 올리기</h3>
<form id="upload_form" onsubmit="return upload();">
	<div><label>게시글 제목: <input type = "text" id="title" name="title" style="width:250px"></label></div>
	<div><label>글 내용: <textarea id="content" name="content" rows="10" cols="40" placeholder="입력하세요"></textarea></label></div>
	<div>사진 첨부하기 <input type="file" id="img_file" name="img_file" multiple="multiple"></div>
<p>
	<div><button type="submit">저장</button> <button type="reset">취소</button> 
		<button type="button" onclick="location.href='/bbs/list/page/1'">목록</button></div>
</form>
</body>
</html>