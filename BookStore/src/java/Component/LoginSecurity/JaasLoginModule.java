/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Component.LoginSecurity;

import WebApp.Dao.ManagerDao;
import WebApp.Entity.Manager.Manager;
import java.io.IOException;
import java.util.Arrays;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;

/**
 *
 * @author lycronaldo
 */
public class JaasLoginModule implements LoginModule{
    
    private CallbackHandler handler;
    private Subject subject;
    private UserPrincipal userPrincipal;
    private RolePrincipal rolePrincipal;
    private static ManagerDao dao;
    private boolean pass;
    
    public void setDao(ManagerDao dao)
    {
        JaasLoginModule.dao = dao;
    }
    
    @Override
    public void initialize(Subject subject, CallbackHandler callbackHandler, Map<String, ?> sharedState, Map<String, ?> options) {
        this.handler = callbackHandler;
        this.subject = subject;
    }

    @Override
    public boolean login() throws LoginException {
        try{
            NameCallback nameCallback = new NameCallback("username");
            PasswordCallback passwordCallback = new PasswordCallback("password", false);
            final Callback[] callbacks = new Callback[]{nameCallback, passwordCallback};
            handler.handle(callbacks);
            String username = nameCallback.getName();
            String password = String.valueOf(passwordCallback.getPassword());
            Manager manager = new Manager();
            manager.setManagername(username);
            manager.setPassword(password);
            if(dao.Manager_Login(manager))
            {
                userPrincipal = new UserPrincipal(username);
                rolePrincipal = new RolePrincipal("manager");
                pass = true;
                return pass;
            }
            throw new LoginException("No such Manager or Password is Wrong!");
        } catch (IOException e) {
            throw new LoginException(e.getMessage());
        } catch (UnsupportedCallbackException e) {
            throw new LoginException(e.getMessage());
        }
    }

    @Override
    public boolean commit() throws LoginException {
        if(pass)
        {
            this.subject.getPrincipals().add(userPrincipal);
            this.subject.getPrincipals().add(rolePrincipal);
            return pass;
        }
        else
        {
            throw new LoginException("Authentication Failure");
        }
    }

    @Override
    public boolean abort() throws LoginException {
        return false;
    }

    @Override
    public boolean logout() throws LoginException {
        return true;
    }
    
}
