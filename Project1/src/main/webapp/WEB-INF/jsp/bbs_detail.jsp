<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>열무마켓 : 게시글 상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	function del(num){
		if(!confirm('정말로 삭제하시겠어요?')) return;
		var obj = {};
		obj.num = num;
		$.ajax({
			url:'/bbs/delete/'+num,
			data:obj,
			dataType:'json',
			success:function(res){
				alert(res.deleted ? "삭제 성공" : "삭제 실패!");
				location.href='/bbs/list/page/1';
			},
			err:function(xhr,status,err){
				alert('에러: '+err);
			}
		});
	}
	
	function soldout(num){		
		if(confirm('거래완료로 설정하시겠습니까?')){
			location.href='/bbs/soldout/'+num;
		}
		return;
	}
	
	function toIntTable(){
		var serData = $('#like_form').serialize();
		$.ajax({
			url:'/bbs/interest/add',
			method:'post',
			cache:false,
			data:serData,
			dataType:'json',
			success:function(res){
				if(res.saved){
					if(confirm('찜 목록에 저장 성공! 찜 목록으로 이동하시겠습니까?')){
						location.href='/bbs/interest/show';
					} else {
						return;
					}
				} else {
					alert("찜 목록에 저장 실패!");
					return false;
				}			
			},
			err:function(xhr,status,err){
				alert('에러: '+err);
			}
		});
		return false;
	}		
	
	function isLogin(){
		if(!confirm('로그인 후에 이용 가능합니다. 로그인 하시겠습니까?')){
			return;
		}
		location.href='/user/login';
	}
	
</script>
<style>
	body {position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);}
	h3 {text-align:center;}
	table{border:1px solid black; padding:0.5em; margin-left: auto; margin-right: auto;
		border-spacing: 0; border-collapse: collapse;}
	th {border:1px solid black; background-color: #eee; width:5em;}
	td {border:1px solid black;}
	td{padding:0.2em 0.5em;}
	img {max-width:300px; max-height:300px;}
</style>
</head>
<body>
<h3>게시글 상세보기</h3>
<table>
<tr>
	<th>글번호</th>
	<td>${detail.num}</td>
</tr>
<tr>
	<th>글제목</th>
	<td>${detail.title}</td>
</tr>
<tr>
	<th>작성자</th>
	<td>${detail.author}</td>
</tr>
<tr>
	<th>작성일</th>
	<td>${detail.wdate}</td>
</tr>
<tr>
	<th>조회수</th>
	<td>${detail.hitcount}</td>
</tr>
<tr>
	<th>글내용</th>
	<td>${detail.content}<br>
		<c:forEach var="bd" items="${bdlist}">
			<img src="/upload/${bd.filename}">
		</c:forEach></td>
</tr>

</table>
<p>
<form id="like_form" onsubmit="return toIntTable();">
<c:choose>
	<c:when test="${uid != 'admin'}">
		<c:if test="${detail.author == uid}">
			<button type="button" onclick="location.href='/bbs/update/${detail.num}'">수정하기</button>
			<button type="button" onclick="del(${detail.num})">삭제하기</button>
			<button type="button" onclick="location.href='/chat/seller'">문의 응답하기</button>
			<button type="button" onclick="soldout(${detail.num}); this.onclick=null;">거래완료</button>
			<button type="button" onclick="location.href='/bbs/list/page/1'">목록</button>
		</c:if>
		
		<c:if test="${detail.author != uid}">
			<input type="hidden" name="num" value="${detail.num}">
			<input type="hidden" name="title" value="${detail.title}">
			<input type="hidden" name="author" id="author" value="${detail.author}">
			<input type="hidden" name="wdate" value="${detail.wdate}">
			<c:choose>
				<c:when test="${uid != null}">
					<button type="button" onclick="location.href='/chat?author=${detail.author}'">판매자와 거래하기</button>
					<button type="submit">찜하기</button>
				</c:when>
				<c:otherwise>
					<button type="button" onclick="isLogin()">판매자와 거래하기</button>
					<button type="button" onclick="isLogin()">찜하기</button>
				</c:otherwise>
			</c:choose>
			<button type="button" onclick="location.href=document.referrer;">목록</button>
		</c:if>
	</c:when>
	<c:otherwise>
		<button type="button" onclick="location.href='/bbs/update/${detail.num}'">글 수정</button>
		<button type="button" onclick="del(${detail.num})">글 삭제</button>
		<button type="button" onclick="location.href='/bbs/list/page/1'">목록</button>
	</c:otherwise>
</c:choose>
</form>
</body>
</html>