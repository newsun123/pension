<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongJiDao" %>
<%@page import="pension.dto.GongJiDto" %>
<%@page import="java.util.*" %>
<%
	if(session.getAttribute("userid") == null || !session.getAttribute("userid").equals("admin")) {
	
	response.sendRedirect("../../main/index.jsp");
	} else {
%>
<%
GongJiDao gdao = new GongJiDao();
gdao.list(request);
ArrayList<GongJiDto> list = (ArrayList<GongJiDto>)request.getAttribute("list");
%>
<%@include file="../menu.jsp" %>
<style>
a {
	text-decoration:none;
	color:black;
}
#section {
	width:1100px;
	margin:auto;
	margin-top:100px;
}
</style>
<script>

</script>
<div id="section">
	<table width="600" align="center">
		<caption> <h3> 공지사항 </h3></caption>
			<tr>
				<td>제목</td>
				<td>작성자</td>
				<td>조회수</td>
				<td>공지일</td>
			</tr>
	<%for(int i=0; i< list.size();i++)  { %>
			<tr>
				<td>
		<%if(list.get(i).getStep() == 1) { %>
				[필독]
		<%}%>
		<a href="readnum.jsp?id=<%=list.get(i).getId()%>"><%=list.get(i).getTitle()%></a>
				</td>
				<td>관리자</td>
				<td><%=list.get(i).getReadnum()%></td>
				<td><%=list.get(i).getWriteday()%></td>
			</tr>
	<%}  %>
			<tr>
				<td colspan="4" align="center">
					<a href="write.jsp">등록하기</a>
				</td>
			</tr>
	</table>
</div>
<%} %>