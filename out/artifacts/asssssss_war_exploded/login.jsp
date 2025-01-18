<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户登录</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: white;
            padding: 40px 60px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            width: 500px;
        }
        .login-container h2 {
            text-align: center;
            font-size: 26px;
            margin-bottom: 20px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 20px;
        }
        .form-group label {
            margin-bottom: 5px;
            font-weight: bold;
        }
        .login-container input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .login-container button {
            width: 100%;
            padding: 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        .login-container button:hover {
            background-color: #0056b3;
        }
        .login-container a {
            text-align: center;
            display: block;
            margin-top: 10px;
            color: #6c63ff;
            text-decoration: none;
        }
        .login-container a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>用户登录</h2>
    <form method="post" action="UserController?action=login">
        <label for="username">用户名：</label>
        <input type="text" id="username" name="username" required><br>

        <label for="password">密码：</label>
        <input type="password" id="password" name="password" required><br>

        <button type="submit">用户登录</button>
    </form>

    <% if (request.getAttribute("error") != null) { %>
    <div style="color: red; font-weight: bold; text-align: center; margin-top: 10px;">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <a href="register.jsp">没有账号？去注册</a>
</div>
</body>
</html>
