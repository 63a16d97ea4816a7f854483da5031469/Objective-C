package com.backend.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.amazonaws.services.elastictranscoder.model.VideoParameters;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;




@Entity
@Table(name = "credentials")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Credentials {
	
	@Id
	@Column(name="userid")
	private String userid;
	
	
	@Column(name="hashcode")
	private String hashcode;
	
	@Column(name="apikey")
	private String apikey;
	
	@Column(name="validdate")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date validdate;
	
	
	@Column(name="salt")
	private String salt;
	
	
	public void setUserId(String id){
		this.userid=id;
	}
	
	public String getUserId(){
		return this.userid;
	}
	
	public void setHashCode(String code){
		this.hashcode=code;
	}
	
	public String getHashCode(){
		return this.hashcode;
	}
	
	public void setApiKey(String s){
		this.apikey=s;
	}
	public String getApiKey(){
		return this.apikey;
	}
	
	public void setValidDate(Date date){
		this.validdate=date;
	}
	public Date getValidDate(){
		return this.validdate;
	}
	
	public void setSalt(String s){
		this.salt=s;
	}
	
	public String getSalt(){
		return this.salt;
	}

}
