<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../menu.jsp" %>
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.ReserveDto" %>
<%@page import="java.util.ArrayList" %>
<%
  AdminDao adao = new AdminDao();
  adao.reserve_list(request);
  ArrayList<ReserveDto> rlist = (ArrayList<ReserveDto>)request.getAttribute("rlist");
%>
<script>

</script>
<div id="section">
	<table width="1000" align="center">
		<tr>
			<td>예약자</td>
			<td>입실일</td>
			<td>퇴실일</td>
			<td>객실명</td>
			<td>인원</td>
			<td>bbq</td>
			<td>숯불</td>
			<td>결제금액</td>
			<td>예약일</td>
			<td>상태</td>
		</tr>
<%for(int i=0;i<rlist.size(); i++) {
			ReserveDto rdto = rlist.get(i);	%>
		<tr>
			<td><%=rdto.getUserid()%></td>
			<td><%=rdto.getInday()%></td>
			<td><%=rdto.getOutday()%></td>
			<td><%=rdto.getName() %></td>
			<td><%=rdto.getInwon()%>명</td>
			<td><%=rdto.getBbq()%>개</td>
			<td><%=rdto.getChacol()%>개</td>
			<td width="90"><%=rdto.getChongprice()%>원</td>
			<td><%=rdto.getWriteday()%></td>
<% 			String state = "";
			switch(rdto.getState()) { 
			case 0: state = "예약중"; break;
			case 1: state = "취소신청"; break;
			case 2: state = "취소완료"; break;
			case 3: state = "이용완료"; break;
			default: state ="ㅇㅅㅇ"; break;  } %>
			<td>
<%if(rdto.getState() == 1){ // 취소신청중일때 => 취소완료%>
<a href="chgstate.jsp?id=<%=rdto.getId()%>" style="color:red;"> <%=state%> </a>
<%}else{ %>
			<%=state%> 
<%} %>
			</td>
		</tr>
<%} %>
	</table>
</div>
</body>
</html>