/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Dao;

import WebApp.Entity.User.User;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author lycronaldo
 */
public class UserDao {
    private SessionFactory factory;
    
    public void setFactory(SessionFactory factory)
    {
        this.factory = factory;
    }
    
    public boolean User_Register(User user)
    {
        Session session = factory.openSession();
        try{
            session.beginTransaction();
            session.save(user);
            session.getTransaction().commit();
        } catch(Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
    
    public boolean User_Login(User user)
    {
        Session session = factory.openSession();
        String hql = "from User where username=:username and password=:password";
        Query query = session.createQuery(hql);
        query.setString("username", user.getUsername());
        query.setString("password", user.getPassword());
        User res = (User)query.uniqueResult();
        return res!=null;
    }
    
    public User getUserbyId(Integer id)
    {
        Session session = factory.openSession();
        String hql = "from User where id=:id";
        Query query = session.createQuery(hql);
        query.setInteger("id", id);
        User res = (User)query.uniqueResult();
        return res;
    }
    
    public User getUserbyName(String username)
    {
        Session session = factory.openSession();
        String hql = "from User where username=:username";
        Query query = session.createQuery(hql);
        query.setString("username", username);
        User res = (User)query.uniqueResult();
        return res;
    }
    
    public boolean User_Update(User user)
    {
        Session session = factory.openSession();
        try{
            session.beginTransaction();
            session.update(user);
            session.getTransaction().commit();
        }catch(Exception e){
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        }
        return true;
    }
    
    public boolean User_Delete(Integer id)
    {
        Session session = factory.openSession();
        String hql = "from User where id=:id";
        Query query = session.createQuery(hql);
        query.setInteger("id", id);
        User user = (User)query.uniqueResult();
        try{
            session.beginTransaction();
            session.delete(user);
            session.getTransaction().commit();
        }catch(Exception e){
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        }
        return true;
    }
    
    public List<User> getAllUser()
    {
        Session session = factory.openSession();
        String hql = "from User";
        Query query = session.createQuery(hql);
        return query.list();
    }
}
