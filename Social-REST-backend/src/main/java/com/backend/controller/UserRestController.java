package com.backend.controller;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.hibernate.ObjectNotFoundException;

import com.backend.model.Credentials;
import com.backend.model.Status;
import com.backend.model.User;
import com.backend.services.CredentialsServices;
import com.backend.services.UserDataServices;
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
@RequestMapping("/api/user")     //Maybe we can modify this one
public class UserRestController {

	@Autowired
	UserDataServices userdataServices;
	
	
	@Autowired
	CredentialsServices credentialsServices;

	static final Logger logger = Logger.getLogger(UserRestController.class);

	// create new employee
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody
	Status addEmployee(@RequestBody User user) {
		try {
			userdataServices.addEntity(user);
			return new Status(1, "Employee added Successfully !");
		} catch (Exception e) {
			// e.printStackTrace();
			return new Status(0, e.toString());
		}

	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public  @ResponseBody
	String ReisgterUser(HttpServletRequest request){
		
		String username = request.getHeader("username"); 
		String password = request.getHeader("password");
		//request.get
		
		if(username.equals("")||password.equals("")){
			return "failed";
		}
		//use this function to get random string a salt to protect passwords;
		String salt=StringUtil.genRandomPostId();
		String  shaString=StringUtil.getSHA(password+salt);
		String  apikey=StringUtil.getApiKey(password);
		Date date=new Date();
		//SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
		//ft.f 
		Credentials credentials=new Credentials();
		credentials.setUserId(username);
		credentials.setHashCode(shaString);
		credentials.setApiKey(apikey);
		credentials.setValidDate(date);
		credentials.setSalt(salt);
	
		try {
			credentialsServices.addEntity(credentials);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return "success";	
	}
	
	
	@RequestMapping(value = "/authenticate", method = RequestMethod.POST)
	public @ResponseBody
	String AuthenticateUser(HttpServletRequest request){
		
		String username = request.getHeader("username"); 
		String apikey = request.getHeader("apikey");
		//request.get
		System.out.println(request.getHeaderNames());
		
		
		if(username.equals("")||apikey.equals("")){
			return "failed";
		}
		
		
		System.out.println(username);
		System.out.println(apikey);
		Credentials cred=null;
		try {
			cred = credentialsServices.getEntityById(username);
			if(apikey.equals(cred.getApiKey())){
				return "success";
			}	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "failed";
		}
			
		return "failed";		
	}
	
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody
	String Login(HttpServletRequest request){
		
		
        System.out.println("start login");
        

		
		String username = request.getHeader("username"); 
		String password = request.getHeader("password");
		
        System.out.println(username);
        System.out.println(password);
		//request.get
		
		if(username.equals("")||password.equals("")){
			return "failed";
		}
		Credentials credentials=null;
		
		try {
			credentials=credentialsServices.getEntityById(username);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		if(credentials.equals(null)){
			return "failed";
		}
		
		String salt=credentials.getSalt();
		String hashcode=StringUtil.getSHA(password+salt);
		
		if(hashcode.equals(credentials.getHashCode())){
			
			String newApiKey=StringUtil.getApiKey(password);
			
            credentials.setApiKey(newApiKey);
            try {
				credentialsServices.updateEntity(credentials);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("session problem?");
				System.out.println(e.toString());

				
			}
            System.out.println("new api key is: "+newApiKey);
            return newApiKey;
           			
		}
		return "failed";				
	}

	
	
	
	
	
	
	
	

	// get the entity in DB by using id number
	@RequestMapping(value = "/{id:.+}", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody
	User getEmployee(@PathVariable("id") String email) {
		System.out.println(email);

		User user=null;
		try {
			user = userdataServices.getEntityById(email);
			System.out.println(user.getNickname());
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	// list all the entities in DB
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public @ResponseBody
	List<User> getEmployee() {

		List<User> userList = null;
		try {
			userList = userdataServices.getEntityList();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return userList;
	}

	// delete the item by id
	@RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
	public @ResponseBody
	Status deleteEmployee(@PathVariable("id") String email) {

		try {
			userdataServices.deleteEntity(email);
			return new Status(1, "Employee deleted Successfully !");
		} catch (ObjectNotFoundException e) {

			return new Status(0, "Object is not found!");
		} catch (Exception e) {
			return new Status(0, e.toString());
		}

	}
	
	
	// update the item by id
	@RequestMapping(value = "update/{id}", method = RequestMethod.POST,  consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody
	Status updateEmployee(@RequestBody User user) {

		try {
			userdataServices.updateEntity(user);
			return new Status(1, "Employee updated Successfully !");
		} catch (ObjectNotFoundException e) {

			return new Status(0, "Object is not found!");
		} catch (Exception e) {
			return new Status(0, e.toString());
		}

	}
	
	
	
	
	// this method is useless for now, hence not update, since we need to modify the database table for User later
//	@RequestMapping(value = "updatebyparameters/{id}", method = RequestMethod.POST)
//	public @ResponseBody
//	Status updateUser(HttpServletRequest request,@PathVariable("id") long id) {
//
//		Map<String, String[]> parameters = request.getParameterMap();
//	 
//		String username = request.getParameter("username");
//		String lastname = request.getParameter("lastname");
//		String email = request.getParameter("email");
//		String phone = request.getParameter("phone");
//		
//		System.out.println("id is: "+id);
// 
//		Employee em=new Employee();
//		em.setId(id);
//		em.setFirstName(username);
//		em.setLastName(lastname);
//		em.setEmail(email);
//		em.setPhone(phone);
// 
//		try {
//			//dataServices.updateEntity(em);
//			return new Status(1, "Employee updated from Parameters Successfully !");
//		} catch (ObjectNotFoundException e) {
//
//			return new Status(0, "Object is not found!");
//		} catch (Exception e) {
//			return new Status(0, e.toString());
//		}
//
//	}

	
	
	
}
