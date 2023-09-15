<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongJiDao" %>
<%@page import="pension.dto.GongJiDto" %>
<%@page import="java.util.*" %>
<%@ include file="../top.jsp" %>
<%
GongJiDao gdao = new GongJiDao();
gdao.list(request);
ArrayList<GongJiDto> list = (ArrayList<GongJiDto>)request.getAttribute("list");
%>
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
		<p> 공지사항  </p>
	</div>
</div>
<div id="section">
	<table width="600" align="center">
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
	</table>
</div>

<%@ include file="../bottom.jsp" %>