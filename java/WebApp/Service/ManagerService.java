/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Service;

import WebApp.Dao.ManagerDao;
import WebApp.Entity.Manager.Manager;

/**
 *
 * @author lycronaldo
 */
public class ManagerService {
    private ManagerDao dao;
    
    public void setDao(ManagerDao dao)
    {
        this.dao = dao;
    }
    
    public boolean ManagerLogin(Manager manager)
    {
        return dao.Manager_Login(manager);
    }
    
    public Manager getManagerbyName(String managername)
    {
        return dao.getManagerbyName(managername);
    }
}
