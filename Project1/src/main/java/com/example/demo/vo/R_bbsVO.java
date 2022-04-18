package com.example.demo.vo;

import java.sql.Date;

public class R_bbsVO {
	
	private int num;
	private String title;
	private String author;
	private java.sql.Date wdate;
	private int hitcount;
	private String content;
	
	public R_bbsVO() {}
	public R_bbsVO(int num, String title, String author, Date wdate, int hitcount, String content) {
		super();
		setNum(num);
		setTitle(title);
		setAuthor(author);
		setWdate(wdate);
		setHitcount(hitcount);
		setContent(content);
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public java.sql.Date getWdate() {
		return wdate;
	}
	public void setWdate(java.sql.Date wdate) {
		this.wdate = wdate;
	}
	public int getHitcount() {
		return hitcount;
	}
	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
