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
	edao.user_content(request);
	EventDto edto = (EventDto)request.getAttribute("edto");
	
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
table {
	font-family: 'Dovemayo_gothic';
	font-size:20px;
}
#bgimg p{
	color:#fff;
	font-family: 'ChosunGs';
	margin: 0;
	font-size: 30px;
	margin-bottom: 15px;
}
#section {
	margin-top:80px;
	padding-bottom: 80px;
}
table .tdb {
	border-bottom: 2px solid #ccc;
}
input[type=button] {
	background: gainsboro;
    border-radius: 5px;
    padding: 5px 10px;
    border: none;
    margin-top: 20px;
    width: 80px;
    height: 35px;
    font-size: 20px;
    font-family: 'Dovemayo_gothic';
   	cursor:pointer;
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
	<table width="400"	 align="center">
			<tr>
				<td align="center" class="tdb"><%=edto.getTitle()%></td>
			</tr>
			<tr>
				<td align="center" class="tdb"><%=edto.getWriteday()%> ~ <%=edto.getGihan()%> 까지</td>
			</tr>
			<tr>
				<td align="center" class="tdb"><img src="../admin/event/img/<%=edto.getImg()%>" width="390"> <br>
					<%=edto.getContent()%></td>
			</tr>
			<tr>
				<td align="center">
					<input type="button" value="목록" onclick="location='list.jsp'">
				</td>
			</tr>
	</table>
</div>
<%@ include file="../bottom.jsp" %>

<%
} // session 관련 괄호닫기
%>