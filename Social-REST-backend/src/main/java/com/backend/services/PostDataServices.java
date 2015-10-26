package com.backend.services;

import java.util.List;

import com.backend.model.Post;

public interface PostDataServices {
	
	public boolean addEntity(Post post) throws Exception;
	public Post getEntityById(String id) throws Exception;
	public List<Post> getEntityList() throws Exception;
	public boolean deleteEntity(String id) throws Exception;
	public boolean updateEntity(Post post) throws Exception;

}
