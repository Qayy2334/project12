package com.shop.controller;

import com.shop.dao.UserDAO;
import com.shop.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UserController")  // ✅ 处理用户操作
public class UserController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            registerUser(request, response);  // ✅ 注册
        } else if ("login".equals(action)) {
            loginUser(request, response);     // ✅ 登录
        }
    }

    /**
     * ✅ 用户注册
     */
    private void registerUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRole("user");  // 默认角色：普通用户

        boolean success = userDAO.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp");  // 注册成功跳转登录
        } else {
            request.setAttribute("error", "注册失败，请重试！");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    /**
     * ✅ 用户登录
     */
    private void loginUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.loginUser(username, password);

        if (user != null && "user".equals(user.getRole())) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("user", user.getUsername());

            response.sendRedirect("index.jsp");  // ✅ 用户登录跳转首页
        } else {
            request.setAttribute("error", "用户名或密码错误！");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
