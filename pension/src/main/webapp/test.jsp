<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@page import="pension.util.Util" %>
<%
Util u = new Util();
out.print(u.isCheck(2023,5,6)+"<br>");
out.print(u.isCheck(2023,8,6)+"<br>");
out.print(u.isCheck(2023,7,15)+"<br>");
%>
</body>
</html>