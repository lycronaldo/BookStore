/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Dao;

import WebApp.Entity.Manager.Manager;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author lycronaldo
 */
public class ManagerDao {
    private SessionFactory factory;
    
    public void setFactory(SessionFactory factory)
    {
        this.factory = factory;
    }
    
    public boolean Manager_Login(Manager manager)
    {
        Session session = factory.openSession();
        String hql = "from Manager where managername=:name and password=:password";
        Query query = session.createQuery(hql);
        query.setString("name", manager.getManagername());
        query.setString("password", manager.getPassword());
        Manager res = (Manager)query.uniqueResult();
        return res!=null;
    }
    
    public Manager getManagerbyName(String managername)
    {
        Session session = factory.openSession();
        String hql = "from Manager where managername=:name";
        Query query = session.createQuery(hql);
        query.setString("name", managername);
        Manager res = (Manager)query.uniqueResult();
        return res;
    }
}
