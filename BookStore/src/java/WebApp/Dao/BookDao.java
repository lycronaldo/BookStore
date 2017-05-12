/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Dao;

import WebApp.Entity.Book.Book;
import WebApp.Entity.Category.Category;
import WebApp.Entity.Salestatics.Salestatics;
import static java.lang.Integer.parseInt;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author lycronaldo
 */
public class BookDao {
    private SessionFactory factory;
    
    public void setFactory(SessionFactory factory)
    {
        this.factory = factory;
    }
    
    public List<Integer> Parse_Child(Category category)
    {
        String []str = category.getChild().split("\\+");
        List<Integer> res = new ArrayList<>();
        for(int i=0;i<str.length;++i)
            res.add(parseInt(str[i]));
        return res;
    }
    
    public String Encode_Child(List<Integer> children)
    {
        String res = "";
        res += children.get(0).toString();
        for(int i=1;i<children.size();++i)
            res += "+"+children.get(i).toString();
        return res;
    }
    
    public boolean Add_Book(Book book, Category category, String parent)
    {
        Session session = factory.openSession();
        // Book Save
        try{
            session.beginTransaction();
            session.save(book);
            session.getTransaction().commit();
        }catch(Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        }
        
        // Category Save
        if(category != null)
        {
            try{
                session.beginTransaction();
                session.save(category);
                session.getTransaction().commit();
            }catch(Exception e){
                e.printStackTrace();
                session.getTransaction().rollback();
                return false;
            }
            
            // Child & Parent Category made
            Category p_category = getCategorybyName(parent);
            if(p_category != null)
            {
                if(!category.getCategory().equals(parent))
                {
                    Category c_category = getCategorybyName(category.getCategory());
                    category.setParent(p_category.getId());
                    if(p_category.getChild().equals("null"))
                        p_category.setChild(c_category.getId().toString());
                    else
                    {
                        String child = p_category.getChild();
                        child += "+"+c_category.getId().toString();
                        p_category.setChild(child);
                    }
                    
                    // update child category
                    try{
                        session.beginTransaction();
                        session.update(category);
                        session.getTransaction().commit();
                    }catch(Exception e){
                        e.printStackTrace();
                        session.getTransaction().rollback();
                        return false;
                    }
                    
                    // update parent category
                    try{
                        session.beginTransaction();
                        session.update(p_category);
                        session.getTransaction().commit();
                    }catch(Exception e){
                        e.printStackTrace();
                        session.getTransaction().rollback();
                        return false;
                    }
                }
            }
        }
        return true;
    }
    
    public boolean Update_Book(Book book)
    {
        Session session = factory.openSession();
        try{
            session.beginTransaction();
            session.update(book);
            session.getTransaction().commit();
        }catch(Exception e)
        {
            e.printStackTrace();
            session.getTransaction().commit();
            return false;
        }
        return true;
    }
    
    public boolean Delete_Book(Integer id)
    {
        Session session = factory.openSession();
        String hql = "from Book where id=:id";
        Query query = session.createQuery(hql);
        query.setInteger("id", id);
        Book book = (Book)query.uniqueResult();
        try{
            session.beginTransaction();
            session.delete(book);
            session.getTransaction().commit();
        }catch(Exception e){
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        }
        return true;
    }
    
    public List<Book> Search_Book(String type, String search, String role)
    {
        Session session = factory.openSession();
        String hql = "from Book where "+type+" like '%"+search+"%'";
        Query query = session.createQuery(hql);
        List<Book> res = query.list();
        if(role.equals("manager"))
            return res;
        List<Book> result = new ArrayList<>();
        hql = "from Category where role=:role";
        query = session.createQuery(hql);
        query.setString("role", role);
        HashMap<String, Integer> map = new HashMap<>();
        query.setCacheable(true);
        List<Category> set = query.list();
        for(int i=0;i<set.size();++i)
            map.put(set.get(i).getCategory(), 1);
        for(int i=0;i<res.size();++i)
            if(map.containsKey(res.get(i).getCategory()))
                result.add(res.get(i));
        return result;
    }
    
    public Category getCategorybyName(String category)
    {
        Session session = factory.openSession();
        String hql = "from Category where category=:category";
        Query query = session.createQuery(hql);
        query.setString("category", category);
        Category res = (Category)query.uniqueResult();
        return res;
    }
    
    public boolean Update_Category(Category category, String parent)
    {
        Session session = factory.openSession();
        Category p_category = getCategorybyName(parent);
        if(p_category.getId() != category.getParent())
        {
            List<Integer> children = Parse_Child(p_category);
            children.remove(category.getId());
            p_category.setChild(Encode_Child(children));
            try{
                session.beginTransaction();
                session.update(p_category);
                session.getTransaction().commit();
            }catch(Exception e){
                e.printStackTrace();
                session.getTransaction().rollback();
                return false;
            }
        }
        try{
            session.beginTransaction();
            session.update(category);
            session.getTransaction().commit();
        }catch(Exception e){
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        }
        return true;
    }
    
    public boolean hasCategory(String category)
    {
        Session session = factory.openSession();
        String hql = "from Category where category=:category";
        Query query = session.createQuery(hql);
        query.setString("category", category);
        Category res = (Category)query.uniqueResult();
        return res!=null;
    }
    
    public boolean Pay_Books(List<Salestatics> salestatics)
    {
        Session session = factory.openSession();
        int size = salestatics.size();
        for(int i=0;i<size;++i)
        {
            try{
                session.beginTransaction();
                session.save(salestatics.get(i));
                session.getTransaction().commit();
            }catch(Exception e)
            {
                e.printStackTrace();
                return false;
            }
        }
        return true;
    }
    
    public Book getBookbyId(int id)
    {
        Session session = factory.openSession();
        String hql = "from Book where id=:id";
        Query query = session.createQuery(hql);
        query.setInteger("id", id);
        Book res = (Book)query.uniqueResult();
        return res;
    }
    
    public boolean setSalestatics(Salestatics salestatics)
    {
        Session session = factory.openSession();
        try{
            session.beginTransaction();
            session.save(salestatics);
            session.getTransaction().commit();
        }catch(Exception e){
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        }
        return true;
    }
}
