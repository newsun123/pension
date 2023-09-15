<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../menu.jsp" %>
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.InquiryDto" %>
<%@page import="java.util.*" %>
<%
AdminDao adao = new AdminDao();
adao.inquiry_list(request); 
ArrayList<InquiryDto> ilist = (ArrayList<InquiryDto>)request.getAttribute("ilist");
%>
<style>
#section {
    width:1100px;
    margin:auto;
  }
 #section table {
     border-spacing:0px;
   }
   #section table tr:hover {
      background:#eeeeee;
   }
   #section table tr:first-child:hover {
      background:white;
   }
 
   #section table td {
     height:34px;
     font-size:13px;
     border-bottom:1px solid purple;
   }
   #section table tr:first-child td {
     border-top:2px solid purple;
     font-weight:900;
   }
   #section table tr:last-child td {
     border-bottom:2px solid purple;
   }
   .inquiry , .answer {
     width:300px;
     height:80px;
     overflow:auto;
   }
   #section textarea {
   	width:220px;
   	height:74px;
   	vertical-align:middle;
   }
   #section input[type=submit] {
   width:40px;
   height:74px;
   }
</style>
<div id="section">
	<table width="900" align="center">
		<tr>
			<td widt="90">작성자</td>
			<td>문의주제</td>
			<td width="300">문의내용</td>
			<td width="300">답변내용</td>
			<td>작성일</td>
		</tr>
<%for(int i=0; i<ilist.size();i++) { %>
		<tr>
			<td><%=ilist.get(i).getUserid()%></td>
<% String title="";
switch(ilist.get(i).getTitle()) { 
case 0 : title ="예약 관련"; break;
case 1 : title ="객실 관련"; break;
case 2 : title ="뷔페 관련"; break;
case 3 : title ="할인 관련"; break;
case 4 : title ="관광 관련"; break;

}%>
			<td><%=title%></td>
			<td><div class="inquiry"><%=ilist.get(i).getContent()%></div></td>
			<td>
<%if(ilist.get(i).getState() == 0) { %>
			<form method="post" action="inquiry_ok.jsp">
				<input type="hidden" name="id" value="<%=ilist.get(i).getId()%>">
				<textarea name="answer" placeholder="답변입력"></textarea>
				<input type="submit" value="save">
			</form>
<%}else { %>
			<div class="answer">
				<%=ilist.get(i).getAnswer().replace("\r\n", "<br>")%>
			</div>
<%} %>			
			</td>
			<td><%=ilist.get(i).getWriteday()%></td>
		</tr>
<%} %>
	</table>
</div>
</body>
</html>