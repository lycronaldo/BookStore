/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Service;

import WebApp.Dao.BookDao;
import WebApp.Entity.Book.Book;
import WebApp.Entity.Category.Category;
import WebApp.Entity.Salestatics.Salestatics;
import WebApp.Entity.ShoppingCart.ShoppingCart;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author lycronaldo
 */
@Transactional
public class BookService {
    private BookDao dao;
    
    public void setDao(BookDao dao)
    {
        this.dao = dao;
    }
@Transactional(propagation = Propagation.REQUIRES_NEW, timeout = 30)
    public boolean Add_Book(Book book, Category category, String parent)
    {
        return dao.Add_Book(book, category, parent);
    }
@Transactional(timeout = 30, readOnly = true)
    public List<Book> Search_Book(String type, String search, String role)
    {
        return dao.Search_Book(type, search, role);
    }
    
    public Category getCategorybyName(String category)
    {
        return dao.getCategorybyName(category);
    }
    
    public boolean UpdateCategory(Category category, String parent)
    {
        return dao.Update_Category(category, parent);
    }
    
    public boolean hasCategory(String category)
    {
        return dao.hasCategory(category);
    }

    public boolean Pay_Books(ShoppingCart shoppingcart)
    {
        List<Salestatics> salestatics = new ArrayList<>();
        int userid = shoppingcart.getUserid();
        HashMap<Integer, Integer> book_list = shoppingcart.getBooks();
        Date time = new Date();
        for(HashMap.Entry entry : book_list.entrySet())
        {
            Salestatics tmp = new Salestatics();
            Integer bookid = (Integer)entry.getKey();
            Book book = getBookbyId(bookid);
            Integer size = (Integer)entry.getValue();
            tmp.setBookid(book.getId());
            tmp.setUserid(userid);
            tmp.setTime(time);
            tmp.setStatus("true");
            tmp.setNumber(size);
            salestatics.add(tmp);
        }
        return dao.Pay_Books(salestatics);
    }
    
    public Book getBookbyId(int id)
    {
        return dao.getBookbyId(id);
    }
    
    public boolean setSalestatics(Salestatics salestatics)
    {
        return dao.setSalestatics(salestatics);
    }
}
