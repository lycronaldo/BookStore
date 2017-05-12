/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Component.LoginSecurity;

import java.security.Principal;

/**
 *
 * @author lycronaldo
 */
public class UserPrincipal implements Principal{
    private String name;
    
    public UserPrincipal(String name)
    {
        super();
        this.name = name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    @Override
    public String getName() {
        return this.name;
    }
}
