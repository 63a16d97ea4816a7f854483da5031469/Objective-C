package com.backend.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.ForeignKey;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "post")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Post implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="postid")
	private String postid;

	@ForeignKey(name = "email")
	@Column(name="userid")
	private String userid;
	
	@Column(name="text")
	private String text;
	
	@Column(name="time")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date time;
	
	@Column(name="images")
	private String images;
	
	@Column(name="comments")
	private int comments;
	
	
	@Column(name="likes")
	private int likes;
	
	public void setPostid(String id){
		this.postid=id;
	}
	public String getPostid(){	
		return this.postid;		
	}
	public void setUserid(String userid){
		this.userid=userid;
	}
	public String getUserid(){
		return this.userid;
	}
	public void setText(String text){
		this.text=text;
	}
	public String getText(){
		return this.text;
	}
	
	
	public void setTime(Date time){
		this.time=time;
	}
	public Date getTime(){
		return this.time;
	}
	
	
	public void setImages(String imagesString){
		this.images=imagesString;
	}
	
	public String getImages(){
		return this.images;
	}
	
	
	public void setComments(int a){
		this.comments=a;
		
	}
	
	public int getComments(){
		
		return this.comments;
		
	}
	
	public void setLike(int i){
		this.likes=i;
	}
	
	public int getLikes(){
		return this.likes;
	}
	
	
	
}
