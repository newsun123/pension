<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="pension.dao.GongJiDao" %>
<%@page import="pension.dto.GongJiDto" %>
<%
if (session.getAttribute("userid") == null || !session.getAttribute("userid").equals("admin")) {

	response.sendRedirect("../../main/index.jsp");
} else {

	GongJiDao gdao = new GongJiDao();
	gdao.content(request);
	GongJiDto gdto = (GongJiDto) request.getAttribute("gdto");
%>
<%@include file="../menu.jsp" %>
<style>
table {
	margin-top: 100px;
	line-height: 30px;
	border:1px;
}
table .a {
	width:50px;
}
</style>
</head>
<body>
	<table width="800" align="center" border="1">
		<caption><h3> 공지사항 </h3></caption>
			<tr>
				<td class="a">제목</td>				
				<td><%=gdto.getTitle()%></td>				
			</tr>	
			<tr>
				<td class="a">작성일</td>				
				<td><%=gdto.getWriteday()%></td>				
			</tr>	
			<tr>
				<td class="a">조회수</td>				
				<td><%=gdto.getReadnum()%></td>				
			</tr>	
			<tr>
				<td class="a">내용</td>				
				<td><%=gdto.getContent()%></td>				
			</tr>	
			<tr>
				<td colspan="2" align="center">
					<a href="update.jsp?id=<%=gdto.getId()%>">수정</a>
					<a href="delete.jsp?id=<%=gdto.getId()%>">삭제</a>
					<a href="list.jsp">목록</a>
				</td>								
			</tr>	
	</table>
</body>
</html>
<%} %>