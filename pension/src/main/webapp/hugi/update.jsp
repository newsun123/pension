<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%@page import="pension.dao.HugiDao" %>
<%@page import="pension.dto.HugiDto" %>
<%
if(session.getAttribute("userid") == null) {
	response.sendRedirect("../member/login.jsp");
}else {
	HugiDao hdao = new HugiDao();
	hdao.update(request);
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
input[type=text]{
	width: 435px;
    height: 30px;
    border:3px solid #ccc;
    border-radius: 5px;
}
textarea{
	width: 435px;
    height: 375px;
    border:3px solid #ccc;
    border-radius: 5px;
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
.tbx {
	border-bottom:none;
}
</style>
<script>
function addform() {
	var size = document.getElementsByClassName("up").length;
 
	if(size < 10) {
		var out = document.getElementById("outer");
		out.innerHTML = out.innerHTML+ "<p class='up'> <input type='file' name='fname"+(size+1)+"'> </p>";
	}
}
function delform() {
	var size = document.getElementsByClassName("up").length;
	if(size != 1) {
		var out = document.getElementById("outer");
		document.getElementsByClassName("up")[size-1].remove();
	}
}

function imgclick(n,my) {
	if(document.getElementsByClassName("chkbox")[n].checked) {
		document.getElementsByClassName("chkbox")[n].checked=false;
		my.style.opacity=1;
	} else {
		document.getElementsByClassName("chkbox")[n].checked=true;
		my.style.opacity=0.3;
	}
}

//삭제할 이미지와 추가할 이미지 확인후 따로 저장할 메소드 생성
function check(my) {
	var dimg = "";
	var aimg = "";
	//checkbox의 객체를 자바 변수에 저장
	var chkbox = document.getElementsByClassName("chkbox");
	//checkbox의 길이를 확인 - 체크 된거는 삭제
	var chkboxlen = chkbox.length;
	
	for (i=0; i < chkboxlen; i++) {
		if(chkbox[i].checked) {
			dimg = dimg + chkbox[i].value + ",";
		} else {
			aimg = aimg + chkbox[i].value + ",";
		}
	}
	my.dimg.value = dimg;
	my.aimg.value = aimg;
}
</script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> 후기 수정  </p>
	</div>
</div>
<div id="section">
<form method="post" action="update_ok.jsp" enctype="multipart/form-data" onsubmit="return check(this)">
<%if(request.getParameter("mychk") != null) { %>
<input type="hidden" name="mychk" value="<%=request.getParameter("mychk")%>">
<%} %>
<input type="hidden" name="id" value="<%=hdto.getId()%>">
<input type="hidden" name="dimg"> <!-- 삭제할 이미지 -> check에서 value 받음 -->
<input type="hidden" name="aimg"> <!-- 존재하는 이미지 -> check에서 value 받음 -->
	<table width="600" align="center">
				<tr>
					<td colspan="2"><input type="text" name="title" value="<%=hdto.getTitle()%>"></td>
				</tr>
				<tr>
					<td colspan="2"><textarea name="content"><%=hdto.getContet()%></textarea></td>
				</tr>
				<tr>
					<td colspan="2">삭제할 사진을 선택하세요</td>
				</tr>
				<tr>
					<td colspan="2">
		<%for(int i=0;i<hdto.getArryimg().length;i++) {
			if(!hdto.getArryimg()[i].equals(""))
			{
			%>
						<input type="checkbox" class="chkbox" value="<%=hdto.getArryimg()[i]%>" style="display:none;">
						<img src="img/<%=hdto.getArryimg()[i]%>" width="100" onclick="imgclick(<%=i%>,this)">
		<% 		} 
			}
		%>
					</td>
				</tr>
				<tr>
					<td id="outer">
						<input type="button" value="사진추가" onclick="addform()">
						<input type="button" value="삭제" onclick="delform()">
							<p class="up"><input type="file" name="fname1"></p>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="저장">
					</td>
				</tr>
	</table>
</form>
</div>

<%@ include file="../bottom.jsp" %>

<%
} // session 관련 괄호닫기
%>