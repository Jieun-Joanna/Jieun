package com.example.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ChatController {
	
	@GetMapping("/chat")
	public String chat(@RequestParam("author")String author, HttpSession session){
		/* 로그인을 하면 세션에 uid가 저장이 되어있는 상태이므로 여기 controller에서는 채팅을 하고자 하는 판매자의 세션만 저장해주면 된다. */
		session.setAttribute("seller", author);
		return "chat";		// chat.jsp로 연결
	}
     
	@GetMapping("/chat/seller")
	public String chatAsSeller(HttpSession session) {
		return "chat";
	}

}