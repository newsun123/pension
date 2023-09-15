<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao"%>
<%
if(session.getAttribute("userid") == null) {
	response.sendRedirect("../member/login.jsp");
}else {
	
	MemberDao mdao = new MemberDao();
	mdao.review_ok(request,response,session); 
	
	
} // session 관련 괄호닫기
%>