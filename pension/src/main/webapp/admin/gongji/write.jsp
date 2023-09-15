<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
}
</style>
<script>
</script>
	<div id="section"><!-- 공지사항 적기 -->
		<form method="post" action="write_ok.jsp">	
			<h2> 공지사항 등록</h2>
			<div class="gong"> <input type="text" name="title"> </div>
			<div class="gong"> <textarea name="content"></textarea> </div>
			<div class="gong"> <input type="checkbox" name="step" id="step" value="1"> 상단고정 </div>
			<div class="gong"> <input type="submit" value="공지사항 등록"> </div>
		</form>
	</div>
</body>
</html>