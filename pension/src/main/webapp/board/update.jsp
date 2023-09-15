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
  	text-align:center;
  }
  input[type=submit] {
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
  #section input[type=text] {
  	width: 405px;
    height: 40px;
    font-size: 15px;
    border: 3px solid #ccc;
    margin-left: -3px;
  }
  #section textarea {
	width: 405px;
    height: 200px;;
    border: 3px solid #ccc;
  }
  #section .msg {
  	margin-top:20px;
  }
  </style>
  <script>
  	function check(my) {
  		//제목과 글을 체크하는 것 추가하기
  	}
  </script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> 수정하기  </p>
	</div>
</div>
  <div id="section">
  	<form method="post" action="update_ok.jsp" onsubmit="return check(this)">
  	<input type="hidden" name="id" value="<%=bdto.getId()%>">
  	<%if(request.getParameter("mychk") != null) { %>
  	<input type="hidden" name="mychk" value="<%=request.getParameter("mychk")%>"> <!-- 값을 request로 하면 더 좋다. -->
  	<%} %>
  			<div class="msg"><input type="text" name="title" placeholder=" 제 목 " value="<%=bdto.getTitle()%>"></div> 
  			  <div class="msg"><textarea name="content" placeholder=" 내 용 "><%=bdto.getContent()%></textarea></div>
    			  <div class="msg"><input type="submit" value="수정"></div>
  	</form>
  </div>

<%@ include file="../bottom.jsp" %>

<%
} // session 관련 괄호닫기
%>