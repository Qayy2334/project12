<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>管理员后台</title>
</head>
<body>

<h2>欢迎，管理员！</h2>

<ul>
  <li><a href="${pageContext.request.contextPath}/admin/manage_products.jsp">商品管理</a></li>
  <li><a href="${pageContext.request.contextPath}/admin/manage_users.jsp">用户管理</a></li>
  <li><a href="${pageContext.request.contextPath}/logout.jsp">退出登录</a></li>
</ul>


</body>
</html>
