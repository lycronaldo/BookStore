/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Action;

import Component.LoginSecurity.JaasCallbackHandler;
import WebApp.Entity.Manager.Manager;
import WebApp.Entity.User.User;
import WebApp.Service.ManagerService;
import WebApp.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import static java.lang.Integer.parseInt;
import java.util.List;
import javax.security.auth.login.LoginContext;
import javax.security.auth.login.LoginException;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author lycronaldo
 */
public class ManagerAction extends ActionSupport {
    private Manager manager;
    private UserService userservice;
    private ManagerService managerservice;
    
    public void setManager(Manager manager)
    {
        this.manager = manager;
    }
    
    public void setUserservice(UserService userservice)
    {
        this.userservice = userservice;
    }
    
    public void setManagerservice(ManagerService managerservice)
    {
        this.managerservice = managerservice;
    }
    
    public String Manager_Login() throws LoginException
    {
        try{
            String username = ServletActionContext.getRequest().getParameter("j_username");
            String password = ServletActionContext.getRequest().getParameter("j_password");
            LoginContext lc = new LoginContext("BookStore", new JaasCallbackHandler(username, password));
            lc.login();
            return "success";
        }catch(LoginException e){
            e.printStackTrace();
            return "error";
        }catch(SecurityException e){
            e.printStackTrace();
            return "error";
        }
    }
    
    public String User_Update()
    {
        Integer userid = parseInt(ServletActionContext.getRequest().getParameter("userid"));
        User user = userservice.getUserbyId(userid);
        user.setUsername(ServletActionContext.getRequest().getParameter("username"));
        user.setEmail(ServletActionContext.getRequest().getParameter("email"));
        user.setMobile(ServletActionContext.getRequest().getParameter("mobile"));
        user.setIdentify(ServletActionContext.getRequest().getParameter("identify"));
        if(userservice.User_Update(user))
        {
            ServletActionContext.getRequest().setAttribute("user_list", 
                    userservice.getAllUser());
            return SUCCESS;
        }
        ServletActionContext.getRequest().setAttribute("user_list",
                    userservice.getAllUser());
        ServletActionContext.getRequest().setAttribute("ERROR", "用户更新失败!");
        return ERROR;
    }
    
    public String User_Delete()
    {
        Integer userid = parseInt(ServletActionContext.getRequest().getParameter("userid"));
        if(userservice.User_Delete(userid))
        {
            ServletActionContext.getRequest().setAttribute("user_list",
                    userservice.getAllUser());
            return SUCCESS;
        }
        ServletActionContext.getRequest().setAttribute("user_list",
                    userservice.getAllUser());
        ServletActionContext.getRequest().setAttribute("ERROR", "用户删除失败!");
        return ERROR;
    }
    
    public String Jump_To_User_Update()
    {
        ServletActionContext.getRequest().setAttribute("user_list",
                    userservice.getAllUser());
        return SUCCESS;
    }
    
    public String Add_User()
    {
        User newuser;
        int size = parseInt(ServletActionContext.getRequest().getParameter("size"));
        for(int i=0;i<size;++i)
        {
            newuser = new User();
            newuser.setUsername(ServletActionContext.getRequest().getParameter("username"+i));
            newuser.setPassword(ServletActionContext.getRequest().getParameter("password"+i));
            newuser.setEmail(ServletActionContext.getRequest().getParameter("email"+i));
            newuser.setMobile(ServletActionContext.getRequest().getParameter("mobile"+i));
            newuser.setIdentify(ServletActionContext.getRequest().getParameter("identify"+i));
            newuser.setGender(ServletActionContext.getRequest().getParameter("gender"+i));
            if(!userservice.User_Register(newuser))
            {
                ServletActionContext.getRequest().setAttribute("ERROR", "添加第"+(i+1)+"位用户失败!");
                return ERROR;
            }
        }
        ServletActionContext.getRequest().setAttribute("user_list", userservice.getAllUser());
        return SUCCESS;
    }
}
