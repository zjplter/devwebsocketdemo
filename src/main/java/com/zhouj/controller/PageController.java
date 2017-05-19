package com.zhouj.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.server.HandshakeRequest;
import java.io.IOException;

/**
 * Created by zhouj on 17/5/17.
 */
@WebServlet("/login")
public class PageController extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.work(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.work(req, resp);
    }

    /**
     * work 调用公共方法
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    protected void work(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String indexPage = "";
        switch (req.getMethod()) {
            case "GET" :
                indexPage = "/WEB-INF/pages/index.jsp";
                req.getRequestDispatcher(indexPage).forward(req, resp);
                break;
            case "POST" :
                indexPage = "/WEB-INF/pages/loginindex.jsp";
                System.out.println(req.getSession().getCreationTime());
                String userObj = req.getParameter("username");
                session.setAttribute("username", userObj);
                req.getRequestDispatcher(indexPage).forward(req, resp);
                break;
            default:
                System.out.println("没有满足条件的信息请求......");
        }
    }
}
