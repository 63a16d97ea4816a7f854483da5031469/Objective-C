package com.backend.controller;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.hibernate.ObjectNotFoundException;

import com.backend.dao.UserDataDaoImpl;
import com.backend.model.DisplayPost;
import com.backend.model.Post;
import com.backend.model.Status;
import com.backend.model.User;
import com.backend.services.PostDataServicesImpl;
import com.backend.util.StringUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/api/post")     //Maybe we can modify this one
public class PostRestController {

	@Autowired
	PostDataServicesImpl postdataServices;
	
	@Autowired
	UserDataDaoImpl userdataServices;

	static final Logger logger = Logger.getLogger(PostRestController.class);

	// test link: http://localhost:8080/backend/api/task/getParams
	@RequestMapping(value = "/getParams", method = { RequestMethod.POST,
			RequestMethod.GET })
	public @ResponseBody
	void getParams(HttpServletRequest request) {

		Map<String, String[]> parameters = request.getParameterMap();
		
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if (!StringUtil.isNullandEmpty(username)) {
			System.out.println(username);
		}
		if (!StringUtil.isNullandEmpty(password)) {
			System.out.println(password);
		}

		for (String key : parameters.keySet()) {
			// System.out.println(key);
			String[] vals = parameters.get(key);
			for (String val : vals) {
				if (!val.equals("")) {
					System.out.println(key + " -> " + val);
				} else {
					System.out.println(key + "-> is empty");
				}
			}
		}
	}


	
	// create new employee
	@RequestMapping(value = "/create", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody
	Status addPost(@RequestBody Post post) {
		System.out.println("access method");
		
		try {
			if(post==null){
				System.out.println("null");
			}
			else {
				System.out.println(post.getPostid());
			}
			post.setPostid(StringUtil.genRandomPostId());
			System.out.println(post.getText());
//			Date date=new Date();
//			post.setTime(date);
			postdataServices.addEntity(post);
			return new Status(1, "Post added Successfully !");
		} catch (Exception e) {			
			e.printStackTrace();
			return new Status(0, e.toString());
		}

	}

	// get the entity in DB by using id number
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public @ResponseBody
	Post getPost(@PathVariable("id") String postid) {
		Post post=null;
		
		try {
			post = postdataServices.getEntityById(postid);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}

	// list all the entities in DB
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public @ResponseBody
	List<DisplayPost> getPosts() {

		List<Post> postList = null;
		List<DisplayPost> display=new ArrayList<DisplayPost>();
		try {
			postList = postdataServices.getEntityList();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		for(Post post:postList){
			try {
				//wrap all information one display post need it(all we need to show off in the mobile screen)
				//from usr table:
				User user=userdataServices.getEntityById(post.getUserid());
				DisplayPost displayPost=new DisplayPost();
				displayPost.usernickname=user.getNickname();
				displayPost.gender=user.getGender();
				displayPost.avatar=user.getAvatar();
				displayPost.userid=user.getEmail();		
				//from post table
				displayPost.text=post.getText();
				displayPost.images=post.getImages();
				displayPost.date=post.getTime();
				displayPost.postid=post.getPostid();
				displayPost.commentnumber=post.getComments();
				displayPost.likes=post.getLikes();
				display.add(displayPost);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}

		return display;
	}

	// delete the item by id
	@RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
	public @ResponseBody
	Status deletePost(@PathVariable("id") String postId) {

		try {
			postdataServices.deleteEntity(postId);
			return new Status(1, "Post deleted Successfully !");
		} catch (ObjectNotFoundException e) {

			return new Status(0, "Object is not found!");
		} catch (Exception e) {
			return new Status(0, e.toString());
		}

	}
	
	
	// update the item by id
	@RequestMapping(value = "update/{id}", method = RequestMethod.POST,  consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody
	Status updateEmployee(@RequestBody Post post) {

		try {
			postdataServices.updateEntity(post);
			return new Status(1, "Employee updated Successfully !");
		} catch (ObjectNotFoundException e) {

			return new Status(0, "Object is not found!");
		} catch (Exception e) {
			return new Status(0, e.toString());
		}

	}
	
	
//------------------------------------------------------------------------------------------------------------------------
	//Write the real methods below:
	
	
	
	
}
