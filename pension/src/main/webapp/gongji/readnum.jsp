<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongJiDao"%>
<%
		GongJiDao gdao = new GongJiDao();
		gdao.readnum(request,response);

%>