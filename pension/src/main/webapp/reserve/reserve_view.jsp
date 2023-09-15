<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%
if(session.getAttribute("userid")== null) {
	response.sendRedirect("../member/login.jsp");
}else {
%>
  <style>
  table {
  	border-collapse:collapse;
  }
  #section {
  	  width:1100px;
  	  height:500px;
  	  margin:auto;
  	  margin-top:50px;
  }
  #section td{
	height:
  }
  #section td a {
  	text-decoration:none;
  	color:black;
  	display:inline-block;
  	width:150px;
  	height:30px;
  	line-height:30px;
  	border:1px solid #cccccc;
  	margin-top:20px;
  }
  </style>
  <script>
  
  </script>
  <div id="section">
  	<%@page import="pension.dao.ReserveDao" %>
  	<%@page import="pension.dto.ReserveDto" %>
  	<%
  	ReserveDao redao = new ReserveDao();
  	redao.reserve_view(request);
  	ReserveDto rdto = (ReserveDto)request.getAttribute("rdto");
  	%> 
  	<table width="700" align="center">
  		<caption> <h3> <%=session.getAttribute("name")%>님의 <%=rdto.getJcode() %> 예약현황 이빈다.</h3></caption>
  			<tr>
  				<td> 입실일 </td>
  				<td> <%=rdto.getInday() %> </td>
  				<td> 퇴실일 </td>
  				<td> <%=rdto.getOutday() %> </td>
  			</tr>
  			<tr>
  				<td>객실명</td>
  				<td><%=rdto.getName()%></td>
  				<td>객실인원</td>
  				<td><%=rdto.getInwon()%></td>
  			</tr>
  			<tr>
  				<td>BBQ패키지</td>
  				<td><%=rdto.getBbq() %></td>
  				<td>숯불패키지</td>
  				<td><%=rdto.getChacol()%></td>
  			</tr>
  			<tr>
  				<td>예약일</td>
  				<td><%=rdto.getWriteday()%></td>
  				<td>총 결제금액</td>
  				<td><%=rdto.getChongprice()%></td>
  			</tr>
  			<tr>
  				<td colspan="4" align="center">
  					<a href=""> 상세예약정보 </a>
  					<a href="reserve.jsp"> 예약 계속하기 </a>
  				</td>
  			</tr>
  	</table>
  	
  </div>
<%} %>
<%@ include file="../bottom.jsp" %>