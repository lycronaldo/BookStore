/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Component.JMS;

import WebApp.Entity.Salestatics.Salestatics;
import WebApp.Service.BookService;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.ObjectMessage;

/**
 *
 * @author lycronaldo
 */
public class jmsReceiveListener implements MessageListener{
    private static BookService service;
    
    public void setService(BookService service)
    {
        jmsReceiveListener.service = service;
    }
    @Override
    public void onMessage(Message message) {
        ObjectMessage o = (ObjectMessage)message;
        Salestatics salestatic;
        try{
            salestatic = (Salestatics)o.getObject();
            if(service.setSalestatics(salestatic))
                System.out.println("The JMS is OK!");
        } catch (JMSException e) {
            e.printStackTrace();
        }
    }
    
}
