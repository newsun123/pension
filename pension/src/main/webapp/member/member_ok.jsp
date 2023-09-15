<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>

<%

MemberDao mdao = new MemberDao();
mdao.member_ok(request, response);
%>
