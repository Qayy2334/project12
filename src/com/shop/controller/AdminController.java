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

@WebServlet("/admin/AdminController")  // ✅ 统一处理管理员功能
public class AdminController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            adminLogin(request, response);
        } else if ("deleteUser".equals(action)) {
            deleteUser(request, response);
        }
    }

    /**
     * ✅ 管理员登录
     */
    private void adminLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.loginUser(username, password);

        if (user != null && "admin".equals(user.getRole())) {
            HttpSession session = request.getSession();
            session.setAttribute("adminId", user.getId());
            session.setAttribute("admin", user.getUsername());

            // ✅ 登录成功后跳转到后台首页
            response.sendRedirect(request.getContextPath() + "/admin/admin_dashboard.jsp");
        } else {
            request.setAttribute("error", "管理员账号或密码错误！");
            request.getRequestDispatcher("/admin/admin_login.jsp").forward(request, response);
        }
    }

    /**
     * ✅ 删除用户功能
     */
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        boolean success = userDAO.deleteUser(userId);

        if (success) {
            response.sendRedirect("admin_dashboard.jsp?success=删除成功");
        } else {
            response.sendRedirect("admin_dashboard.jsp?error=删除失败");
        }
    }
}
