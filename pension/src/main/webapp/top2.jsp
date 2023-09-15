<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  a {
    text-decoration:none;
    color:black;  
  }
  body {
    margin:0px;
  }
  #fouter{
    width:100%;
    height:30px;
    background:#cccccc;
  }
  #first {
    width:1100px;
    height:30px;
    line-height:30px;
    margin:auto;
    background:#cccccc; 
  }
  #first #left {
    width:1050px;
	display:inline-block;
    text-align:center; 
  }
  #first #right {
    width:40px;
	display:inline-block;
	text-align:right;
  }
  #second {
    width:1100px;
    height:100px;
    line-height:20px;
    text-align:right;
    margin:auto;
    font-size:15px;
    }
  #second #cap {
  	float: left;
  	margin-left: 430px;
  }
  #second #mypage {
  	position:relative;
  	
  }
  #second #mypage_sub {
  	position:absolute;
  	padding-left:0px;
	left: -1px;
    top: 5px;
  	width:80px;
  	height:65px;
  	border:solid 1px black;
  	background:white;
  	visibility:hidden;
  }
  #second #mypage_sub li {
  	list-style-type:none;
  	width:80px;
  	text-align:center;
  	font-size:14px;
  	height:20px;  
  }

  #third {
    width:100%;
    height:50px;
    line-height:50px;
    margin:auto;
    align:center;
	}
  #third ul {
    margin-left:0px;
    padding:0;    
    text-align: center;
  }
  #third .main {
    display:inline-block;
    list-style-type: none; /* 이거 뭔지 찾아보기 */
    width:178px;  /* 중앙쪽으로 위치조정 */
    height:100%; /* 중앙쪽으로 위치조정 */
    font-size:17px;
    position:relative;
    text-align:center;
    line-height: 55px;
    
  }
  #third .sub {
  	position:absolute;
  	padding-left:0px;
  	margin-left:0px;
  	background:white;
  	visibility:hidden;
  	margin-top: -5px;
  }
  #third .sub li {
  	list-style-type:none;
  	width:178px;
  	height:40px;
  	line-height:30px;
  }
   #eighth {
   	width:1100px;
    height:200px;
    margin:auto;
    background:#6699FF; /* 추후 삭제 */  
  }
</style>

<script>
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
   <div id="left"> 펜션 오픈 기념 이벤트 1박 10,000원 </div>
   <div id="right"> x </div>
 </div>
 </div>
 <div id="second"> 
 <div id="cap">
	<a href="../main/index.jsp"><img src="../img/pension_logo.png" height="100"></a>
 </div>
<%if(session.getAttribute("userid") == null) {%>         
     <a href="../member/login.jsp">로그인</a> l <a href="../member/member.jsp">회원가입</a> l 
<%}else if(session.getAttribute("userid").equals("admin")){ //관리자인가 아닌가 체크%>
	<%=session.getAttribute("name")%>님 l
	<a href="../member/logout.jsp">로그아웃</a> l 
	<a href="../admin/main/index.jsp"> 관리자 페이지	</a>
<%}else { %>
	<%=session.getAttribute("name")%>님 l
     <a href="../member/logout.jsp">로그아웃</a> l 
     <span id="mypage" onmouseover="mypageview()" onmouseout="mypagehide()"> 마이 페이지
     	<ul id="mypage_sub">
     		<li> <a href="../member/member_view.jsp">회원정보</a> </li>
     		<li> <a href="../reserve/my_reserve.jsp">예약 정보</a> </li>
     		<li> <a href="../inquiry/mine.jsp">나의 글</a> </li>
     		
     	</ul>
     </span>
<%} %>
      l <a href="../inquiry/write.jsp"> 1:1문의</a>
 
 </div>
 <div id="third">
   <ul>
     <li class="main"> <a href="../main/index.jsp">HOME</a> </li>
     <li class="main" onmouseover="menuview(0)" onmouseout="menuhide(0)"> 펜션소개
     	<ul class="sub">
     		<li> 인사말 </li>
     		<li> 오시는 길 </li>
     	</ul>     
     </li>
<%@page import="pension.dao.RoomDao" %>
<%@page import="pension.dto.RoomDto" %>
<%@page import="java.util.*" %>
<%
	RoomDao rdao = new RoomDao();
	rdao.getRoom(request);
	ArrayList<RoomDto> rlist = (ArrayList<RoomDto>)request.getAttribute("rlist");
%>
     <li class="main" onmouseover="menuview(1)" onmouseout="menuhide(1)"> 객실현황 
     	<ul class="sub">
     	<% for(int i = 0; i < rlist.size(); i++) { %>
     	<li> <a href="../room/room_view.jsp?id=<%=rlist.get(i).getId()%>"><%=rlist.get(i).getName()%></a> </li>
     	<%} %>
     	</ul>
     </li>
     <li class="main" onmouseover="menuview(2)" onmouseout="menuhide(2)"> 주변관광
     	<ul class="sub">
     		<li> 만리포 해수욕장 </li>
     		<li> 꽃지 해수욕장 </li>
     		<li> 태안 불빛축제 </li>
     		<li> 안흥 낚시체험 </li>
     		<li> 신진도 투어 </li>
     	</ul>
      </li>
     <li class="main" onmouseover="menuview(3)" onmouseout="menuhide(3)"> 예약문의
     	<ul class="sub">
     		<li> 예약 안내 </li>
     		<li> <a href="../reserve/reserve.jsp">실시간 예약</a> </li>
     	</ul>
     </li>
     <li class="main" onmouseover="menuview(4)" onmouseout="menuhide(4)"> 커뮤니티
     	<ul class="sub">
     		<li> <a href="../board/list.jsp">자유게시판</a> </li>
     		<li> <a href="../hugi/list.jsp">여행 후기</a> </li>
     		<li> <a href="../gongji/list.jsp">공지 사항</a> </li>
     	</ul>
     </li>
   </ul>
 </div>
