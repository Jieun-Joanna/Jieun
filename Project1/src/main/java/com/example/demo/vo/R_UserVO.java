package com.example.demo.vo;

public class R_UserVO {
	private String uid;
	private String pwd;
	private String name;
	private String phone;
	private String email;
	
	public R_UserVO() {}
	public R_UserVO(String uid, String pwd, String name, String phone, String email) {
		super();
		setUid(uid);
		setPwd(pwd);
		setName(name);
		setPhone(phone);
		setEmail(email);
	}

	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	
}
