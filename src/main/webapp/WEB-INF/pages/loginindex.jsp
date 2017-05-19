<%--
  Created by IntelliJ IDEA.
  User: zhouj
  Date: 17/5/18
  Time: 下午4:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.*" %>
<%
    String path = request.getContextPath();
    String ip = request.getRemoteAddr();
    String ipServer = InetAddress.getLocalHost().getHostAddress();
    int port = request.getServerPort();
    String username = (String) request.getSession().getAttribute("username");
    System.out.println(ip + ">>>" + ipServer + ">>" + port + "<<" +username);
%>
<html>
<head>
    <title>websocket</title>
    <link href="<%= path %>/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="<%= path %>/css/websocket.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%= path %>/js/jquery-1.8.3.js"></script>
    <script type="text/javascript">
        var IPSERVER = '<%= ipServer %>';
        var PORT = '<%= port %>';
        var PATH = '<%= path %>';
        var webSocket = {};
        $(function () {
            try {
                var url = "ws://" + IPSERVER + ":" + PORT + PATH + "/loginwebsocket/chat";

                webSocket = new WebSocket(url);//连接服务器
                console.log(webSocket.readyState);
                var textarea = $("#text");
                textarea.append("准备连接到服务器...\r\n");
                webSocket.onopen = function (event) {
                    textarea.append("已经与服务器建立了连接\r\n");
                    console.log("已经与服务器建立了连接-当前连接状态>>>" + this.readyState);
                };

                webSocket.onclose = function (event) {
                    textarea.append("已经与服务器断开连接\r\n");
                    console.log("已经与服务器断开连接-当前连接状态>>>" + this.readyState);
                };

                webSocket.onmessage = function (event) {
                    var value = eval("(" + event.data + ")");
                    textarea.append(value.name + ":" + value.text + "\r\n");
                    console.log("接收到服务器发送的数据>>>" + event.data);
                };

                webSocket.onerror = function (event) {
                    console.log("WebSocket异常！");
                };
            } catch (ex) {
                console.log(ex.message);
            }
        });

        //向服务器发送数据
        function SendData() {
            var send_value = $("#send_value");
            try {
                webSocket.send(send_value.val());
                send_value.val("");
            } catch (ex) {
                console.log(ex.message);
            }
        }

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function(){
            webSocket.close();
        }
    </script>
</head>
<body>
<div class="container">
    <div class="row myCenter">
        <div class="col-md-10 col-center-block">
            <textarea id="text" disabled="disabled" rows="21" style="margin-left: 0px; margin-right: 0px; width: 940px;" class="boxes"></textarea>
        </div>
        <hr>
        <div class="col-xs-6 col-md-10 col-center-block">
            <label for="send_value" class="sr-only">
                <span><<</span>
                <span><%= username %></span>
                <span>>>---&&&</span>
                <span>&nbsp;&nbsp;你可以在此次输入你要聊天的信息...</span>
            </label>
            <input type="text" id="send_value" style="width: 800px; height: 40px;" placeholder="Send Message" required autofocus>
            <button class="btn btn-lg btn-primary btn-default" type="submit" onclick="SendData();" style="width: 140px;">
                <span style="color: #953b39">发送</span>
            </button>
        </div>
    </div>
</div>
</body>
</html>
