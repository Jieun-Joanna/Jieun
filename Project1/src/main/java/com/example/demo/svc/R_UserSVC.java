package com.example.demo.svc;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.R_UserDAO;
import com.example.demo.vo.R_UserVO;

@Service
public class R_UserSVC {
	@Autowired
	private HttpSession session;
	
	@Autowired
	private R_UserDAO dao;
	
	public boolean login(R_UserVO user) {
		R_UserVO u = dao.login(user);
		if(u!=null) {
			session.setAttribute("uid", u.getUid());
			return true;
		} else {
			return false;
		}
	}
	
	public boolean isLogin() {
		return (session.getAttribute("uid")!=null);
	}

	public R_UserVO getMyInfo() {
		String uid = (String)session.getAttribute("uid");
		return dao.getUserById(uid);
	}
	
	public boolean checkPwd(String pwd) {
		String uid = (String)session.getAttribute("uid");
		R_UserVO vo = dao.getUserById(uid);
		return vo.getPwd().equals(pwd);
	}
	
	public int updatePwd(R_UserVO user) {
		String uid = (String)session.getAttribute("uid");
		user.setUid(uid);
		return dao.updatePwd(user);
	}
	
	public int updateUser(R_UserVO user) {
		String uid = (String)session.getAttribute("uid");
		user.setUid(uid);
		return dao.updateUser(user);
	}
	
	public int deleteUser() {
		String uid = (String)session.getAttribute("uid");
		return dao.deleteUser(uid);
	}
	
}
