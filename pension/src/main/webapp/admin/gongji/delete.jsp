<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("userid") == null || !session.getAttribute("userid").equals("admin")) {
	
	response.sendRedirect("../../main/index.jsp");
	} else {
%>
<%@page import="pension.dao.GongJiDao"%>
<%
		GongJiDao gdao = new GongJiDao();
		gdao.delete(request, response);
	}

%>