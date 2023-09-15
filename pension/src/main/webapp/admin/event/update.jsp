<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../menu.jsp" %>
<%@page import="pension.dao.EventDao" %>
<%@page import="pension.dto.EventDto" %>
<%@page import="java.util.ArrayList" %>
<%
EventDao edao = new EventDao();
edao.update(request); 
EventDto edto = (EventDto)request.getAttribute("edto");

%>
<style>
img {
	cursor:pointer;
}
</style>
<script>
function chkimg(my){
	if(document.getElementById("a").checked) {
		document.getElementById("a").checked= false;		
		my.style.opacity=1;
		del = 0;
	}else {
		document.getElementById("a").checked= true;
		my.style.opacity=0.3;
		del = 1;
	}
}
</script>
<div id="section">
<form method="post" action="update_ok.jsp" enctype="multipart/form-data">
<input type="hidden" name="id" value="<%=edto.getId()%>">
<input type="hidden" name="del">
	<table width="800" align="center">
		<caption><h3>이벤트 작성</h3></caption>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="title" value="<%=edto.getTitle()%>">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="15" cols="50" name="content"><%=edto.getContent()%></textarea>
				</td>
			</tr>
						<tr>
				<td>이벤트 기간</td>
				<td>
					<input type="text" name="gihan" id="date" value="<%=edto.getGihan()%>">
				</td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>
					<img src="img/<%=edto.getImg()%>" onclick="chkimg(this)">
					<input type="checkbox" id="a" value="<%=edto.getImg()%>" style="display:none;">
				</td>
			</tr>
			<tr>
				<td>이미지 추가</td>
				<td>
					<input type="file" name="img">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정">
				</td>
			</tr>
	</table>
</form>
</div>
</body>
</html>