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
	bdao.list(request); 
	BoardDto bdto = new BoardDto();
	ArrayList<BoardDto> blist = (ArrayList<BoardDto>)request.getAttribute("blist");
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
  input[type=button] {
	background: gainsboro;
    border-radius: 5px;
    padding: 5px 10px;
    border: none;
    margin-top: 20px;
    width: 106px;
    height: 35px;
    font-size: 20px;
    font-family: 'Dovemayo_gothic';
   	cursor:pointer;
}
  table {
  	border-collapse: collapse;
  }
  table tr {
	border-bottom: 2px solid #ccc;
	height:30px;
  }
  #page {
  	text-decoration:none;
  	color:black;
  	font-size:12px;
  }
  .xb {
  border:none;
  }
  </style>
  <script>
  
  </script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> 자유게시판  </p>
	</div>
</div>
  <div id="section">
    <table width="800" align="center">
	    	<tr>
	    		<td>제목</td>
	    		<td>조회수</td>
	    		<td>작성일</td>
	    	</tr>
	    <%for(int i=0;i<blist.size();i++) { %>
	    	<tr >
	    		<td><a href="readnum.jsp?id=<%=blist.get(i).getId()%>"><%=blist.get(i).getTitle()%></a></td>
	    		<td><%=blist.get(i).getReadnum()%></td>
	    		<td><%=blist.get(i).getWriteday()%></td>
	    	</tr>
	   <%} %>
	   <%
	   // 페이지 이동 만들기
	   int pager = bdao.getPager(request);
	   int pstart = bdao.getPstart(request);
	   int chong = bdao.getChong();
	   int pend = bdao.getPend(pstart, chong);
	   %>
	   		<tr>
	   			<td colspan="3" align="center" id="page" style="font-size:18px;">
	   			<!-- 첫페이지 이동 -->
	   				<a href="list.jsp?pager=1">맨 앞으로</a>
	   			<!-- 현재출력 페이지 이전으로 이동 -->
	   <% if(pstart != 1) { %>
	   				<a href="list.jsp?pager=<%=pstart-1%>"> << </a>
	   <%}else { %>
	   				<<  <!-- 1페이지일때는 고정 -->
	   <%} %>	
	   			<!-- 현재 페이지에서 뒤로 한칸 이동 -->
	   <% if(pager != 1) {%>
	   				<a href="list.jsp?pager=<%=pager-1%>"> < </a>
	   <%}else { %>
	   				<
	   <%} %>
	   			<!-- 페이지 갯수 및 현재 페이지 나타내기 -->
	   <%for(int i=pstart;i<=pend;i++) {
		   String str = ""; 
		   if(pager==i) {
			   str="style='color:red';";
		   } %>
		   			<a href="list.jsp?pager=<%=i%>" <%=str%>> <%=i%> </a>
	   <%}%>
	   			<!-- 현재페이지에서 앞으로 한칸 이동 -->
	   <%if(pager != chong) { %>
	   				<a href="list.jsp?pager=<%=pager+1%>"> > </a>
	   <%}else { %>
	   				>
	   <%} %>
	   			<!-- 현재페이지에서 다음 페이지그룹으로 이동 -->
	   <%if(pend != chong) { %>
	   				<a href="list.jsp?pager=<%=pend+1%>"> >> </a>
	   <%}else { %>
	   				>>
	   <%} %>
	   			<!-- 마지막페이지 이동 -->
	   				<a href="list.jsp?pager=<%=chong%>"> 맨 뒤로 </a>
	   			</td>
	   		</tr>
	   		<tr class="xb">
	   			<td colspan="3" align="center" height="40px"> <input type="button" value="게시글작성" onclick="location='write.jsp'"> </td>
	   		</tr>
    </table>
  </div>

<%@ include file="../bottom.jsp" %>

<%
} // session 관련 괄호닫기
%>