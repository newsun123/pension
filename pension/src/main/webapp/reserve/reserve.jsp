<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.time.LocalDate" %>
<%@page import="pension.dao.ReserveDao" %>
<%@include file="../top.jsp" %>
<%@page import="pension.dao.RoomDao" %>
<%@page import="pension.util.Util" %>
<style>
a {
	text-decoration:none;
	color:black;
}
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
  	font-family: 'Dovemayo_gothic';
  	font-size:20px;
  }
#section table caption {
	font-size:20px;
	height:80px;
}
#section table {
	border-collapse: collapse;
	font-size:20px;
}
#section table td {
	font-size:18px;
}
</style>
<%
ReserveDao rdao2 = new ReserveDao();
rdao2.getCalendar(request);

int yoil = (int)request.getAttribute("yoil");
int chong = (int)request.getAttribute("chong");
int ju = (int)request.getAttribute("ju");
int year = (int)request.getAttribute("year");
int month = (int)request.getAttribute("month");
%>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> 실시간 예약  </p>
	</div>
</div>
<div id="section">
<table width="1100" height="600" align="center" border="1">
<caption>
	<h3>
		<a href="reserve.jsp?year=<%=year%>&month=<%=month-1%>"> ← </a>
		<%=year%>년 <%=month%>월
		<a href="reserve.jsp?year=<%=year%>&month=<%=month+1%>"> → </a>
	</h3>
</caption>
<tr height="30">
	<td>일</td>
	<td>월</td>
	<td>화</td>
	<td>수</td>
	<td>목</td>
	<td>금</td>
	<td>토</td>
</tr>
<% 
//방의 정보를 구해오기 => 객실명+id
RoomDao rdao3 = new RoomDao();
rdao3.getRoom(request);
ArrayList<RoomDto> rlist3 = (ArrayList<RoomDto>)request.getAttribute("rlist");

//달력 칸 자동화
int day =1;
for(int i=1; i <=ju; i++) {
	%>
	<tr> <!-- <%=i%>행 -->
		<% for(int j=0; j<7; j++) { 
			if((j < yoil && i == 1) || (chong < day)) {  // 1일 이전 빈칸, 총일수보다 큰 숫자도 빈칸
		%>
		<td> &nbsp; </td>
		<%   } else { %>
		<td> 
			<p align="left"> <%=day%> </p>
			<!-- 방 출력 -->
	<% boolean kk = Util.isCheck(year, month, day); 
	if(!kk){
	 for(int k=0; k <rlist3.size(); k++) { 
			
			//?년?월?일 특정방이 예약되었느냐를 검사 - boolean은 참거짓이므로 if안에 이것만 적음 됌
			boolean chk = rdao2.isEmpty(year, month, day, rlist3.get(k).getId());
			if(chk) {
		%>
			<a href="reserve_next.jsp?year=<%=year%>&month=<%=month%>&day=<%=day%>&id=<%=rlist3.get(k).getId()%>"><%=rlist3.get(k).getName()%> </a> <br>
		<%  }else { %>	
			<span style="color:red"> <%=rlist3.get(k).getName()%></span> <br>
		<% 		} 
			}
	}
		%>
		</td>
		<%  day++; }
			
		} %>
	</tr>
<%} %>
</table>
</div>

<%@include file="../bottom.jsp" %>