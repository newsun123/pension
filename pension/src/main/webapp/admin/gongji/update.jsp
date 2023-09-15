<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="pension.dao.GongJiDao" %>
<%@page import="pension.dto.GongJiDto" %>
<%
if (session.getAttribute("userid") == null || !session.getAttribute("userid").equals("admin")) {

	response.sendRedirect("../../main/index.jsp");
} else {

	GongJiDao gdao = new GongJiDao();
	gdao.update(request);
	GongJiDto gdto = (GongJiDto) request.getAttribute("gdto");
%>
<%@include file="../menu.jsp" %>
<style>
#section {
	width:1100px;
	height:500px;
	margin:auto;
	margin-top:50px;
	text-align:center;
}
#section .gong input[type=text] {
	width: 399px;
    height: 30px;
}
#section .gong input[type=submit] {
	width:400px;
	height:33px;
}
#section textarea {
	width:400px;
	height:100px;
}
#section .gong {
	width:410px;
	margin:auto;
	margin-top:10px;
	align:center;
}
</style>
<script>
</script>
	<div id="section">
		<form method="post" action="update_ok.jsp">	
		<input type="hidden" name="id" value="<%=gdto.getId()%>">
			<h2> 공지사항 수정</h2>
			<div class="gong"> <input type="text" name="title" value="<%=gdto.getTitle()%>"> </div>
			<div class="gong"> <textarea name="content"><%=gdto.getContent()%></textarea> </div>
			<%
			String msg = "";
			if(gdto.getStep()==1) {
				msg="checked";
			}
			
			%>
			<div class="gong"> <input type="checkbox" name="step" <%=msg%> value="1"> 상단고정 </div>
			<div class="gong"> <input type="submit" value="공지사항 수정"> </div>
		</form>
	</div>
</body>
</html>
<%} %>