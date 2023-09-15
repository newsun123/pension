<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%
if(session.getAttribute("userid") == null) {
	response.sendRedirect("../member/login.jsp");
}else {
%>
<style>

</style>
<script>

</script>
<div id="section">


</div>

<%@ include file="../bottom.jsp" %>

<%
} // session 관련 괄호닫기
%>