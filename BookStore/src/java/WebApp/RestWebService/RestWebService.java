/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.RestWebService;

import WebApp.Entity.Book.Book;
import WebApp.Service.BookService;
import java.util.List;

/**
 *
 * @author lycronaldo
 */
public class RestWebService implements IRestWebService
{
    private static BookService service;
    public void setService(BookService service)
    {
        RestWebService.service = service;
    }
    @Override
    public List<Book> Query(String type, String search, String role) {
        return service.Search_Book(type, search, role);
    }
    
}
