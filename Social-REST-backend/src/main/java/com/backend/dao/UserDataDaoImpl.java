package com.backend.dao;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import com.backend.model.User;
public class UserDataDaoImpl implements UserDataDao{

	@Autowired
	SessionFactory sessionFactory;

	Session session = null;
	Transaction tx = null;
	@Override
	public boolean addEntity(User user) throws Exception {
		// TODO Auto-generated method stub
		
		try{
		session = sessionFactory.openSession();
		tx = session.beginTransaction();
		session.save(user);
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
	public User getEntityById(String email) throws Exception {
		// TODO Auto-generated method stub
		session = sessionFactory.openSession();
		User user = (User) session.load(User.class,
				new String(email));
		tx = session.getTransaction();
		session.beginTransaction();
		tx.commit();
		return user;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> getEntityList() throws Exception {
		// TODO Auto-generated method stub
		//return null;
		session=sessionFactory.openSession();
		tx=session.beginTransaction();
		List<User> userList=session.createCriteria(User.class).list();
		tx.commit();
		session.close();
		
		return userList;
	}

	@Override
	public boolean deleteEntity(String email) throws Exception {
		// TODO Auto-generated method stub
		session = sessionFactory.openSession();
		Object o = session.load(User.class,email);
		tx = session.getTransaction();
		session.beginTransaction();
		session.delete(o);
		tx.commit();
		return false;
	}

	@Override
	public boolean updateEntity(User user) throws Exception {
		// TODO Auto-generated method stub
		session = sessionFactory.openSession();
		tx = session.beginTransaction();
		
//		Employee updateEmployee = (Employee) session.load(Employee.class,
//				new Long(employee.getId()));
		
//		updateEmployee.setFirstName(employee.getFirstName());
//		updateEmployee.setLastName(employee.getLastName());
//		updateEmployee.setEmail(employee.getEmail());
//		updateEmployee.setPhone(employee.getPhone());
		session.saveOrUpdate(user);
		tx.commit();
		session.close();

	return false;
	}

	

}
