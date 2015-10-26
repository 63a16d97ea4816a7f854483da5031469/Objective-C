package com.backend.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonAutoDetect;
import org.codehaus.jackson.annotate.JsonProperty;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@Entity
@Table(name = "user")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})

public class User implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="email")
	private String email;
	
	
	@Column(name="nickname")
	private String nickname;
	
	@Column(name="avatar")
	private String avatar;
	
	@Column(name="date")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date date;
	
	@Column(name="gender")
	private String gender;
	
	@Column(name="authenticated")
	private String authenticated;
	
	
	
	public void setEmail(String s){
		email=s;
	}
	
	
	@JsonProperty
	public String getEmail(){
		return email;
	}
	
	
	public void setNickname(String s){
		nickname=s;
	}
	
	
	
	@JsonProperty
	public String getNickname(){
		return nickname;
	}

	public void setAvatar(String s){
		avatar=s;
	}
	
	
	
	@JsonProperty
	public String getAvatar(){
		return avatar;
	}
	
	public void setDate(Date d){
		date=d;
	}
	
	
	
	@JsonProperty
	public Date getDate(){
		return date;
	}
	
	public void setGender(String s){
		gender=s;
	}
	
	
	@JsonProperty
	public String getGender(){
		return gender;
	}
	
	
	public void setAuthenticated(String s){
		authenticated=s;
	}
	
	
	
	@JsonProperty
	public String getAuthenticated(){
		return authenticated;
	}
	
	
}
