<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../menu.jsp" %>
<%@page import="pension.dto.EventDto" %>
<%@page import="pension.dao.EventDao" %>
<%@page import="java.util.ArrayList" %>
<%
  EventDao edao = new EventDao();
  edao.list(request);
  ArrayList<EventDto> elist = (ArrayList<EventDto>)request.getAttribute("elist");
%>
<style>
table {
	margin-top:20px;
}
</style>
<div id="section">
		<table width="600" align="center">
			<caption><h3>이벤트</h3></caption>
				<tr>
					<td>제목</td>
					<td>작성일</td>
				</tr>
				<%for(int i=0;i<elist.size(); i++) {%>
					<tr>
						<td><a href="content.jsp?id=<%=elist.get(i).getId()%>"><%=elist.get(i).getTitle()%></a></td>
						<td><%=elist.get(i).getWriteday()%></td>
					</tr>
				<%} %>
				<tr>
					<td colspan="2" algin="center">
						<input type="button" value="작성" onclick="location='write.jsp'">
					</td>
				</tr>
		</table>
</div>
</body>
</html>