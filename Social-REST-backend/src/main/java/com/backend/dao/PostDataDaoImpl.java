package com.backend.dao;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import com.backend.model.Post;

public class PostDataDaoImpl implements PostDataDao{

	@Autowired
	SessionFactory sessionFactory;

	Session session = null;
	Transaction tx = null;
	@Override
	public boolean addEntity(Post post) throws Exception {
		// TODO Auto-generated method stub
		
		try{
		session = sessionFactory.openSession();
		tx = session.beginTransaction();
		session.save(post);
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
	public Post getEntityById(String postid) throws Exception {
		// TODO Auto-generated method stub
		session = sessionFactory.openSession();
		Post post = (Post) session.load(Post.class,
				new String(postid));
		tx = session.getTransaction();
		session.beginTransaction();
		tx.commit();
		return post;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Post> getEntityList() throws Exception {
		// TODO Auto-generated method stub
		//return null;
		session=sessionFactory.openSession();
		tx=session.beginTransaction();
		List<Post> postList=session.createCriteria(Post.class).list();
		tx.commit();
		session.close();
		
		return postList;
	}

	@Override
	public boolean deleteEntity(String postId) throws Exception {
		// TODO Auto-generated method stub
		session = sessionFactory.openSession();
		Object o = session.load(Post.class,postId);
		tx = session.getTransaction();
		session.beginTransaction();
		session.delete(o);
		tx.commit();
		return false;
	}

	@Override
	public boolean updateEntity(Post post) throws Exception {
		// TODO Auto-generated method stub
		session = sessionFactory.openSession();
		tx = session.beginTransaction();

		session.saveOrUpdate(post);
		tx.commit();
		session.close();

	return false;
	}

	

}
