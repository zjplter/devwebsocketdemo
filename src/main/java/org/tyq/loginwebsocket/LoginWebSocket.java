package org.tyq.loginwebsocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

/**
 * Created by zhouj on 17/5/18.
 */
@ServerEndpoint(value = "/loginwebsocket/chat", configurator = HttpSessionConfigurator.class)
public class LoginWebSocket {

    private static Map<String, Session> sessionMap = new HashMap<String, Session>();

    String name = "";
    private Session session;
    private static HttpSession httpSession;

    @OnOpen
    public void start(Session session,
                      EndpointConfig config) {
        this.session = session;
        this.httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
        name = httpSession.getAttribute("username") == null ? "localhost" : httpSession.getAttribute("username").toString();
        sessionMap.put(session.getId(), session);
        System.out.println("打开服务器连接");
    }

    @OnClose
    public void end(Session session) {
        sessionMap.remove(session.getId());
        System.out.println("服务器连接已关闭");
    }

    @OnMessage
    public void onMessage(String message,
                          Session session) throws IOException, InterruptedException {
        Set<Map.Entry<String, Session>> entrySet = sessionMap.entrySet();
        for (Map.Entry<String, Session> entry : entrySet) {
            session.getBasicRemote().sendText("{'name':'" + name + "','text':'" + message + "'}");
        }
    }

    @OnError
    public void onError(Throwable t){
        System.out.println("throwable error is: " + t.getMessage());
    }
}
