package com.backend.dao;


import com.backend.model.Credentials;

public interface CredentialsDao {

	public boolean addEntity(Credentials cred) throws Exception;
	public Credentials getEntityById(String id) throws Exception;
	public boolean deleteEntity(String id) throws Exception;
	public boolean updateEntity(Credentials cred) throws Exception;
}
