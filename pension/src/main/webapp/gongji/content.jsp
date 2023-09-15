<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="pension.dao.GongJiDao" %>
<%@page import="pension.dto.GongJiDto" %>
<%@ include file="../top.jsp" %>
<%
	GongJiDao gdao = new GongJiDao();
	gdao.content(request);
	GongJiDto gdto = (GongJiDto) request.getAttribute("gdto");
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
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> 공지사항  </p>
	</div>
</div>
<div id="section">
	<table width="800" align="center">
			<tr>
				<td class="a">제목</td>				
				<td><%=gdto.getTitle()%></td>				
			</tr>	
			<tr>
				<td class="a">작성일</td>				
				<td><%=gdto.getWriteday()%></td>				
			</tr>	
			<tr>
				<td class="a">조회수</td>				
				<td><%=gdto.getReadnum()%></td>				
			</tr>	
			<tr>
				<td class="a">내용</td>				
				<td><%=gdto.getContent()%></td>				
			</tr>	
			<tr>
				<td colspan="2" align="center" class="tbx">
					<input type="button" value="뒤로가기" onclick="location='list.jsp'">
				</td>								
			</tr>	
	</table>
</div>
<%@ include file="../bottom.jsp" %>