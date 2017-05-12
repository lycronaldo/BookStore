/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.WebService;

import WebApp.Entity.Book.Book;
import WebApp.Service.BookService;
import java.util.List;
import javax.jws.WebService;

/**
 *
 * @author lycronaldo
 */
@WebService(endpointInterface="WebApp.WebService.IWebService", serviceName="IWebService")
public class webservice implements IWebService{
    private static BookService service;
    public void setService(BookService service)
    {
        webservice.service = service;
    }
    /**
     * This is a sample web service operation
     * @param search
     * @param type
     * @param role
     * @return 
     */
    @Override
    public List<Book> Query(String type, String search, String role) 
    {
        return service.Search_Book(type, search, role);
    }
}
