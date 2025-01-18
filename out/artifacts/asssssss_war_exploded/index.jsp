<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="com.shop.dao.ProductDAO"%>
<%@ page import="com.shop.model.Product"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>电商商城首页</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
    }
    .product-card button:hover {
      background-color: #218838;
    }

    .product-card button {
      background-color: #28a745;
      color: white;
      border: none;
      padding: 10px 15px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
      margin-top: 10px;
    }
    .product-container {
      display: flex;
      flex-wrap: wrap;  /* 自动换行 */
      justify-content: flex-start;  /* 左对齐 */
      gap: 20px;  /* 间距 */
    }
    .header {
      background-color: #333;
      color: white;
      padding: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .product-card {
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 15px;
      width: 220px;  /* 固定宽度 */
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      text-align: center;
      transition: transform 0.3s ease-in-out;
    }

    .product-card:hover {
      transform: scale(1.05);  /* 放大效果 */
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }

    .product-card img {
      width: 100%;
      height: 150px;
      object-fit: cover;
      border-radius: 4px;
    }
    .header a {
      color: white;
      margin: 0 10px;
      text-decoration: none;
    }
    .content-container {
      width: 80%;
      margin: 20px auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      display: flex;
    }
    .sidebar {
      width: 20%;
      padding: 20px;
      border-right: 1px solid #ddd;
    }
    .sidebar h3 {
      margin-top: 0;
    }
    .sidebar ul {
      list-style: none;
      padding: 0;
    }
    .sidebar ul li {
      margin: 10px 0;
    }
    .sidebar ul li a {
      text-decoration: none;
      color: #333;
    }
    .product-item img {
      width: 100%;
      height: 150px;
      object-fit: cover;
    }
  </style>

  <script>
    function addToCart(productId, isLoggedIn) {
      if (!isLoggedIn) {
        // ✅ 未登录，跳转到登录页面
        window.location.href = "login.jsp";
        return;
      }

      // ✅ 已登录，执行 AJAX 加入购物车操作
      fetch("CartController?action=add", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "productId=" + productId
      }).then(() => {
        // ✅ 加入购物车成功后刷新页面
        location.reload();
      }).catch(() => {
        console.error("加入购物车失败！");
      });
    }
  </script>
</head>
<body>
<div class="header">
  <div>
    <a href="index.jsp">首页</a>
    <a href="cart.jsp">购物车</a>
    <a href="${pageContext.request.contextPath}/admin/admin_login.jsp">管理员登录</a>

  </div>
  <div>
    <% if (session != null && session.getAttribute("user") != null) { %>
    <span>欢迎，<%= session.getAttribute("user") %>！</span>
    <a href="logout.jsp">退出登录</a>
    <% } else { %>
    <a href="login.jsp">登录</a> |
    <a href="register.jsp">注册</a>
    <% } %>
  </div>
</div>

<h2>商城商品展示</h2>

<!-- 商品分类导航 -->
<div class="category-bar">
  <a href="index.jsp">全部商品</a>
  <a href="index.jsp?category=电子产品">电子产品</a>
  <a href="index.jsp?category=服装">服装</a>
  <a href="index.jsp?category=家居">家居</a>
</div>

<!-- 商品展示区 -->
<%
  ProductDAO productDAO = new ProductDAO();
  List<Product> productList = productDAO.getAllProducts();
  boolean isLoggedIn = session.getAttribute("userId") != null;
%>

<div class="product-container">
  <%
    for (Product product : productList) {
  %>
  <div class="product-card">
    <h3><%= product.getName() %></h3>
    <p>价格：¥<%= product.getPrice() %></p>
    <p>库存：<%= product.getStock() %> 件</p>
    <!-- ✅ 根据登录状态调用不同的逻辑 -->
    <button type="button" onclick="addToCart(<%= product.getId() %>, <%= isLoggedIn %>)">加入购物车</button>
  </div>
  <%
    }
  %>
</div>
</body>
</html>