<%@ page import="java.util.List" %>
<%@ page import="com.shop.dao.CartDAO" %>
<%@ page import="com.shop.model.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>购物车</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        button {
            padding: 5px 10px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #c82333;
        }
    </style>

    <script>
        // ✅ AJAX删除购物车商品并刷新页面
        function removeFromCart(cartItemId) {
            fetch("CartController?action=remove", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "cartItemId=" + cartItemId
            }).then(() => {
                // ✅ 删除成功后静默刷新页面
                location.reload();
            }).catch(() => {
                console.error("删除失败！");
            });
        }
    </script>
</head>

<body>

<h2>我的购物车</h2>

<%
    if (session != null && session.getAttribute("userId") != null) {
        int userId = (Integer) session.getAttribute("userId");
        CartDAO cartDAO = new CartDAO();
        List<CartItem> cartItems = cartDAO.getCartItems(userId);

        if (cartItems.isEmpty()) {
%>
<p>购物车为空</p>
<%
} else {
%>
<table border="1">
    <tr>
        <th>商品名称</th>
        <th>数量</th>
        <th>操作</th>
    </tr>
    <%
        for (CartItem item : cartItems) {
    %>
    <tr>
        <td><%= item.getProductName() %></td> <!-- ✅ 显示商品名称 -->
        <td><%= item.getQuantity() %></td>
        <td>
            <button type="button" onclick="removeFromCart(<%= item.getId() %>)">删除</button>
        </td>
    </tr>
    <%
        }
    %>
</table>
<%
    }
} else {
%>
<p>请先 <a href="login.jsp">登录</a> 查看购物车</p>
<%
    }
%>

</body>
</html>