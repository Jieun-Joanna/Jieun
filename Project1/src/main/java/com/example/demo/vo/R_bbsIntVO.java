package com.example.demo.vo;

public class R_bbsIntVO {
	private int lnum;
	private String uid;
	private int num;
	
	public R_bbsIntVO() {}

	public R_bbsIntVO(int lnum, String uid, int num) {
		super();
		setLnum(lnum);
		setUid(uid);
		setNum(num);
	}

	public int getLnum() {
		return lnum;
	}

	public void setLnum(int lnum) {
		this.lnum = lnum;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
}
