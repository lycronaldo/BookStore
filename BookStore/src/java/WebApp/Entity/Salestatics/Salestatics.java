/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebApp.Entity.Salestatics;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author lycronaldo
 */
public class Salestatics implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer id;
    private int userid;
    private int bookid;
    private Date time;
    private int number;
    private String status;

    public Salestatics() {
    }

    public Salestatics(Integer id) {
        this.id = id;
    }

    public Salestatics(Integer id, int userid, int bookid, Date time, int number, String status) {
        this.id = id;
        this.userid = userid;
        this.bookid = bookid;
        this.time = time;
        this.number = number;
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getBookid() {
        return bookid;
    }

    public void setBookid(int bookid) {
        this.bookid = bookid;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
