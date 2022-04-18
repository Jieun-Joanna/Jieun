package com.example.demo.dao;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.mapper.R_bbsMapper;
import com.example.demo.vo.R_ImgInfoVO;
import com.example.demo.vo.R_InterestVO;
import com.example.demo.vo.R_bbsDetailVO;
import com.example.demo.vo.R_bbsIntVO;
import com.example.demo.vo.R_bbsVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Repository
public class R_bbsDAO {
	
	@Autowired
	private R_bbsMapper bbsMapper;
	
	public int insertBbs(R_bbsVO bbs) {
		return bbsMapper.insertBbs(bbs);
	}
	
	public int insertAndGetKey(R_bbsVO bbs) {
		return bbsMapper.insertAndGetKey(bbs);
	}
	
	public int insertImgInfo(R_ImgInfoVO vo) {
		return bbsMapper.insertImgInfo(vo);
	}
	
	/*
	public List<R_bbsVO> getBbsListPage(Pageable pageable){
		return bbsMapper.getBbsListPage(pageable);
	}*/
	
	
	public PageInfo<R_bbsVO> getBbsListPage(int pageNum, int pageSize){
		PageHelper.startPage(pageNum, pageSize);	
		PageInfo<R_bbsVO> pageInfo = new PageInfo<>(bbsMapper.getBbsList());
		return pageInfo;
	}
	
	public PageInfo<R_bbsVO> findWithoutNum(int pageNum, int pageSize, String search){
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<R_bbsVO> searchPage = new PageInfo<>(bbsMapper.findWithoutNum(search));
		return searchPage;
	}
	
	public List<R_bbsDetailVO> getBbsImg(int num) {
		return bbsMapper.getBbsImg(num);
	}
	
	public R_bbsVO getBbsDetail(int num) {
		return bbsMapper.getBbsDetail(num);
	}
	
	public int updateTitle(int num) {
		return bbsMapper.updateTitle(num);
	}
	
	public int updateBbs(R_bbsVO bbs) {
		return bbsMapper.updateBbs(bbs);
	}
	
	public int deleteBbs(int num) {
		return bbsMapper.deleteBbs(num);
	}
	
	public int addHitCnt(int num) {
		return bbsMapper.addHitCnt(num);
	}
	
	public int addToInterest(R_bbsIntVO bi) {
		return bbsMapper.addToInterest(bi);
	}
	
	public List<R_InterestVO> getIntList(String uid){
		return bbsMapper.getIntList(uid);
	}
	
	public int deleteInt(int lnum) {
		return bbsMapper.deleteInt(lnum);
	}
	
	public int delIntAll(String uid) {
		return bbsMapper.delIntAll(uid);
	}
	
}
