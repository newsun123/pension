<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.RoomDao" %>
<%@page import="pension.dto.RoomDto" %>
<%@page import="java.util.*" %>
<%
	RoomDao rdao = new RoomDao();
	rdao.getRoom(request);
	ArrayList<RoomDto> rlist = (ArrayList<RoomDto>)request.getAttribute("rlist");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
a {
	text-decoration:none;
	color:black;
}
body {
	margin:0;
	overflow-x: hidden;
}
#fouter {
	width:100%;
	background:#cccccc;
}
#first {
	width:1100px;
	height:30px;
	margin:auto;
	text-align:center;
	line-height:30px;
	font-family: 'Dovemayo_gothic';
	font-size:15px;
}
#left {
	display:inline-block;
}
#right {
	display:inline-block;
	float:right;
	cursor: pointer;
}
#second {
	width: 1100px;
    height: 25px;
    margin: auto;
    text-align: right;
    font-size: 14px;
    line-height: 25px;
    position:relative;
    font-family: 'Dovemayo_gothic';
    font-size:16px;
}
#second #mypage_sub {
	list-style-type: none;
	display:inline-block;
	width: 90px;
    background: rgb(255, 255, 255);
    position: absolute;
    top: 7px;
    left: -7px;
    padding: 0px;
	padding-top: 5px;
	visibility:hidden;
}
#second #mypage{
	position: relative;
	cursor:pointer;
}
#second #mypage_sub li {
	margin-top:-10px;
	text-align: center;
    padding: 4px 0;
    cursor:pointer;
}
#third {
	width: 100%;
	height: 103.63px;
	margin:auto;
	display:flex;
	font-family: 'Dovemayo_gothic';
}
#third #logo {
	margin-left:auto;
}
#third ul {
	margin:auto;
	padding:0;
	display:flex;
	margin-left:10px; 
	cursor:pointer;
}
#third .main {
	list-style-type: none;
    position: relative;
    line-height: 30px;
    width: 215px;
    font-size: 20px;
    text-align: center;
    margin-top:70px;
}
#third .sub {
	list-style-type:none;
	display:block;
	position:absolute;
 	visibility:hidden;
	background:#F7F7F7;
	margin-left:-1px;
	margin-top: 2px;
	z-index:10;

}
#third .main .sub li {
	width:215px;
	height:40px;
	line-height:38px;
}
</style>
<script>
	function hide() {
		document.getElementById("first").style.display="none";
		document.getElementById("fouter").style.display="none";
	}
   	function menuview(n) {
		document.getElementsByClassName("sub")[n].style.visibility="visible";
	}
	function menuhide(n) {
		document.getElementsByClassName("sub")[n].style.visibility="hidden";
	}    
	
	function mypageview() {
		document.getElementById("mypage_sub").style.visibility="visible";
	}
	function mypagehide() {
		document.getElementById("mypage_sub").style.visibility="hidden";
	}
</script>
</head>
<body>
<div id="fouter">
	<div id="first">
		<div id="left">펜션 기념 1박 50,000원!</div>
		<div id="right"><img src="../img/x.png" width="15" onclick="hide()"></div>
	</div>
</div>
	<div id="second">
<%if(session.getAttribute("userid") == null) {%>
		<a href="../member/login.jsp">로그인</a> l <a href="../member/member.jsp">회원가입</a>
		l
<%}else if(session.getAttribute("userid").equals("admin")){ //관리자인가 아닌가 체크%>
<%=session.getAttribute("name")%>님 l <a href="../member/logout.jsp">로그아웃</a>
		l <a href="../admin/main/index.jsp"> 관리자 페이지 </a>
<%}else { %>
<%=session.getAttribute("name")%>님 l <a href="../member/logout.jsp">로그아웃</a>
		l <span id="mypage" onmouseover="mypageview()" onmouseout="mypagehide()"> 마이 페이지
			<ul id="mypage_sub">
				<li><a href="../member/member_view.jsp">회원정보</a></li>
				<li><a href="../reserve/my_reserve.jsp">예약 정보</a></li>
				<li><a href="../inquiry/mine.jsp">나의 글</a></li>
			</ul>
		</span>
<%} %>
		l <a href="../inquiry/write.jsp"> 1:1문의</a>
	</div>
</div>
<div id="third">
	<div id="logo">
		<a href="../main/index.jsp"><img src="../img/pension_logo.png" width="190"></a>
	</div>
	<ul>
		<li class="main" onmouseover="menuview(0)" onmouseout="menuhide(0)">펜션소개
			<ul class="sub">
				<li>인사말</li>
				<li>오시는 길</li>
			</ul>
		</li>
		<li class="main" onmouseover="menuview(1)" onmouseout="menuhide(1)">객실현황
			<ul class="sub">
			<% for(int i = 0; i < rlist.size(); i++) { %>
     			<li>
     	 			<a href="../room/room_view.jsp?id=<%=rlist.get(i).getId()%>"><%=rlist.get(i).getName()%></a> 
     	 		</li>
     	 	<% } %>
			</ul>
		</li>
		<li class="main" onmouseover="menuview(2)" onmouseout="menuhide(2)">주변관광
			<ul class="sub">
				<li> 만리포 해수욕장 </li>
	     		<li> 꽃지 해수욕장 </li>
	     		<li> 태안 불빛축제 </li>
	     		<li> 안흥 낚시체험 </li>
	     		<li> 신진도 투어 </li>
			</ul>
		</li>
		<li class="main" onmouseover="menuview(3)" onmouseout="menuhide(3)">예약문의
			<ul class="sub">
				<li>예약 안내</li>
				<li><a href="../reserve/reserve.jsp">실시간 예약</a></li>
			</ul>	
		</li>
		<li class="main" onmouseover="menuview(4)" onmouseout="menuhide(4)">커뮤니티
			<ul class="sub">
	     		<li> <a href="../event/list.jsp">이벤트 게시판</a> </li>
				<li> <a href="../board/list.jsp">자유 게시판</a> </li>
	     		<li> <a href="../hugi/list.jsp">여행 후기</a> </li>
	     		<li> <a href="../gongji/list.jsp">공지 사항</a> </li>
			</ul>
		</li>
	</ul>
</div>










