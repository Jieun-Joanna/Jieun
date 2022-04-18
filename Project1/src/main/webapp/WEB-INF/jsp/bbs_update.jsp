<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓 : 게시글 수정하기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
function update(){
	var num = $('#num').val();
	var title = $('#title').val();
	var content = $('#content').val();
	
	if(title=="" || content==""){
		alert('수정사항을 입력하세요.');
		return false;
	}
	
	if(!confirm('입력된 사항으로 변경하시겠어요?')){
		return false;
	}
	
	var serData = $('#update_form').serialize();
	$.ajax({
		url:'/bbs/update',
		method:'post',
		cache:false,
		data:serData,
		dataType:'json',
		success:function(res){
			if(res.updated){
				alert("게시글 수정 성공");
				location.href='/bbs/detail/'+num;
			} else{
				alert("게시글 수정 실패!");
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
	form {border:1px solid black; border-radius: 5px; width:400px; padding:10px; 
		margin-left: auto; margin-right: auto;}
	div {font-weight: bolder;}
</style>
</head>
<body>
<h3>게시글 수정하기</h3>
<form id="update_form" onsubmit="return update();">
	<div>글번호: ${bbs.num} <input type="hidden" id="num" name="num" value="${bbs.num}"></div>
	<div>글제목: <input type="text" id="title" name="title" value="${bbs.title}" style="width:250px"></div>
	<div>작성자: ${bbs.author}</div>
	<div>작성일: ${bbs.wdate}</div>
	<div>조회수: ${bbs.hitcount}</div>
	<div>글내용: <textarea id="content" name="content" rows="10" cols="40">${bbs.content}</textarea></div>
<p>
	<div><button type="submit">수정하기</button> <button type="reset">취소하기</button>
		<button type="button" onclick="location.href='/bbs/list/page/1'">목록</button></div>
</form>
</body>
</html>