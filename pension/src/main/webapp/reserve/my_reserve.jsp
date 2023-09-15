<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%@page import="pension.dao.ReserveDao" %>
<%@page import="pension.dto.ReserveDto" %>
<%@page import="pension.dao.MemberDao" %>
<%
ReserveDao reservedao = new ReserveDao();
reservedao.my_reserve(session, request);
ArrayList<ReserveDto> relist = (ArrayList<ReserveDto>)request.getAttribute("relist");
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
  	font-family: 'Dovemayo_gothic';
  	font-size:20px;
  }
    input[type=button] {
	background: gainsboro;
    border-radius: 5px;
    padding: 5px 10px;
    border: none;
    width: 106px;
    height: 35px;
    font-size: 20px;
    font-family: 'Dovemayo_gothic';
   	cursor:pointer;
}
  table {
  	border-collapse: collapse;
  }
  table tr {
	border-bottom: 2px solid #ccc;
	height:50px;
  }
  </style>
  <script>
  </script>
  <div id="bgimg">
	<div id="bgtxt">
		<p>자유로운 시간, 커피 펜션</p>
		<p> <%=session.getAttribute("name")%>님의 예약 현황 </p>
	</div>
</div>
  <div id="section">
  	<table width="1000" align="center" style="text-align:center;">
	  		<tr>
	  			<td>객실명</td>
	  			<td>입실일</td>
	  			<td>퇴실일</td>
	  			<td>인원</td>
	  			<td>bbq 패키지</td>
	  			<td>숯불 패키지</td>
	  			<td>총 결제금액</td>
	  			<td>예약일</td>
	  			<td>상태</td>
	  			<td>신청</td>
	  		</tr>
	  	<%for(int i=0;i<relist.size();i++) {
	  		//ReserveDto rdto = relist.get(i) 로 지정해도 가능함.
	  		%>
	  		<tr>
	  			<td><%=rdao.getRoomName(relist.get(i).getRid())%></td>
	  			<td><%=relist.get(i).getInday()%></td>
	  			<td><%=relist.get(i).getOutday()%></td>
	  			<td><%=relist.get(i).getInwon()%>명</td>
	  			<td><%=relist.get(i).getBbq()%>개</td>
	  			<td><%=relist.get(i).getChacol()%>개</td>
	  			<td><%=pension.util.Util.comma(relist.get(i).getChongprice())%>원</td>
	  			<td><%=relist.get(i).getWriteday()%></td>
	  	<% String state ="";
	  	switch(relist.get(i).getState()) {
	  	case 0 : state ="예약중"; break;
	  	case 1 : state="취소중"; break;
	  	case 2 : state="취소완료"; break;
	  	case 3 : state="이용완료"; break; 
	  	default : state="ㅎㅎ, ㅈㅅ"; break;
	  	} %>
	  			<td><%=state%></td>
	  			<td>
	  			<%if(relist.get(i).getState() == 0) { %>
	  				<input type="button" value="취소신청" onclick="location='chgstate.jsp?state=1&id=<%=relist.get(i).getId()%>'">
	  			<%} else if(relist.get(i).getState() == 1) { %>
	  				<input type="button" value="취청취소" onclick="location='chgstate.jsp?state=0&id=<%=relist.get(i).getId()%>'">
	  			<%} %>
	 <!-- 리뷰를 쓸 수 있는 링크를 만들기 (7월 20)일 --> <!-- 리뷰가 작성되었다면 false, 안되었다면 true -->
	  			<%if(relist.get(i).getState()== 3 && MemberDao.isReview(relist.get(i).getJcode())) { // 이용완료:reserve table에서 state가 3인경우 && 리뷰가 작성이 안된 경우%>
	  				<input type="button" value="리뷰작성" onclick="location='../member/review.jsp?rid=<%=relist.get(i).getRid()%>&jcode=<%=relist.get(i).getJcode()%>'">
	  			<%}else if(relist.get(i).getState() == 3) {  %>
	  				<input type="button" value="리뷰완료">
	  			<%} %>
	  			 </td> <!-- state 상태에 따라 가능한 동작버튼 추가 -->
	  		</tr>
	  	<%} %>
  	</table>
  </div>

<%@ include file="../bottom.jsp" %>