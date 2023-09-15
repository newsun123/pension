<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%@page import="pension.dao.InquiryDao" %>
<%@page import="pension.dto.HugiDto" %>
<%@page import="pension.dto.BoardDto" %>
<%@page import="pension.dto.InquiryDto" %>
<%
	InquiryDao idao = new InquiryDao();
	idao.mine(request,session);
	
	ArrayList<BoardDto> blist = (ArrayList<BoardDto>)request.getAttribute("blist");
	ArrayList<HugiDto> hlist = (ArrayList<HugiDto>)request.getAttribute("hlist");
	ArrayList<InquiryDto> ilist = (ArrayList<InquiryDto>)request.getAttribute("ilist");
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
  	font-family: 'Dovemayo_gothic';
  	font-size:20px;
  }
    table {
  	border-collapse: collapse;
  }
  table tr {
	border-bottom: 2px solid #ccc;
	height:30px;
  }
</style>
<script>

</script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> 나의 글  </p>
	</div>
</div>
<div id="section">
	<table width="700" align="center">
		<caption> <h3> 회원게시판</h3> </caption>
	<% for(int i=0; i < blist.size();i++) { %>
			<tr> 							<!-- mychk : 나의글에서 게시판으로 갈 때 목록 클릭시 돌아오게 할 것. -->
				<td> <a href="../board/content.jsp?mychk=1&id=<%=blist.get(i).getId()%>"> <%=blist.get(i).getTitle()%> </a></td>
				<td width="100"> <%=blist.get(i).getReadnum()%> </td>
				<td width="100"> <%=blist.get(i).getWriteday()%> </td>
			</tr>
	<% } %>
	</table>
	<table width="700" align="center">
		<caption> <h3> 후기게시판</h3> </caption>
	<% for(int i=0; i < hlist.size();i++) { %>
			<tr>
				<td> <a href="../hugi/content.jsp?mychk=1&id=<%=hlist.get(i).getId()%>"> <%=hlist.get(i).getTitle()%> </a> </td>
				<td width="100"> <%=hlist.get(i).getReadnum()%> </td>
				<td width="100"> <%=hlist.get(i).getWriteday()%> </td>
			</tr>
	<% } %>
	</table>
	<table width="700" align="center">
		<caption> <h3> 1:1문의</h3> </caption>
	<%
	for (int i = 0; i < ilist.size(); i++) {
		String title = "";
		switch (ilist.get(i).getTitle()) {
		case 0:
			title = "예약 관련";
			break;
		case 1:
			title = "객실 관련";
			break;
		case 2:
			title = "뷔페 관련";
			break;
		case 3:
			title = "할인 관련";
			break;
		case 4:
			title = "관광 관련";
			break;
		}
		String state;
		if(ilist.get(i).getState() == 0	) {
			state="답변 대기";
		}else {
			state=ilist.get(i).getAnswer().replace("\r\n", "<br>");
		}
	%>
			<tr>
				<td> <%=title%> </td>
				<td width="100"> <%=state%> </td>
				<td width="100" style="overflow:auto;"> <%=ilist.get(i).getWriteday()%> </td>
			</tr>
	<% } %>
	</table>
</div>

<%@ include file="../bottom.jsp" %>