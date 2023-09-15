<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%@page import="pension.dao.RoomDao" %>
<%@page import="pension.dto.RoomDto" %>
<%@page import="pension.util.Util" %>
<%
	RoomDao rdao2 = new RoomDao();
	rdao2.room_view(request); // 방의 id 보내기
	RoomDto rdto = (RoomDto)request.getAttribute("rdto");
%>
  <style>
  #section {
  	width:1100px;
  	height:500px;
  	margin:auto;
  	margin-top:50px;
  }
  </style>
  <script>
  
  </script>
  <div id="section">
 	<table width="800" align="center">
 		<caption>
 			<h3> <%=rdto.getName()%> 객실현황 </h3>
 		</caption>
 			<tr>
 				<td> 기본 인원 </td>
 				<td> <%=rdto.getMin()%> </td>
 				<td> 최대 인원 </td>
 				<td> <%=rdto.getMax()%> </td>
 			</tr>
 				<tr>
 					<td>1박 금액</td>
 					<td><%=Util.comma(rdto.getPrice())%></td>
 					<td colspan="2"> 1인 추가시 10,000원</td>
 				</tr>
 					<tr>
 						<td colspan="4"><%=rdto.getContent()%></td>
 					</tr>
 						<tr>
 							<td colspan="4">
 								<%
 								String[] arrayimg = rdto.getArrayimg();
 								for(int i=0; i < arrayimg.length; i++){ %>
 										<img src="img/<%=arrayimg[i]%>" width="100">
 								<%} %>
 							</td>
 						</tr>
 	</table>
  
  </div>

<%@ include file="../bottom.jsp" %>