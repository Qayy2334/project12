<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
  session.invalidate();  // 清除用户会话
  response.sendRedirect("index.jsp");  // 返回首页
%>
