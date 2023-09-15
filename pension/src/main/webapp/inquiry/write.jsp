<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../top.jsp" %>
<%
if(session.getAttribute("userid") == null) {
	response.sendRedirect("../member/login.jsp");
}else {
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
  form {
  	display:block;
  	text-align:center;
  }
  input[type=submit] {
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
select {
  	width: 423px;
    height: 30px;
    border: 2px solid #ccc;
    border-radius: 5px;
    text-align: center;
    font-family: 'Dovemayo_gothic';
    font-size:20px;
}
textarea {
  	width: 415px;
    height: 308px;
    border: 2px solid #ccc;
    border-radius: 5px;
    text-align: center;
    margin-top:20px;
    font-family: 'Dovemayo_gothic';
    font-size:20px;
}
#len {
    font-family: 'Dovemayo_gothic';
    font-size:14px;
    color:#cccccc;
    text-align:right;
	padding-left: 385px;
}
</style>
<script>
function lencheck(my) {
	var len = my.value.length;
	document.getElementById("len").innerText = len+"/200";
}
function check(my) {
	if(my.content.value.trim() == "" ) {
		alert("글을 작성하세요");
		my.content.focus();
		return false;
	}else {
		return true;
	}
}
</script>
  <div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> 1:1 문의 </p>
	</div>
</div>
<div id="section"><!-- 1:1문의 적기 -->
	<form method="post" action="write_ok.jsp" onsubmit="return check(this)">	
		<div class="inq"> 
			<select name="title">
				<option value="0">예약 관련</option>
				<option value="1">객실 관련</option>
				<option value="2">뷔페 관련</option>
				<option value="3">할인 관련</option>
				<option value="4">관광 관련</option>
			</select>
		</div>
		<div class="inq">
			<textarea name="content" placeholder="1:1문의사항을 적어주세요" maxlength="200" onkeyup="lencheck(this)"></textarea> <br>
				<span id="len">0/200</span>
		</div>
		<div class="inq"> <input type="submit" value="문의하기"> </div>
	</form>
</div>
<%@ include file="../bottom.jsp" %>
<%}%>