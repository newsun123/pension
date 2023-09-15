<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%@page import="pension.dao.EventDao" %>
<%@page import="pension.dto.EventDto" %>
<%
if(session.getAttribute("userid") == null) {
	response.sendRedirect("../member/login.jsp");
}else {
	  EventDao edao = new EventDao();
	  edao.list(request);
	  ArrayList<EventDto> elist = (ArrayList<EventDto>)request.getAttribute("elist");
%>
<style>
#bgimg{
	width:100%;
	height:320px;
	background-position: 0 0;
	background-attachment: scroll;
	background-repeat: no-repeat;
	background-size: cover;
	background-image: url("../img/santo.jpg");
	position:relative;
	font-family: 'Dovemayo_gothic';
	font-weight: bold;
}
#bgimg #bgtxt{
	position: absolute;
	text-align: center;
	top: 60%;
	left: 50%;
	transform: translate(-50%, -60%);
}
#bgimg p{
	color:#fff;
	font-family: 'ChosunGs';
	margin: 0;
	font-size: 30px;
	margin-bottom: 15px;
}
  #section {
  width:1100px;
  height:300px;
  margin:auto;
  margin-top:80px;
  padding-bottom:80px;
  }
table {
	font-family: 'Dovemayo_gothic';
	font-size:20px;
	text-align:center;
	border-spacing:0px;
}
table td {
	border-bottom:2px solid #ccc;
	
}
#section {
	margin-top: 80px;
	padding-bottom:80px;
}
table {
	font-family: 'Dovemayo_gothic';
	font-size:20px;
}
table tr {
	border-bottom:2px solid #ccc;
}
</style>
<script>

</script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> Event Board  </p>
	</div>
</div>
<div id="section">
		<table width="500" align="center">
				<tr>
					<td>제목</td>
					<td>작성일</td>
					<td>기한</td>
				</tr>
				<%for(int i=0;i<elist.size(); i++) {%>
					<tr>
						<td><a href="content.jsp?id=<%=elist.get(i).getId()%>"><%=elist.get(i).getTitle()%></a></td>
						<td><%=elist.get(i).getWriteday()%></td>
						<td><%=elist.get(i).getGihan()%></td>
					</tr>
				<%} %>

		</table>
</div>

<%@ include file="../bottom.jsp" %>

<%
} // session 관련 괄호닫기
%>