/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Action;

import WebApp.Entity.User.User;
import WebApp.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import static java.lang.Integer.parseInt;
import org.apache.struts2.ServletActionContext;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

/**
 *
 * @author lycronaldo
 */
@Aspect
public class UserAction extends ActionSupport {
    
    private UserService service;
    private User user;
    
    public void setService(UserService service)
    {
        this.service = service;
    }
    
    public void setUser(User user)
    {
        this.user = user;
    }
    
    public UserAction() {
    }
    
    public String User_Register()
    {
        user.setUsername(ServletActionContext.getRequest().getParameter("username"));
        user.setPassword(ServletActionContext.getRequest().getParameter("password"));
        user.setMobile(ServletActionContext.getRequest().getParameter("mobile"));
        user.setEmail(ServletActionContext.getRequest().getParameter("email"));
        user.setIdentify(ServletActionContext.getRequest().getParameter("identify"));
        user.setGender(ServletActionContext.getRequest().getParameter("gender"));
        if(service.User_Register(user))
            return SUCCESS;
        ServletActionContext.getRequest().setAttribute("ERROR", "注册失败!");
        return ERROR;
    }
    
    public String User_Login()
    {
        user.setUsername(ServletActionContext.getRequest().getParameter("username"));
        user.setPassword(ServletActionContext.getRequest().getParameter("password"));
        String res = service.User_Login(user);
        if(res.equals("success"))
            ServletActionContext.getRequest().getSession().setAttribute("User", 
                    service.getUserbyName(user.getUsername()).getId().toString());
        ServletActionContext.getRequest().setAttribute("cond", res);
        return res;
    }
    
    @Pointcut("execution(* WebApp.Action.BookAction.Jump_To_BookStore())")
    public void aop_cut()
    {}
    
    @Before("aop_cut()")
    public void AOP_Filter()
    {
        String userid = (String)ServletActionContext.getRequest().getSession().getAttribute("User");
        if(userid == null || userid.equals("null"))
        {
            ServletActionContext.getRequest().setAttribute("login", "false");
            System.out.println("The guest" + userid + "has not login!");
        }
    }
    
    public String Jump_To_User_Login()
    {
        return SUCCESS;
    }
    
    public String Jump_To_User_Register()
    {
        return SUCCESS;
    }
    
    public String Jump_To_User_Center()
    {
        int userid = parseInt(ServletActionContext.getRequest().getParameter("userid"));
        user = service.getUserbyId(userid);
        String id = ""+userid;
        ServletActionContext.getRequest().setAttribute("user_info", user);
        ServletActionContext.getRequest().getSession().setAttribute("User", id);
        return SUCCESS;
    }
    
    public String Jump_To_Chatting_Room()
    {
        int userid = parseInt(ServletActionContext.getRequest().getParameter("userid"));
        user = service.getUserbyId(userid);
        ServletActionContext.getRequest().getSession().setAttribute("User", ""+userid);
        ServletActionContext.getRequest().setAttribute("username", user.getUsername());
        return SUCCESS;
    }
}
