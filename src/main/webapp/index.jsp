<%--
  Created by IntelliJ IDEA.
  User: zhouj
  Date: 17/5/18
  Time: 下午4:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="smvc" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <title>login</title>
    <link rel="stylesheet" href="${smvc}/css/bootstrap.min.css" type="text/css">
    <link href="${smvc}/css/websocket.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${smvc}/js/jquery-1.8.3.js"></script>
    <style type="text/css">
        .col-center-block {
            float: none;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row myCenter">
        <div class="col-xs-6 col-md-4 col-center-block">
            <form class="form-signin" action="${smvc}/login" method="post">
                <h2 class="form-signin-heading" style="text-align: center">请登录</h2>
                <label for="username" class="sr-only">用户名</label>
                <input type="text" id="username" name="username" class="form-control"
                       style="width: 940px; height: 40px;" placeholder="用户名" required autofocus>
                <button class="btn btn-lg btn-primary btn-block" type="submit" style="width: 940px; height: 50px;">登录
                </button>
            </form>
        </div>
    </div>
</div>
</body>
</html>