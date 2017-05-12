/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Component.JMS;

import WebApp.Entity.Salestatics.Salestatics;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;

/**
 *
 * @author lycronaldo
 */
public class jmsSend {
    private JmsTemplate jmsTemplate;
    
    public JmsTemplate getJmsTemplate()
    {
        return this.jmsTemplate;
    }
    
    public void setJmsTemplate(JmsTemplate jmsTemplate)
    {
        this.jmsTemplate = jmsTemplate;
    }
    
    public void Send(Destination destination, final Salestatics message)
    {
        jmsTemplate.send(destination, new MessageCreator(){
            @Override
            public Message createMessage(Session session) throws JMSException {
                return session.createObjectMessage(message);
            }
            
        });
    }
}
