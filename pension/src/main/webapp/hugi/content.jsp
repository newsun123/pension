<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%@page import="pension.dao.HugiDao" %>
<%@page import="pension.dto.HugiDto" %>
<%@page import="java.util.ArrayList" %>
<%
HugiDao hdao = new HugiDao();
hdao.content(request); 
HugiDto hdto = (HugiDto)request.getAttribute("hdto");
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
<%
String[] arrayimg = hdto.getArryimg();
String imsi = "";
for(int i=0; i <arrayimg.length; i++) {
	imsi=imsi+"'"+arrayimg[i]+"'";
	if(i != arrayimg.length-1) {
		imsi = imsi+",";
	}
}
%>

var img = [<%=imsi%>];
var imgindex=0;

function left() {
	imgindex--;
	if(imgindex<0) {
		imgindex = img.length-1;
	}
	document.getElementById("himg").src="img/"+img[imgindex];
}

function right() {
	imgindex++;
	if(imgindex == img.length) {
		imgindex = 0;
	}
	document.getElementById("himg").src = "img/"+img[imgindex];
}
</script>
<div id="section">
	<table width="1000" align="center">
		<caption><h3>후기 게시판</h3></caption>
			<tr>
				<td>제목</td>
				<td><%=hdto.getTitle()%></td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><%=hdto.getWriteday()%></td>
			</tr>
			<tr>
				<td>조회수</td>
				<td><%=hdto.getReadnum()%></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><%=hdto.getContet()%></td>
			</tr>
	<!-- 이미지 삽입하기 -->
			<tr>
				<td colspan="2" align="center">
				<%if(!hdto.getArryimg()[0].equals("")) { %>
					<input type="button" value="이전" onclick="left()">
						<img id="himg" src="img/<%=hdto.getArryimg()[0]%>" valign="middle" width="600">
					<input type="button" value="다음" onclick="right()">
				<%} %>
				</td>
			</tr>
	<!-- 수정 삭제 목록 + 다른 유저 삭제 방지 코드 -->
			<tr>
				<td colspan="2" align="center" class="tbx">
		<% // 다른 유저가 수정 삭제를 방지하기 위한 코드 
  		if(hdto.getUserid().equals(session.getAttribute("userid").toString()) || session.getAttribute("userid").equals("admin")) {
  			if(request.getParameter("mychk") == null) {  // mine에서 오는지 hugi에서 오는지
  			%>
  			<input type="button" value="수정" onclick="location='update.jsp?id=<%=hdto.getId()%>'"> 
  			<input type="button" value="삭제" onclick="location='delete.jsp?id=<%=hdto.getId()%>'">
  		<% }else { %>
  			<input type="button" value="수정" onclick="location='update.jsp?mychk=1&id=<%=hdto.getId()%>'"> 
  			<input type="button" value="삭제" onclick="location='delete.jsp?mychk=1&id=<%=hdto.getId()%>'">  			
  		<%}
  		}
  		%>
  		<%if(request.getParameter("mychk") == null) { // mine에서 오는지 hugi에서 오는지 확인%>
  					<input type="button" value="뒤로가기" onclick="location='list.jsp'">
  		<%} else { %>
  					<input type="button" value="뒤로가기" onclick="location='../inquiry/mine.jsp'">
  		<%} %>
				</td>
			</tr>
	</table>
</div>

<%@ include file="../bottom.jsp" %>