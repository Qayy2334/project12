<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员登录</title>
</head>
<body>
<h2>管理员登录</h2>

<form method="post" action="${pageContext.request.contextPath}/admin/AdminController?action=login">
    <label for="username">管理员账号：</label>
    <input type="text" id="username" name="username" required><br>

    <label for="password">密码：</label>
    <input type="password" id="password" name="password" required><br>

    <button type="submit">登录</button>
</form>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
<p style="color: red;"><%= error %></p>
<%
    }
%>

</body>
</html>
