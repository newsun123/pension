<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="pension.dao.BoardDao" %>
<%
if(session.getAttribute("userid") == null) {
	response.sendRedirect("../member/login.jsp");
}else {
	BoardDao bdao = new BoardDao();
	bdao.write_ok(request,response,session);
}
%>