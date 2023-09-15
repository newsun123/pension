<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.InquiryDao" %>
<%
if(session.getAttribute("userid") == null) {
	response.sendRedirect("../member/login.jsp");
}else {
	
	InquiryDao idao = new InquiryDao();
	idao.write_ok(request,response,session);
	
}
%>