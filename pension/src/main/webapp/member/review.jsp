<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<%
if(session.getAttribute("userid") == null) {
	response.sendRedirect("../member/login.jsp");
}else {
%>
<%@page import="pension.dao.MemberDao" %>
<%
MemberDao mdao = new MemberDao();
mdao.review(request); 
String name = (String)request.getAttribute("name");
String inday = (String)request.getAttribute("inday");
%>
<style>

</style>
<script>
//매개변수 n까지 별을 노란 이미지로 변경하자.(star1.png)
function chgstar(n) {
	for(i=0;i<=n;i++) {
		document.getElementsByClassName("star")[i].src="../img/star1.png";
	}
//클릭된 위치의 오른쪽 별은 회색으로(star2.png)
	for(i=n+1;i<5;i++) {
		document.getElementsByClassName("star")[i].src="../img/star2.png";
	}
	document.cyd.star.value = n+1; // 히든에 별의 점수값을 넣자.
}

function check(my) {
	if(my.star.value == 0) {
		alert("별점을 입력하세요");
		return false;
	}else if (my.content.value.trim() == "") {
		alert("상세리뷰를 적으세요");
		return false;
	}else if (my.title.value.trim() == "") {
		alert("한줄요약을 적으세요");
		return false;
	}else {
			return true;		
	}
}
</script>
<div id="section">
<form name="cyd" mothod="post" action="review_ok.jsp" onsubmit="return check(this)">
<input type="hidden" name="rid" value="<%=request.getParameter("rid")%>">
<input type="hidden" name="jcode" value="<%=request.getParameter("jcode")%>">
<input type="hidden" name="star" value="0">
	<table width="600" align="center"> 
		<caption><h3><%=inday%>에 입실하셨던 <%=name%> 객실에 대한 리뷰입니다.  </h3></caption>
			<tr>
				<td>별점</td>
				<td>
					<img src="../img/star2.png" class="star" onclick="chgstar(0)">	
					<img src="../img/star2.png" class="star" onclick="chgstar(1)">	
					<img src="../img/star2.png" class="star" onclick="chgstar(2)">	
					<img src="../img/star2.png" class="star" onclick="chgstar(3)">	
					<img src="../img/star2.png" class="star" onclick="chgstar(4)">	
				</td>
			</tr>
			<tr>
				<td>상세 리뷰</td>
				<td><textarea rows="10" cols="40" name="content"></textarea></td>
			</tr>
			<tr>
				<td>한줄 요약</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="리뷰 작성">
				</td>
			</tr>
	</table>
</form>
</div>

<%@ include file="../bottom.jsp" %>

<%
} // session 관련 괄호닫기
%>