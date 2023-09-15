<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp" %>
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
    margin-top:40px;
  }
  #section div {
  	margin-top:10px; /* 단 간격 */
  	font-size: 24px;
  }
  #section #msg {  /* 오류메세지 css */
  	line-height:30px;
  	text-align:center;
  	margin:auto;
  	font-size:12px;
  	color:red;
  }
  .a {
  	width: 250px;
    height: 30px;
    border: 1px solid #00C935;
    outline: none;
    border-radius: 5px;
  }
  input[type=submit] {
  	background: none;
    height: 34px;
    width: 257px;
    font-size: 20px;
    font-family: 'Dovemayo_gothic';
  }

</style>
<script>
  function formcheck(my) { //submit시 한번더 체크
	  if(my.userid.value== ""){
		  alert("아이디를 입력하세요");
		  return false;
	  }else if(my.pwd.value == "") {
		  alert("비밀번호를 입력하세요");
	  }else {
		  return true;
	  }
  }
</script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> Login  </p>
	</div>
</div>
<div id="section"> <!-- 탑/바텀 넣은 후 본 위치라는 표현으로 section을 넣음 -->
<form method="post" action="login_ok.jsp" onsubmit="return formcheck(this)">
<%
if(request.getParameter("year")!= null){  // 이 메소드로 인해 로그인 후 이동 오류가 나지 않음
%>
<input type="hidden" name="year" value="<%=request.getParameter("year")%>">
<input type="hidden" name="month" value="<%=request.getParameter("month")%>">
<input type="hidden" name="day" value="<%=request.getParameter("day")%>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<%} %>
  <div align="center">
     <input type="text" name="userid" class="a">
  </div>
  <div align="center"> 
     <input type="password" name="pwd" class="a"> 
  </div>
  <div align="center" id="sbit">  
     <input type="submit" value="로그인" class="a"> 
  </div>
  <%if(request.getParameter("cyd") != null) { %>
  <div id="msg"> 아이디 혹은 비밀번호가 틀립니다. </div>
  <%} %>
</form>
</div>

<%@include file="../bottom.jsp" %>