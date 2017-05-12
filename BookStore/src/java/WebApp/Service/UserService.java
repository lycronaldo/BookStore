/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Service;

import WebApp.Dao.UserDao;
import WebApp.Entity.User.User;
import java.util.List;
import org.springframework.stereotype.Service;

/**
 *
 * @author lycronaldo
 */
@Service
public class UserService {
    private UserDao dao;
    
    public void setDao(UserDao dao)
    {
        this.dao = dao;
    }
    
    public boolean User_Register(User user)
    {
        return dao.User_Register(user);
    }
    
    public String User_Login(User user)
    {
        if(dao.getUserbyName(user.getUsername()) == null)
            return "nouser";
        else if(!dao.User_Login(user))
            return "error";
        return "success";
    }
    
    public User getUserbyId(Integer id)
    {
        return dao.getUserbyId(id);
    }
    
    public User getUserbyName(String username)
    {
        return dao.getUserbyName(username);
    }
    
    public boolean User_Update(User user)
    {
        return dao.User_Update(user);
    }
    
    public List<User> getAllUser()
    {
        return dao.getAllUser();
    }
    
    public boolean User_Delete(Integer id)
    {
        return dao.User_Delete(id);
    }
}
