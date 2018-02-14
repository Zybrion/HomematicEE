<%@ page import="com.homematic.Login" %><%--
  Created by IntelliJ IDEA.
  User: nikol
  Date: 14.02.2018
  Time: 05:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Login.SetCookiesLogout(request, response, "user_id");
    session=request.getSession();
    session.invalidate();
    response.sendRedirect("../index.html");
%>

<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
