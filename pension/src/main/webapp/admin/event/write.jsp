<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../menu.jsp" %>
 <script src="http://code.jquery.com/jquery-latest.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
  <script>
    $(function()
    {
    	 $("#date").datepicker(
    	 {
    		 dateFormat:"yy-mm-dd", // 입력폼에 출력되는 양식
    		 minDate:0 // 오늘 기준으로 이전 선택가능한 날
    		 
    	 });
    });
  </script>
<div id="section">
<form method="post" action="write_ok.jsp" enctype="multipart/form-data">
	<table width="800" align="center">
		<caption><h3>이벤트 작성</h3></caption>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="title">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="15" cols="50" name="content"></textarea>
				</td>
			</tr>
			<tr>
				<td>이벤트 기간</td>
				<td>
					<input type="text" name="gihan" id="date">
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
					<input type="submit" value="저장">
				</td>
			</tr>
	</table>
</form>
</div>
</body>
</html>
