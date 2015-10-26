package com.backend.dao;

import java.util.List;
import com.backend.model.Post;

public interface PostDataDao {
	
	public boolean addEntity(Post post) throws Exception;
	public Post getEntityById(String id) throws Exception;
	public List<Post> getEntityList() throws Exception;
	public boolean deleteEntity(String id) throws Exception;
	public boolean updateEntity(Post post) throws Exception;

}
