/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.RestWebService;

import WebApp.Entity.Book.Book;
import java.util.List;
import javax.jws.WebService;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author lycronaldo
 */
@WebService
@Path("/Book")
public interface IRestWebService 
{
    @GET
    @Produces({"application/json;charset=utf-8",MediaType.APPLICATION_JSON})
    @Path("/query/{type/search/role}")
    public List<Book> Query(@PathParam("type")String type, 
            @PathParam("search")String search, @PathParam("role")String role);
}
