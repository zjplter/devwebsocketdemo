package org.tyq.websocket;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Created by zhouj on 17/5/17.
 */
@ServerEndpoint(value = "/socket")
public class Websocket {

    private static Map<String, Session> sessionMap = new HashMap<String, Session>();

    @OnMessage
    public void onMessage(String message,
                          Session session) throws IOException, InterruptedException {
        String id = session.getId();
        System.out.println("连接服务器的人数" + id);
        String name = "";
        if ("0".equals(id)) {
            name = "大雄";
        } else if ("1".equals(id)) {
            name = "静香";
        } else if ("2".equals(id)) {
            name = "小强";
        } else if ("3".equals(id)) {
            name = "胖虎";
        } else if ("4".equals(id)) {
            name = "桂香";
        } else if ("5".equals(id)) {
            name = "桂花";
        } else if ("6".equals(id)) {
            name = "如意";
        } else if ("7".equals(id)) {
            name = "汤圆";
        } else if ("8".equals(id)) {
            name = "厂老";
        } else if ("9".equals(id)) {
            name = "雄霸";
        } else {
            name = "游客";
        }
        // 服务器向客户端发送数据
        sendAll(name, message);
    }

    /**
     * 向所有人发送消息
     *
     * @throws IOException
     */
    public static void sendAll(String name,
                               String message) throws IOException {
        Set<Map.Entry<String, Session>> entrySet = sessionMap.entrySet();
        for (Map.Entry<String, Session> entry : entrySet) {
            entry.getValue().getBasicRemote().sendText("{'name':'" + name + "','text':'" + message + "'}");
        }
    }

    @OnOpen
    public void onOpen(Session session) {
        // 打开连接
        sessionMap.put(session.getId(), session);
        System.out.println("打开服务器连接");
    }

    @OnClose
    public void onClose(Session session) {
        // 关闭连接
        sessionMap.remove(session.getId());
        System.out.println("服务器连接已关闭");
    }
}
