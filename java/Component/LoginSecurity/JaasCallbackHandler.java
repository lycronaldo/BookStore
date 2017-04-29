/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Component.LoginSecurity;

import java.io.IOException;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;

/**
 *
 * @author lycronaldo
 */
public class JaasCallbackHandler implements CallbackHandler{
    private String username;
    private String password;
    
    public JaasCallbackHandler(String username, String password)
    {
        this.username = username;
        this.password = password;
    }
    @Override
    public void handle(Callback[] callbacks) throws IOException, UnsupportedCallbackException {
        int len = callbacks.length;
        for(int i=0;i<len;++i)
        {
            if(callbacks[i] instanceof NameCallback)
            {
                NameCallback ncb = (NameCallback)callbacks[i];
                ncb.setName(username);
            }
            if(callbacks[i] instanceof PasswordCallback)
            {
                PasswordCallback pcb = (PasswordCallback)callbacks[i];
                pcb.setPassword(password.toCharArray());
            }
        }
    }
    
}
