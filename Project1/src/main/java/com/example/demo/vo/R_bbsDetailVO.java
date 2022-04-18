package com.example.demo.vo;

import java.sql.Date;

public class R_bbsDetailVO {
	private int num;
	private String title;
	private String author;
	private java.sql.Date wdate;
	private int hitcount;
	private String content;
	
	private int inum;
	private int bnum;
	private long filesize;
	private String filename;
	
	public R_bbsDetailVO() {}
	public R_bbsDetailVO(int num, String title, String author, Date wdate, int hitcount, String content, int inum,
			int bnum, long filesize, String filename) {
		super();
		this.num = num;
		this.title = title;
		this.author = author;
		this.wdate = wdate;
		this.hitcount = hitcount;
		this.content = content;
		this.inum = inum;
		this.bnum = bnum;
		this.filesize = filesize;
		this.filename = filename;
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
	public int getInum() {
		return inum;
	}
	public void setInum(int inum) {
		this.inum = inum;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}

	
	
}
