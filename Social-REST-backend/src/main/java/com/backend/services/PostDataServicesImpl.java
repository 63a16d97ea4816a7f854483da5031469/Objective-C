package com.backend.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.backend.dao.PostDataDaoImpl;
import com.backend.model.Post;

public class PostDataServicesImpl implements PostDataServices{

	@Autowired
	PostDataDaoImpl postdataDao;
	@Override
	public boolean addEntity(Post post) throws Exception {
		// TODO Auto-generated method stub
		return postdataDao.addEntity(post);
	}

	@Override
	public Post getEntityById(String id) throws Exception {
		// TODO Auto-generated method stub
		return postdataDao.getEntityById(id);
	}

	@Override
	public List<Post> getEntityList() throws Exception {
		// TODO Auto-generated method stub
		return postdataDao.getEntityList();
	}

	@Override
	public boolean deleteEntity(String id) throws Exception {
		// TODO Auto-generated method stub
		return postdataDao.deleteEntity(id);
	}

	@Override
	public boolean updateEntity(Post post) throws Exception {
		// TODO Auto-generated method stub
		return postdataDao.updateEntity(post);
	}

}
