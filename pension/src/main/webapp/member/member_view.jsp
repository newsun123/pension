<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>  
<%@page import="pension.dto.MemberDto" %>  
<%   
     // member_view.jsp
     MemberDao mdao=new MemberDao();
     mdao.member_view(session,request);
     MemberDto mdto=(MemberDto)request.getAttribute("mdto");
%>    
<%@ include file="../top.jsp" %>
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
      height:500px;
      margin:auto;
      margin-top:80px;
      font-size:20px;
    font-family: 'Dovemayo_gothic';
    }
    #section #main {
      width:400px;
      margin:auto;
    }
    #section #main div {
      margin-top:20px;
    }
    #section div #aa {
      display:inline-block;
      width:100px;
      text-align:left;
    }
    #section input[type=text] {
	width: 130px;
    height: 28px;
    border-radius: 5px;
    border: 2px solid #cccccc;
    outline:none;
    }
#section input[type=button] {
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
#section input[type=submit] {
	background: gainsboro;
    border-radius: 5px;
    padding: 5px 10px;
    border: none;
    margin-top: 20px;
    width: 50px;
    height: 35px;
    font-size: 20px;
    font-family: 'Dovemayo_gothic';
   	cursor:pointer;
}
  </style>
  <script>
  function formopen() // 새창 열기
  {
	   son=open("pwd_change.jsp","","width=250,height=280");
	   x=screen.availWidth;
	   y=screen.availHeight;
	   x=x-(250/2);
	   x=x/2;
	   y=y-(230/2);
	   y=y/2;
	   
	   son.moveTo(x,y);
  }
  </script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> 회원정보 수정  </p>
	</div>
</div>
  <div id="section">
   <div id="main">
    <div> <span id="aa"> 아이디 </span> <span id="bb"><%=mdto.getUserid()%></span> </div>
    <div> <span id="aa"> 이 름 </span> <span id="bb"><%=mdto.getName()%></span> </div>
    <div>
       <span id="aa"> 전화번호 </span> 
       <span id="bb">
        <form method="post" action="phone_change.jsp" style="display:inline;">
         <input type="text"  name="phone" value="<%=mdto.getPhone()%>">
         <input type="submit" value="변경">
        </form>
       </span>
    </div>
    <div> 
       <span id="aa"> 이메일 </span> 
       <span id="bb">
        <form method="post" action="email_change.jsp" style="display:inline;">
         <input type="text"  name="email" value="<%=mdto.getEmail()%>">
         <input type="submit" value="변경">
        </form>        
       </span> 
    </div>
    <div> <span id="aa"> 가입일 </span> <span id="bb"><%=mdto.getWriteday()%></span> </div>
    
    <div style="margin-left:100px;"> <input type="button" value="비밀번호변경" onclick="formopen()"> </div>
    
   </div>
  </div>
<%@ include file="../bottom.jsp" %>




