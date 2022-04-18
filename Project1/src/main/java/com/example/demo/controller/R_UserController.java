package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.example.demo.dao.R_UserDAO;
import com.example.demo.svc.R_UserSVC;
import com.example.demo.vo.R_UserVO;

@SessionAttributes("uid")
@Controller
@RequestMapping("/user")
public class R_UserController {

	@Autowired
	private R_UserDAO dao;
	
	@Autowired
	private R_UserSVC svc;
	
	@GetMapping("/join")
	public String joinForm() {
		return "joinform";
	}
	
	@PostMapping("/join")
	@ResponseBody
	public String join(R_UserVO user) {
		return String.format("{\"joined\":%b}", dao.insert(user));
	}
	
	@PostMapping("/idcheck")
	@ResponseBody
	public String idCheck(String uid) {
		boolean existed = dao.idCheck(uid)>0;
		return String.format("{\"existed\":%b}", existed);
	}
	
	/* 관리자용 - 회원 리스트 가져오기 */
	@GetMapping("/list")
	public String list(Model m) {
		m.addAttribute("ulist", dao.getUserList());
		return "user_list";
	}
	
	/* 관리자용 - 회원 강제 탈퇴하기 */
	@GetMapping("/delete/{uid}")
	public String deleteUser(@PathVariable("uid")String uid) {
		dao.deleteUser(uid);
		return "redirect:/user/list";
	}
	
	@GetMapping("/login")
	public String loginForm() {
		return "loginform";
	}
	
	@PostMapping("/login")
	@ResponseBody
	public String login(R_UserVO user, Model m) {
		boolean login = svc.login(user);
		if(login) {
			m.addAttribute("uid", user.getUid());
		}
		return String.format("{\"login\":%b}", login);
	}
	
	@GetMapping("/logout")
	@ResponseBody
	public boolean logout(SessionStatus status) {
		status.setComplete();
		return status.isComplete();
	}
		
	@GetMapping("/myinfo")
	public String getMyInfo(Model m) {
		if(svc.isLogin()) {
			m.addAttribute("mp", svc.getMyInfo());
			return "user_mypage";
		} else {
			m.addAttribute("msg", "로그인 후에 사용 가능합니다. 로그인 페이지로 이동합니다.");
			return "loginform";
		}
	}
	
	@GetMapping("/checkpwd")
	public String checkPwdForm() {
		return "user_checkpwd";
	}
	
	@PostMapping("/checkpwd")
	@ResponseBody
	public String checkPwd(@RequestParam("pwd")String pwd) {
		return String.format("{\"checked\":%b}", svc.checkPwd(pwd));
	}
	
	@GetMapping("/update")
	public String getEditForm(Model m) {
		m.addAttribute("user", svc.getMyInfo());
		return "user_updateform";
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String updateUser(R_UserVO user) {
		return String.format("{\"updated\":%b}", svc.updateUser(user));
	}
	
	@PostMapping("/update/pwd")
	@ResponseBody
	public String updatePwd(R_UserVO user) {
		return String.format("{\"pwdupdated\":%b}", svc.updatePwd(user));
	}
	
	@GetMapping("/delete")
	@ResponseBody
	public String deleteUser(SessionStatus status) {
		boolean deleted = svc.deleteUser()>0;
		status.setComplete();
		return String.format("{\"deleted\":%b}", deleted);
	}
	
	
}
