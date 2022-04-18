package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

import com.example.demo.vo.R_UserVO;

@Mapper
public interface R_UserMapper {

	int insertUser(R_UserVO user);
	int idCheck(String uid);
	int addAndGetKey(R_UserVO user);
	R_UserVO loginByIdPwd(R_UserVO user);
	R_UserVO getUserById(String uid);
	List<R_UserVO> getUserList();
	int updateUser(R_UserVO user);
	int updatePwd(R_UserVO user);
	int deleteUser(String uid);
	
}
