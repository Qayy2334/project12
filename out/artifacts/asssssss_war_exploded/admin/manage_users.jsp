<%@ page import="java.util.List" %>
<%@ page import="com.shop.dao.UserDAO" %>
<%@ page import="com.shop.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
</head>
<body>

<h2>用户管理</h2>

<!-- 显示用户列表 -->
<table border="1">
    <tr>
        <th>ID</th><th>用户名</th><th>角色</th><th>操作</th>
    </tr>
    <%
        UserDAO userDAO = new UserDAO();
        List<User> userList = userDAO.getAllUsers();
        for (User user : userList) {
    %>
    <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getUsername() %></td>
        <td><%= user.getRole() %></td>
        <td>
            <% if (!"admin".equals(user.getRole())) { %>
            <form method="post" action="${pageContext.request.contextPath}/admin/UserController?action=deleteUser">
                <input type="hidden" name="id" value="<%= user.getId() %>">
                <button type="submit">删除</button>
            </form>
            <% } else { %>
            <span>管理员</span>
            <% } %>
        </td>
    </tr>
    <% } %>
</table>

</body>
</html>
