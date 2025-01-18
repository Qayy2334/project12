<%@ page import="java.util.List" %>
<%@ page import="com.shop.dao.ProductDAO" %>
<%@ page import="com.shop.model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>商品管理</title>
</head>
<body>

<h2>商品管理</h2>

<!-- 添加商品表单 -->
<form method="post" action="${pageContext.request.contextPath}/admin/ProductController?action=add">
    商品名称：<input type="text" name="name" required><br>
    价格：<input type="number" step="0.01" name="price" required><br>
    库存：<input type="number" name="stock" required><br>

    <!-- 商品类别下拉框 -->
    商品类别：
    <select name="category" required>
        <option value="电子产品">电子产品</option>
        <option value="服装">Clothes</option>
        <option value="食品">Food</option>
        <option value="书籍">Book</option>
    </select><br>

    描述：<textarea name="description"></textarea><br>
    <button type="submit">Add Goods</button>
</form>

<!-- 显示操作结果 -->
<%
    String error = request.getParameter("error");
    String success = request.getParameter("success");

    if (error != null) {
%>
<div class="error"><%= error %></div>
<% } else if (success != null) { %>
<div class="success"><%= success %></div>
<% } %>


<hr>

<!-- 显示商品列表 -->
<h3>商品列表</h3>
<table border="1">
    <tr>
        <th>ID</th><th>商品名称</th><th>价格</th><th>库存</th><th>描述</th><th>操作</th>
    </tr>
    <%
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();
        for (Product product : productList) {
    %>
    <tr>
        <td><%= product.getId() %></td>
        <td><%= product.getName() %></td>
        <td>¥<%= product.getPrice() %></td>
        <td><%= product.getStock() %></td>
        <td><%= product.getDescription() %></td>
        <td><%= product.getCategory() %></td>
        <td>
            <form method="post" action="${pageContext.request.contextPath}/admin/ProductController?action=delete">
                <input type="hidden" name="id" value="<%= product.getId() %>">
                <button type="submit" onclick="return confirm('确定要删除该商品吗？');">删除</button>
            </form>

        </td>
    </tr>
    <% } %>
</table>



</body>
</html>
