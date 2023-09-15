<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%@page import="pension.dao.RoomDao" %>
<%@page import="pension.dao.MemberDao" %>
<%@page import="pension.dto.ReviewDto" %>
<%@page import="pension.dto.RoomDto" %>
<%@page import="pension.util.Util" %>
<%
RoomDao rdao2 = new RoomDao();
rdao2.room_view(request); // 방의 id 보내기
RoomDto rdto = (RoomDto)request.getAttribute("rdto");
//현재 보여주는 객실의 리뷰를 읽어오기 : room table id
//review.jsp 는 member 폴더 존재 => memberDao에 추가
MemberDao mdao = new MemberDao();
mdao.getReview(request);
ArrayList<ReviewDto> reviewlist = (ArrayList<ReviewDto>)request.getAttribute("reviewlist");
double staravg = (double)request.getAttribute("staravg");
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
	margin-top:20px;
font-family: 'Dovemayo_gothic';
}
#section #cont {
    width:430px;
    height:100px;
    border:1px solid #cccccc;
    overflow:auto;
  }
#pp {
	font-size:34px;
}
table {
	width:800px;
}
table tr {
	height:40px;
}
#roomimg {
	width:100%;
}
button {
	position:absolute;
}
.lfbtn{
    width: 54px;
    height: 47px;
    border:none;
    cursor:pointer;
    margin-top:297.75px;
}
.lfimg {
	width: 40px;
	border:none;
}
.rtbtn {
    width: 54px;
    height: 47px;
    border:none;
    cursor:pointer;
    margin-left: -54px;
    margin-top:297.75px;
}
.rtimg	{
	width:40px;
	border:none;
}
</style>
<script>
<%
	String[] arrayimg = rdto.getArrayimg();
	String imsi = "";
	for(int i=0; i <arrayimg.length; i++){
		imsi = imsi + "'"+arrayimg[i]+"'";
		if(i != arrayimg.length-1) {  // if(마지막배열의 인덱스가 아닐 경우) => 마지막 요소가 아닌 경우에만 , 를 붙인다.
			imsi = imsi+",";
		}
	}
%>
var img =[<%=imsi%>];
var imgindex=0;
function leftview(){
 imgindex--;
 if(imgindex<0){
  imgindex = img.length-1;
 }
 document.getElementById("roomimg").src="img/"+img[imgindex];
}
function rightview(){
 imgindex++;
 if(imgindex == img.length){
  imgindex = 0;
 }
 document.getElementById("roomimg").src="img/"+img[imgindex];
}
</script>
<div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> ROOM  </p>
	</div>
</div>
<div id="section">
<table align="center">
	<caption>
		<p id="pp"> <%=rdto.getName()%>  객실현황 <p>
		<% // 별점 총점 만들기 0720
		//staravg = 2.3;
		int n = (int)staravg;  // 노란별 갯수
		if(staravg-n>0.8)
			n++;
		for(int i=1; i <= n; i++) { %>
			<img src="../img/star1.png">
	<% } %>
	<!-- 반별 -->
		<% // 반별 넣기
		if(n+0.3 <= staravg && staravg <= n+0.8) { %>
			<img src="../img/star3.png">
	<%  n++; // 반별이 출력되었으므로 
	} %>
	<!-- 회색별 -->
	 <% 
		for(int i = 1; i <= 5-n; i++) { %>
			<img src="../img/star2.png">
	<% } %>
		</p>
	</caption>
		<tr>
			<td> 기본 인원 </td>
			<td> <%=rdto.getMin()%> </td>
			<td> 최대 인원 </td>
			<td> <%=rdto.getMax()%> </td>
		</tr>
			<tr>
				<td>1박 금액</td>
				<td><%=Util.comma(rdto.getPrice())%></td>
				<td colspan="2"> 1인 추가시 10,000원</td>
			</tr>
				<tr>
					<td colspan="4"><%=rdto.getContent()%></td>
				</tr>
					<tr>
						<td colspan="4" align="center">
							<button type="button" onclick="leftview()" class="lfbtn"><img src="../img/leftbtn.png" class="lfimg"></button>
<!-- valign은 사진의 중앙으로 맞춰준다 --><img id="roomimg" src="img/<%=rdto.getArrayimg()[0]%>" valign="middle">
							<button type="button" onclick="rightview()" class="rtbtn"><img src="../img/rightbtn.png" class="rtimg"></button>
						</td>
					</tr>
</table>
	<table width="800" align="center">
	<% for(int i=0; i< reviewlist.size(); i++) { 
			int num = reviewlist.get(i).getStar(); // 숫자를 별 모양으로 바꾸기
	%>
		<tr>
			 <td width="150">
			 <% for(int j=1; j<=num; j++) { %>
			 	<img src="../img/star1.png" width="20">
			 <%} %>
			 <% for(int j=1; j<=5-num; j++) { %>
			 	<img src="../img/star2.png" width="20">
			 <%} %>
			  </td>
			<td width="200"> <%=reviewlist.get(i).getTitle()%> </td>
			<td id=cont> <%=reviewlist.get(i).getContent()%> </td>
		</tr>
	<%} %>
	</table>
</div>

<%@ include file="../bottom.jsp" %>