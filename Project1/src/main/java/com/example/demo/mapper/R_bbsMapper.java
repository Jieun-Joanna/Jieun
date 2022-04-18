package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.R_ImgInfoVO;
import com.example.demo.vo.R_InterestVO;
import com.example.demo.vo.R_bbsDetailVO;
import com.example.demo.vo.R_bbsIntVO;
import com.example.demo.vo.R_bbsVO;

@Mapper
public interface R_bbsMapper {
	
	int insertBbs(R_bbsVO bbs);
	int insertAndGetKey(R_bbsVO bbs);
	int insertImgInfo(R_ImgInfoVO vo);
		
	List<R_bbsVO> getBbsList();
	List<R_bbsVO> findWithoutNum(String search);
	
	List<R_bbsDetailVO> getBbsImg(int num);
	R_bbsVO getBbsDetail(int num);
	int updateTitle(int num);
	int updateBbs(R_bbsVO bbs);
	int deleteBbs(int num);
	
	int addHitCnt(int num);
	
	int addToInterest(R_bbsIntVO bi);
	List<R_InterestVO> getIntList(String uid);
	int deleteInt(int lnum);
	int delIntAll(String uid);
}
