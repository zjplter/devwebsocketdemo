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
    System.out.println(ip + ">>>" + ipServer + ">>" + port);
%>
<html>
<head>
    <title>志同道合的朋友们</title>
    <link href="<%= path %>/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="<%= path %>/css/websocket.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%= path %>/js/jquery-1.8.3.js"></script>
    <script type="text/javascript">
        var IPSERVER = '<%= ipServer %>';
        var PORT = '<%= port %>';
        var PATH = '<%= path %>';
        var ws;
        function ToggleConnectionClicked() {
            try {
                var url = "ws://" + IPSERVER + ":" + PORT + PATH + "/socket";
                console.log(url);
                ws = new WebSocket(url);//连接服务器
                var textarea = $("#text");
                textarea.append("准备连接到服务器...\r\n");
                ws.onopen = function (event) {
                    textarea.append("已经与服务器建立了连接\r\n");
                    console.log("已经与服务器建立了连接-当前连接状态>>>" + this.readyState);
                };
                ws.onclose = function (event) {
                    textarea.append("已经与服务器断开连接\r\n");
                    console.log("已经与服务器断开连接-当前连接状态>>>" + this.readyState);
                };
                ws.onmessage = function (event) {
                    var value = eval("(" + event.data + ")");
                    textarea.append(value.name + ":" + value.text + "\r\n");

                    console.log("接收到服务器发送的数据>>>" + event.data);
                };
                ws.onerror = function (event) {
                    console.log("WebSocket异常！");
                };
            } catch (ex) {
                console.log(ex.message);
            }
        }

        //向服务器发送数据
        function SendData() {
            var send_value = $("#send_value");
            try {
                ws.send(send_value.val());
                send_value.val("");
            } catch (ex) {
                console.log(ex.message);
            }
        }

        //关闭服务器
        function close_break() {
            ws.close();
        }
    </script>
</head>
<body>
<div class="container">
    <div class="row myCenter">
        <div class="col-md-10 col-center-block">
            <textarea id="text" disabled="disabled" rows="21" class="boxes"
                      style="margin-left: 0px; margin-right: 0px; width: 940px;"></textarea>
        </div>
        <hr>
        <div class="col-xs-6 col-md-4 col-center-block"
             style="text-align: center; margin-top: 20px;margin-left: 0px; margin-right: 0px;">
            <button class="btn btn-lg btn-primary btn-default" type="submit" onclick="ToggleConnectionClicked();" id='ToggleConnection'>
                <span style="color: #953b39">连接服务器</span>
            </button>
            <button class="btn btn-lg btn-primary btn-default" type="submit" onclick="close_break();">
                <span style="color: #953b39">关闭服务器</span>
            </button>
        </div>
        <hr>
        <div class="col-xs-6 col-md-10 col-center-block">
            <label for="send_value" class="sr-only">$$你可以在此次输入你要聊天的信息...$$</label>
            <input type="text" id="send_value" class="form-control" style="width: 800px; height: 40px;" placeholder="Send Message" required autofocus>
            <button class="btn btn-lg btn-primary btn-default" type="submit" onclick="SendData();" style="width: 140px;">
                <span style="color: #953b39">发送</span>
            </button>
        </div>
    </div>
</div>
</body>
</html>