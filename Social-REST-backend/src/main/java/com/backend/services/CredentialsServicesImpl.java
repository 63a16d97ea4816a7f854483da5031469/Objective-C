package com.backend.services;

import org.springframework.beans.factory.annotation.Autowired;

import com.backend.dao.CredentialsDaoImpl;
import com.backend.model.Credentials;

public class CredentialsServicesImpl implements CredentialsServices{
	
	@Autowired
	private CredentialsDaoImpl credentialsDao;

	@Override
	public boolean addEntity(Credentials cred) throws Exception {
		// TODO Auto-generated method stub
		credentialsDao.addEntity(cred);
		return false;
	}

	@Override
	public Credentials getEntityById(String id) throws Exception {
		// TODO Auto-generated method stub
		return credentialsDao.getEntityById(id);
	}

	@Override
	public boolean deleteEntity(String id) throws Exception {
		// TODO Auto-generated method stub
		credentialsDao.deleteEntity(id);
		return false;
	}

	@Override
	public boolean updateEntity(Credentials cred) throws Exception {
		// TODO Auto-generated method stub
		credentialsDao.updateEntity(cred);
		return false;
	}

}
