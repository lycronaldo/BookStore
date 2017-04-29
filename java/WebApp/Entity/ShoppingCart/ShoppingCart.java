/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Entity.ShoppingCart;
import WebApp.Entity.Book.Book;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author lycronaldo
 */
public class ShoppingCart implements Serializable{
    private int userid;
    private HashMap<Integer, Integer> books;
    
    public ShoppingCart(){
        this.books = new HashMap<>();
    }
    
    public void setUserid(int userid)
    {
        this.userid = userid;
    }
    
    public int getUserid()
    {
        return this.userid;
    }
    
    public HashMap<Integer, Integer> getBooks()
    {
        return this.books;
    }
    
    public void add_book(Integer bookid)
    {
        if(books.containsKey(bookid))
        {
            Integer size = books.get(bookid);
            ++size;
            books.put(bookid, size);
        }
        else
        {
            books.put(bookid, 1);
        }
    }
}
