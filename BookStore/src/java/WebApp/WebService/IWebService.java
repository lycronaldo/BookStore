/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.WebService;

import WebApp.Entity.Book.Book;
import java.util.List;
import javax.jws.WebMethod;
import javax.jws.WebService;

/**
 *
 * @author lycronaldo
 */
@WebService
public interface IWebService {
    /**
     * This is a sample web service operation
     * @param type
     * @param search
     * @param role
     * @return 
     */
    @WebMethod(operationName = "Query")
    public List<Book> Query(String type, String search, String role);
}
