package com.example.demo.dao;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.mapper.R_UserMapper;
import com.example.demo.vo.R_UserVO;

@Repository
public class R_UserDAO {
	
	@Autowired
	private R_UserMapper userMapper;
	
	public int insert(R_UserVO user) {
		return userMapper.insertUser(user);
	}
	
	public int idCheck(String uid) {
		return userMapper.idCheck(uid);
	}
	
	public int addAndGetKey(R_UserVO user) {
		return userMapper.addAndGetKey(user);
	}
	
	public R_UserVO login(R_UserVO user) {
		return userMapper.loginByIdPwd(user);
	}

	public R_UserVO getUserById(String uid) {
		return userMapper.getUserById(uid);
	}

	public List<R_UserVO> getUserList() {
		return userMapper.getUserList();
	}
	
	public int updateUser(R_UserVO user) {
		return userMapper.updateUser(user);
	}
	
	public int updatePwd(R_UserVO user) {
		return userMapper.updatePwd(user);
	}

	public int deleteUser(String uid) {
		return userMapper.deleteUser(uid);
	}
	
	
}
