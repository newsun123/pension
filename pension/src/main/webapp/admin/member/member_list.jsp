<%@page import="pension.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../menu.jsp"%>
<%@page import="pension.dao.AdminDao"%>
<%@page import="pension.dto.MemberDto" %>
<%@page import="java.util.*" %>
<%
AdminDao adao = new AdminDao();
adao.memeber_list(request);
ArrayList<MemberDto> mlist = (ArrayList<MemberDto>)request.getAttribute("mlist");
%>
<div id="section">
	<table width="900" align="center">
		<tr>
			<td>이름</td>
			<td>아이디</td>
			<td>전화번호</td>
			<td>이메일</td>
			<td>가입일</td>
			<td>이용횟수</td>
			<td>총이용금액</td>
		</tr>
	<%
	for(int i=0; i < mlist.size(); i++) {
		int chong = adao.getChong(mlist.get(i).getUserid());
		int count = adao.getCount(mlist.get(i).getUserid());
	%>
		<tr>
			<td><%=mlist.get(i).getName()%></td>
			<td><%=mlist.get(i).getUserid()%></td>
			<td><%=mlist.get(i).getPhone()%></td>
			<td><%=mlist.get(i).getEmail()%></td>
			<td><%=mlist.get(i).getWriteday()%></td>
			<td><%=Util.comma(count)%>번</td>
			<td><%=Util.comma(chong)%>원</td>
		</tr>
	<%} %>
	</table>
</div>
</body>
</html>

<%
adao.myclose();
%>