/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Component.WebSocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 *
 * @author lycronaldo
 */
@ServerEndpoint("/chat")
public class WebSocket {
    static Set<Session> USERS = Collections.synchronizedSet(new HashSet<Session>());
    
    @OnOpen
    public void onOpen(Session session)
    {
        System.out.println("Session " + session.getId() + " connected!");
        USERS.add(session);
    }
    
    @OnMessage
    public void onMessage(Session session, String message)
    {
        Iterator<Session> it = USERS.iterator();
        while(it.hasNext())
        {
            try{
                it.next().getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    @OnClose
    public void onClose(Session session)
    {
        USERS.remove(session);
    }
}
