package com.example.demo.util;

import java.util.*;

import com.example.demo.vo.R_bbsVO;

public class R_Interest {
	private List<R_bbsVO> list = new ArrayList<>();
	
	public boolean add(R_bbsVO bbs) {
		for(int i=0; i<list.size(); i++) {
			R_bbsVO ibbs = list.get(i);
			// 동일 게시글이 있을 경우 목록에 담기지 않게 하기
		}
		list.add(bbs);
		return true;
	}
	
	public List<R_bbsVO> getList(){
		return list;
	}
	
	
	
}
