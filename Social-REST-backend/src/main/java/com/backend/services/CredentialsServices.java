package com.backend.services;

import com.backend.model.Credentials;

public interface CredentialsServices {
	
	public boolean addEntity(Credentials cred) throws Exception;
	public Credentials getEntityById(String id) throws Exception;
	public boolean deleteEntity(String id) throws Exception;
	public boolean updateEntity(Credentials cred) throws Exception;

}
