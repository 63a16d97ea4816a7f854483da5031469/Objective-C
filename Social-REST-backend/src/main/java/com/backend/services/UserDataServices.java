package com.backend.services;

import java.util.List;
import com.backend.model.User;;

public interface UserDataServices {
	
	public boolean addEntity(User user) throws Exception;
	public User getEntityById(String email) throws Exception;
	public List<User> getEntityList() throws Exception;
	public boolean deleteEntity(String email) throws Exception;
	public boolean updateEntity(User user) throws Exception;

}
