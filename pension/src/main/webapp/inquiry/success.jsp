<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%
if(session.getAttribute("userid") == null) {
	response.sendRedirect("../member/login.jsp");
}else {
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
  	height:400px;
  	margin:auto;
  	margin-top:80px;
  	padding-bottom:80px;
  	font-family: 'Dovemayo_gothic';
  	font-size:20px;
  	text-align:center;
  }
h2 {
	padding-bottom:20px;
}
.satag {
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
</style>
<script>

</script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> 1:1 문의  </p>
	</div>
</div>
<div id="section">
<h2> 질문작성이 완료되었습니다. 최대한 빠른 답변 드리겠습니다. ♡ </h2> <p>
	<div>
		<a href="../inquiry/mine.jsp" class="satag"> 나의 글</a>
		<a href="../main/index.jsp" class="satag">홈으로</a>
	</div>

</div>

<%@ include file="../bottom.jsp" %>

<%
} // session 관련 괄호닫기
%>