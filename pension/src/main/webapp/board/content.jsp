<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%@page import="pension.dao.BoardDao" %>
<%@page import="pension.dto.BoardDto" %>
<%
if(session.getAttribute("userid") == null) {
	response.sendRedirect("../member/login.jsp");
}else {
	BoardDao bdao = new BoardDao();
	bdao.content(request); 
	BoardDto bdto = (BoardDto)request.getAttribute("bdto");
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
.tbx {
	border-bottom:none;
}
  </style>
  <script>
  
  </script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> ROOM  </p>
	</div>
</div>
  <div id="section">
  	<table width="600" align="center">
  		<tr>
  			<td>제목</td>
  			<td><%=bdto.getTitle()%></td>
  		</tr>
  		<tr>
  			<td>작성자</td>
  			<td><%=bdto.getUserid()%></td>
  		</tr>
  		<tr>
  			<td>조회수</td>
  			<td><%=bdto.getReadnum()%></td>
  		</tr>
  		<tr>
  			<td>작성일</td>
  			<td><%=bdto.getWriteday()%></td>
  		</tr>
  		<tr>
  			<td>내용</td>
  			<td><%=bdto.getContent()%></td>
  		</tr>
  		<tr>
  			<td colspan="2" class="tbx"> 
  		<% // 다른 유저가 수정 삭제를 방지하기 위한 코드  + if문을 사용하여 mine에서 수정하고 삭제하기
  		if(bdto.getUserid().equals(session.getAttribute("userid").toString()) || session.getAttribute("userid").equals("admin")) { 
  			if(request.getParameter("mychk") == null) {
  		%>
  				<input type="button" value="수정" onclick="location='update.jsp?id=<%=bdto.getId()%>'"> 
  				<input type="button" value="삭제" onclick="location='delete.jsp?id=<%=bdto.getId()%>'">
  		<% }else { %>
  				<input type="button" value="수정" onclick="location='update.jsp?mychk=1&id=<%=bdto.getId()%>'"> 
  				<input type="button" value="삭제" onclick="location='delete.jsp?mychk=1&id=<%=bdto.getId()%>'">
  		<%} %>
  		<%} %>
  		
  		
  		
  		
  		
  		<% if(request.getParameter("mychk") == null) { //mine에서 온건가 board에서 온건가 확인하는 코드  %>
  			 <input type="button" value="뒤로가기" onclick="location='list.jsp'">		
  		<% } else { %>
  			 <input type="button" value="뒤로가기" onclick="location='../inquiry/mine.jsp'">	
  		<% } %>	
  			  </td>
  		</tr>
  	</table>
  </div>

<%@ include file="../bottom.jsp" %>

<%
} // session 관련 괄호닫기
%>