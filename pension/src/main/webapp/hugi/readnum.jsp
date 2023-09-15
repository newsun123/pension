<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.HugiDao" %>
<%
HugiDao hdao = new HugiDao();
hdao.readnum(request, response);

%>