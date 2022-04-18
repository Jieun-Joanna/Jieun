package com.example.demo.vo;

public class R_ImgInfoVO {
	private int inum;
	private int bnum;
	private String filename;
	private long filesize;
	
	public R_ImgInfoVO() {}

	public R_ImgInfoVO(int inum, int bnum, String filename, long filesize) {
		super();
		setInum(inum);
		setBnum(bnum);
		setFilename(filename);
		setFilesize(filesize);
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

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public long getFilesize() {
		return filesize;
	}

	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}

	
}
