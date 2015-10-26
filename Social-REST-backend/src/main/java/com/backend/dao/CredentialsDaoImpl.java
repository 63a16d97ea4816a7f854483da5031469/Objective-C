package com.backend.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;

import com.backend.model.Credentials;
import com.backend.model.Post;

public class CredentialsDaoImpl implements CredentialsDao{

	@Autowired
	SessionFactory sessionFactory;

	Session session = null;
	Transaction tx = null;

	@Override
	public boolean addEntity(Credentials cred) throws Exception {
		// TODO Auto-generated method stub
		try{
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			session.save(cred);
			tx.commit();
			return true;
			}
			
			catch(Exception e){
				e.printStackTrace();
			}
			
			finally{
			session.close();
			}
			
			
			return false;
	}

	@Override
	public Credentials getEntityById(String id) throws Exception {
		// TODO Auto-generated method stub
		session = sessionFactory.openSession();
		Credentials cred = (Credentials) session.load(Credentials.class,
				new String(id));
		tx = session.getTransaction();
		session.beginTransaction();
		tx.commit();
		return cred;
	}

	@Override
	public boolean deleteEntity(String id) throws Exception {
		// TODO Auto-generated method stub
		try{
		session = sessionFactory.openSession();
		Object o = session.load(Credentials.class,id);
		tx = session.getTransaction();
		session.beginTransaction();
		session.delete(o);
		tx.commit();
		return true;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updateEntity(Credentials cred) throws Exception {
		if(session==null){
			session = sessionFactory.openSession();
		}
		// TODO Auto-generated method stub
		tx = session.beginTransaction();

		session.saveOrUpdate(cred);
		tx.commit();
		session.close();

	    return false;
	}

}
