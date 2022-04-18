package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class R_MainController {
	
	@GetMapping("/radish")
	public String mainPage() {
		return "mainpage";
	}
	
}
