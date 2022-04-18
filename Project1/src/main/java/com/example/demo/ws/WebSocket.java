package com.example.demo.ws;

import java.util.*;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

@Component
@ServerEndpoint(value="/websocket", configurator=HttpSessionConfig.class)	/* ServerEndpoint : 클라이언트와 웹소켓 서버의 접속점(경유지),  HttpSessionConfig.class : 설정을 위해 만든 클래스의 완전한 정보를 불러와라 */
public class WebSocket 
{
    /* 웹소켓 세션 보관용 ArrayList */
    private static ArrayList<Session> sessionList = new ArrayList<>();
    private static Map<String, Session> map = new HashMap<>();
    private static ArrayList<Map<String, String>> maplist = new ArrayList<>();

    /* 웹소켓 사용자 접속시 호출됨  */
    @OnOpen
    public void handleOpen(Session session, EndpointConfig config) {	/* Configurator에서 설정한 내용은 config에 전달된다 */
        if (session != null) {
            
            /* 웹소켓 서버에 접속시 Configurator에서 저장한 값을 다시 추출하는 예 */
            HttpSession httpSession = (HttpSession) config.getUserProperties().get("httpSession");	/* config.getUserProperties() = map */
            String uid = (String)httpSession.getAttribute("uid");
            String seller = (String)httpSession.getAttribute("seller");
            
            if(uid != null) {
            	map.put(uid, session);
            	System.out.println(uid+"님 접속");
            	Session s = map.get(uid);
            	//System.out.println(s.getId());
            }
            
            if(seller!=null) {
            	//System.out.println("구매자의 상대:"+seller);
            	Session s = map.get(seller);
            	Map<String, String> map = new HashMap<>();
            	map.put(uid, seller);	// 구매자 uid , 판매자 seller
            	maplist.add(map);
            }
                        
            System.out.println("client is connected. userId == [" + uid + "]");
            sessionList.add(session);
            
            /* 웹소켓에 접속한 모든 이용자에게 메시지 전송 */
            sendMessageToAll("--> [" + uid + "] 님이 접속했습니다.");
           }
    }

    /* session을 통해 key 값인 uid를 가져오는 메소드 */
    public String getUidBySession(Session session) {
    	
    	Set<String> set = map.keySet();
        Iterator<String> it = set.iterator();
        while(it.hasNext()) {
        	String key = it.next();		// key == uid
        	Session s = map.get(key);
        	if(s==session) {
        		return key;
        	}
        }
        return null;
    }
    
    /* 웹소켓 이용자로부터 메시지가 전달된 경우 실행됨 */
    @OnMessage
    public String handleMessage(String message, Session session) {
    	
        if (session != null) {
        	try {
        		Map jsonMap = new ObjectMapper().readValue(message, Map.class);
        		
        		System.out.println("발신자: "+jsonMap.get("from"));
        		System.out.println("수신자: "+jsonMap.get("to"));
    			System.out.println("메세지: "+jsonMap.get("msg"));
    			
    			map.get(jsonMap.get("from")).getAsyncRemote().sendText(message);
    			map.get(jsonMap.get("to")).getAsyncRemote().sendText(message);	// msg 받은 사람 화면에 메세지 내용 보여주기
    			
    			System.out.println("message is arrived. userId == [" + jsonMap.get("from") + "] / message == [" + jsonMap.get("msg") + "]");
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
        	          
        }

        return null;
    }

    /* 웹소켓 이용자가 연결을 해제하는 경우 실행됨 */
    @OnClose
    public void handleClose(Session session) {
        if (session != null) {
        	
            System.out.println("client is disconnected. userId == [" + getUidBySession(session) +  "]");
            
            /* 웹소켓에 접속한 모든 이용자에게 메시지 전송 */
            sendMessageToAll("***** [" + getUidBySession(session)  + "] 님이 나갔습니다. *****");
        }
    }

    /* 웹소켓 에러 발생시 실행됨 */
    @OnError
    public void handleError(Throwable t) {
        t.printStackTrace();
    }
    
    
    /* 웹소켓에 접속한 모든 이용자에게 메시지 전송 */
    private boolean sendMessageToAll(String message) {
        if (sessionList == null) {
            return false;
        }

        int sessionCount = sessionList.size();
        if (sessionCount < 1) {
            return false;
        }

        Session singleSession = null;

        for (int i = 0; i < sessionCount; i++) {
            singleSession = sessionList.get(i);		// 웹 소켓 세션, http세션이 아니다!
            if (singleSession == null) {
                continue;
            }

            if (!singleSession.isOpen()) {
                continue;
            }

            singleSession.getAsyncRemote().sendText(message);
        }

        return true;
    }
}