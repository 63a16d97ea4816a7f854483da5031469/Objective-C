package com.backend.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.backend.dao.UserDataDao;
import com.backend.model.User;

public class UserDataServicesImpl implements UserDataServices{
	
	@Autowired
	UserDataDao userdataDao;

	@Override
	public boolean addEntity(User user) throws Exception {
		// TODO Auto-generated method stub
		return userdataDao.addEntity(user);
	}

	@Override
	public User getEntityById(String email) throws Exception {
		// TODO Auto-generated method stub
		return userdataDao.getEntityById(email);
	}

	@Override
	public List<User> getEntityList() throws Exception {
		// TODO Auto-generated method stub
		return userdataDao.getEntityList();
	}

	@Override
	public boolean deleteEntity(String email) throws Exception {
		// TODO Auto-generated method stub
		return userdataDao.deleteEntity(email);
	}

	@Override
	public boolean updateEntity(User user) throws Exception {
		// TODO Auto-generated method stub
		return userdataDao.updateEntity(user);
	}

	
	

	

	
}
