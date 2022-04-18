<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹소켓 테스트 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">
    <%
    	String role = null;
    	String seller = (String) session.getAttribute("seller");
    	if(seller==null) role = "seller";
    	else role = "buyer";
    %>
	var role = "<%=role%>";
	var msgToSend = "";
	
	var g_webSocket = null;
	window.onload = function() {
		host = "152.70.39.150";	// 오라클에 올려서 사용할 경우
		//host = "localhost:8080";	// 개발환경에서는 이걸 사용!
	    g_webSocket = new WebSocket("ws://"+host+"/websocket");
	    
	    /* 웹소켓 접속 성공시 실행 */
	    g_webSocket.onopen = function(message) {
	        addLineToChatBox("[열무마켓] 실시간 거래하기 채팅방에 오신 것을 환영합니다!");
	    };
	    
	    
	    /* 웹소켓 서버로부터 메시지 수신시 실행 */
	    g_webSocket.onmessage = function(message) {
	    	try {
	    		var obj = JSON.parse(message.data);	// message.data : message를 문자열로 만들어주기
	    		
	    		if(role=='seller'){	        	
		        	$('#to').val(obj.from);
		        	addLineToChatBox(obj.from + '님 => ' + obj.to + '님: ' + obj.msg);
		    	} else{
		    		addLineToChatBox(obj.from+'님: '+obj.msg);
		    	}
	    	} catch (e) {
	    		addLineToChatBox(message.data);
	    	}
  
	    };
	
	    /* 웹소켓 이용자가 연결을 해제하는 경우 실행 */
	    g_webSocket.onclose = function(message) {
	        addLineToChatBox("Server is disconnected.");
	    };
	
	    /* 웹소켓 에러 발생시 실행 */
	    g_webSocket.onerror = function(message) {
	        addLineToChatBox("Error!");
	    };
	}

	/* 채팅 메시지를 화면에 표시 */
	function addLineToChatBox(_line) {
	    if (_line == null) {
	        _line = "";
	    }
	    
	    var chatBoxArea = document.getElementById("chatBoxArea");
	    chatBoxArea.value += _line + "\n";
	    chatBoxArea.scrollTop = chatBoxArea.scrollHeight;
	}

	/* Send 버튼 클릭하면 서버로 메시지 전송 */
	function sendButton_onclick() {		
	    var inputMsgBox = document.getElementById("inputMsgBox");
	    if (inputMsgBox == null || inputMsgBox.value == null || inputMsgBox.value.length == 0) {
	        return false;
	    }
	    
	    var chatBoxArea = document.getElementById("chatBoxArea");
	    
	    if (g_webSocket == null || g_webSocket.readyState == 3) {
	        chatBoxArea.value += "Server is disconnected.\n";
	        return false;
	    }
	    
	    if(role=='buyer'){
		    var obj = {};
			obj.from=$('#from').val();
			obj.to=$('#to').val();
			obj.msg=$('#inputMsgBox').val();
			
			msgToSend = JSON.stringify(obj);
	    } else if(role=='seller') { 	
		    var obj = {};
			obj.from = '${uid}';		
			obj.to = $('#to').val();
			obj.msg = $('#inputMsgBox').val();
			
			msgToSend = JSON.stringify(obj);
	    }
		
	    // 서버로 메시지 전송
	    g_webSocket.send(msgToSend);
	    inputMsgBox.value = "";
	    inputMsgBox.focus();
	    
	    return true;
	}

	/* Disconnect 버튼 클릭하는 경우 호출 */
	function disconnectButton_onclick() {
	    if (g_webSocket != null) {
	        g_webSocket.close();    
	    }
	}

	/* inputMsgBox 키 입력하는 경우 호출 */
	function inputMsgBox_onkeypress() {
	    if (event == null) {
	        return false;
	    }
	    
	    // 엔터키 누를 경우 서버로 메시지 전송
	    var keyCode = event.keyCode || event.which;
	    if (keyCode == 13) {
	        sendButton_onclick();
	    }  
	}
	
    function outOfChat(){
    	if(confirm('정말로 채팅방을 나가시겠습니까?')) {
    		location.href='javascript:history.back();'
    	} else {
    		return;
    	}
    }
</script>
</head>
<body>
	<input type="hidden" id="from" value="${uid}">
	<input type="hidden" id="to" value="${seller}">
    <input id="inputMsgBox" style="width: 250px;" type="text" onkeypress="inputMsgBox_onkeypress()">
    <button id="sendButton" type="button" onclick="sendButton_onclick()">Send</button>
    <button id="disconnectButton" type="button" onclick="disconnectButton_onclick()">Disconnect</button>
    <br/>
    <textarea id="chatBoxArea" style="width: 100%;" rows="10" cols="50" readonly="readonly"></textarea>
    <p>
    <button type="button" onclick="outOfChat();">채팅 나가기</button>
</body>
</html>