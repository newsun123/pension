<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
input[type=submit] {
	background: gainsboro;
    border-radius: 5px;
    padding: 5px 10px;
    border: none;
    margin-top: 20px;
    width: 85px;
    height: 35px;
    font-size: 20px;
    font-family: 'Dovemayo_gothic';
   	cursor:pointer;
}
input[type=button] {
	background: gainsboro;
    border-radius: 5px;
    padding: 5px 10px;
    border: none;
    margin-top: 20px;
    width: 85px;
    height: 35px;
    font-size: 20px;
    font-family: 'Dovemayo_gothic';
   	cursor:pointer;
}
input[type=file]{
    font-family: 'Dovemayo_gothic';
    font-size:15px;
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
</script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> 후기 작성  </p>
	</div>
</div>
<div id="section">
<form method="post" action="write_ok.jsp" enctype="multipart/form-data">
	<table width="600" align="center">
				<tr>
					<td><input type="text" name="title"></td>
				</tr>
				<tr>
					<td><textarea name="content"></textarea></td>
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
						<input type="submit" value="저장하기">
					</td>
				</tr>
	</table>
</form>
</div>

<%@ include file="../bottom.jsp" %>