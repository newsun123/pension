<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../menu.jsp" %>
<%@page import="pension.dao.EventDao" %>
<%@page import="pension.dto.EventDto" %>
<%@page import="java.util.ArrayList" %>
<%
EventDao edao = new EventDao();
edao.content(request); 
EventDto edto = (EventDto)request.getAttribute("edto");

%>
<style>

</style>
<div id="section">
	<table width="600"	 align="center">
		<caption> <h3> 이벤트 게시판 </h3> </caption>
			<tr>
				<td>제목</td>
				<td colspan="2"><%=edto.getTitle()%></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><img src="img/<%=edto.getImg()%>"> <br>
					<%=edto.getContent()%></td>
			</tr>
			<tr>
				<td>기한</td>
				<td><%=edto.getGihan() %></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="목록" onclick="location='list.jsp'">
					<input type="button" value="수정" onclick="location='update.jsp?id=<%=edto.getId()%>'">
					<input type="button" value="삭제" onclick="location='delete.jsp?id=<%=edto.getId()%>'">
				</td>
			</tr>
	</table>
</div>

</body>
</html>