/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Action;

import Component.JMS.jmsSend;
import WebApp.Entity.Book.Book;
import WebApp.Entity.Category.Category;
import WebApp.Entity.Salestatics.Salestatics;
import WebApp.Entity.ShoppingCart.ShoppingCart;
import WebApp.Entity.User.User;
import WebApp.Service.BookService;
import WebApp.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import java.io.IOException;
import static java.lang.Double.parseDouble;
import static java.lang.Integer.parseInt;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jms.Destination;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author lycronaldo
 */
public class BookAction extends ActionSupport {
    
    private BookService bookservice;
    private UserService userservice;
    private Book book;
    private Category category;
    private ShoppingCart shoppingcart;
    private jmsSend jmssend;
    private Destination destination;
    
    public BookAction() {
    }
    
    public void setBookservice(BookService bookservice)
    {
        this.bookservice = bookservice;
    }
    
    public void setBook(Book book)
    {
        this.book = book;
    }
    
    public void setUserservice(UserService userservice)
    {
        this.userservice = userservice;
    }
    
    public void setCategory(Category category)
    {
        this.category = category;
    }
    
    public void setShoppingcart(ShoppingCart shoppingcart)
    {
        this.shoppingcart = shoppingcart;
    }
    
    public void setJmssend(jmsSend send)
    {
        this.jmssend = send;
    }
    
    public void setDestination(Destination destination)
    {
        this.destination = destination;
    }
    
    public String Add_Book()
    {
        int size = parseInt(ServletActionContext.getRequest().getParameter("size"));
        String c_name;
        for(int i=0;i<size;++i)
        {
            Book newbook = new Book();
            newbook.setBookname(ServletActionContext.getRequest().getParameter("bookname"+i));
            newbook.setAuthor(ServletActionContext.getRequest().getParameter("author"+i));
            newbook.setPrice(parseDouble(ServletActionContext.getRequest().getParameter("price"+i)));
            newbook.setCategory(ServletActionContext.getRequest().getParameter("category"+i));
            c_name = ServletActionContext.getRequest().getParameter("category"+i);
            Category newcategory;
            String parent = "";
            if(!bookservice.hasCategory(c_name))
            {
                newcategory = new Category();
                newcategory.setCategory(c_name);
                newcategory.setRole(ServletActionContext.getRequest().getParameter("role"+i));
                parent = ServletActionContext.getRequest().getParameter("parent"+i);
                if(!parent.equals(newcategory.getCategory()))
                {
                    Category p = bookservice.getCategorybyName(parent);
                    if(p != null)
                        newcategory.setParent(p.getId());
                }
                else
                    newcategory.setParent(0);
                newcategory.setChild("null");
            }
            else
                newcategory = null;
            if(!bookservice.Add_Book(newbook, newcategory, parent))
                return ERROR;
        }
        return SUCCESS;
    }
    
    public String Search_Book()
    {
        String type = ServletActionContext.getRequest().getParameter("type");
        String search = ServletActionContext.getRequest().getParameter("search");
        String role = ServletActionContext.getRequest().getParameter("role");
        Integer userid;
        if(!role.equals("manager"))
        {
            userid = parseInt(role);
            User user = userservice.getUserbyId(userid);
            role = user.getIdentify();
        }
        List<Book> book_list = bookservice.Search_Book(type, search, role);
        ServletActionContext.getRequest().setAttribute("book_list", book_list);
        return SUCCESS;
    }
    
    public String Add_Book_To_ShoppingCart()
    {
        int userid = parseInt(ServletActionContext.getRequest().getParameter("userid"));
        int bookid = parseInt(ServletActionContext.getRequest().getParameter("bookid"));
        this.shoppingcart.setUserid(userid);
        this.shoppingcart.add_book(bookid);
        return null;
    }
    
    public String Pay_Books()
    {
        int userid = parseInt(ServletActionContext.getRequest().getParameter("userid"));
        String password = ServletActionContext.getRequest().getParameter("password");
        User user = userservice.getUserbyId(userid);
        if(!user.getPassword().equals(password))
            return ERROR;
        if(!bookservice.Pay_Books(shoppingcart))
            return ERROR;
        String id = ""+userid;
        ServletActionContext.getRequest().getSession().setAttribute("User", id);
        return SUCCESS;
    }
    
    public String setOrder()
    {
        int userid = parseInt(ServletActionContext.getRequest().getParameter("userid"));
        int bookid = parseInt(ServletActionContext.getRequest().getParameter("bookid"));
        Date time = new Date();
        Salestatics salestatics = new Salestatics();
        salestatics.setBookid(bookid);
        salestatics.setUserid(userid);
        salestatics.setTime(time);
        salestatics.setNumber(1);
        salestatics.setStatus("true");
        jmssend.Send(destination, salestatics);
        ServletActionContext.getRequest().getSession().setAttribute("user", ""+userid);
        return SUCCESS;
    }
    
    public String Show_Detail()
    {
        int bookid = parseInt(ServletActionContext.getRequest().getParameter("bookid"));
        book = bookservice.getBookbyId(bookid);
        try {
            ServletActionContext.getResponse().getWriter().write(
                    "<tr class='info'><td style='color: red'>BookName:</td><td style='color: red'>Author:</td>"+
                    "<td style='color: red'>Price:</td><td style='color: red'>Category:</tr>"+
                    "<tr class='info'><td style='color:darkorchid'>"+book.getBookname()+
                    "</td><td style='color:darkorchid'>"+book.getAuthor()+
                    "</td><td style='color:darkorchid'>"+book.getPrice()+
                    "</td><td style='color:darkorchid'>"+book.getCategory()+
                    "</tr>");
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }
    
    public String Jump_To_BookStore()
    {
        String userid = ServletActionContext.getRequest().getParameter("userid");
        ServletActionContext.getRequest().getSession().setAttribute("User", userid);
        return SUCCESS;
    }
    
    public String Jump_To_ShoppingCart()
    {
        String userid = ServletActionContext.getRequest().getParameter("userid");
        ServletActionContext.getRequest().getSession().setAttribute("User", userid);
        HashMap<Integer, Integer> book_ids = shoppingcart.getBooks();
        HashMap<Book, Integer> book_list = new HashMap<>();
        for(HashMap.Entry entry : book_ids.entrySet())
        {
            Integer bookid = (Integer)entry.getKey();
            Book newbook = bookservice.getBookbyId(bookid);
            book_list.put(newbook, (Integer)entry.getValue());
        }
        ServletActionContext.getRequest().setAttribute("ShoppingCart", book_list);
        return SUCCESS;
    }
    
    public String Jump_To_Pay()
    {
        String userid = ServletActionContext.getRequest().getParameter("userid");
        ServletActionContext.getRequest().getSession().setAttribute("User", userid);
        return SUCCESS;
    }
}
