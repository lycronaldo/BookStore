/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Entity.User;

import java.io.Serializable;

/**
 *
 * @author lycronaldo
 */
public class User implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer id;
    private String username;
    private String password;
    private String mobile;
    private String email;
    private String identify;
    private String gender;

    public User() {
    }

    public User(Integer id) {
        this.id = id;
    }

    public User(Integer id, String username, String password, String email, String identify) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.identify = identify;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIdentify() {
        return identify;
    }

    public void setIdentify(String identify) {
        this.identify = identify;
    }
    
    public String getGender()
    {
        return gender;
    }
    
    public void setGender(String gender)
    {
        this.gender = gender;
    }
}
