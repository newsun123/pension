<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao" %>
<%@page import="java.util.ArrayList" %>
<%@page import="pension.dto.RoomDto" %>
<%
// 관리자가 객실 현황을 보는 것
AdminDao adao = new AdminDao();
adao.rlist(request);
ArrayList<RoomDto> list = (ArrayList<RoomDto>)request.getAttribute("list");
 %>
<%@include file="../menu.jsp" %>
<style>
  #vcon {
   position:absolute;
   visibility:hidden;
   width:450px;
   height:200px;
   border:1px solid black;
   background:white;
  }
  a {
  text-decoration:none;
  color:black;
  }
</style>
<script>
  function viewroom(id) {
	  var cyd = new XMLHttpRequest();
	  var x = event.clientX;
	  var y = event.clientY;
	  
	  cyd.onload=function() {
		  document.getElementById("vcon").style.left = x + "px";
		  document.getElementById("vcon").style.top = y + "px";
		  document.getElementById("vcon").style.visibility="visible";
		  var str = "<div align='center'> <input type='button' onclick='hidecontent()' value='X'>";
		  document.getElementById("vcon").innerHTML = cyd.responseText+str;
	  }
	  cyd.open("GET","viewroom.jsp?id="+id);
	  cyd.send();
  }
  function hidecontent(){
	  document.getElementById("vcon").style.visibility="hidden";
  }
  function addback(my) {
	  my.style.background="#cccccc";
  }
  function delback(my) {
	  my.style.background="white";
  }
</script>
</head>
<body> <!-- rlist -->
<div id="vcon"></div>
  <table width="900" align="center" border="1px solid black">
    <tr>
      <td> 객실명 </td>
      <td> 가격 </td>
      <td> 기준인원 </td>
      <td> 최대인원 </td>
      <td> 객실사진 </td>
      <td> 수정 </td>
      <td> 삭제 </td>
    </tr>
<%for(int i = 0; i < list.size(); i++) { %>    
    <tr onmouseover="addback(this)" onmouseout="delback(this)">
      <td onclick="viewroom(<%=list.get(i).getId()%>)"  align="center"> <%=list.get(i).getName() %> </td>
      <td  onclick="viewroom(<%=list.get(i).getId()%>)"  align="center"> <%=list.get(i).getPrice() %> </td>
      <td  align="center"> <%=list.get(i).getMin() %> </td>
      <td  align="center"> <%=list.get(i).getMax() %> </td>
      <td>
        <% 
        
        String[] img = list.get(i).getImg().split(","); // 그림파일, 그림파일, --- split 자르다. 
        for(int j = 0; j < img.length; j++) { %>
        <img src="../../room/img/<%=img[j]%>" width="100">
       <%} %>
      </td>
      <td> <a href="rupdate.jsp?id=<%=list.get(i).getId()%>">click</a> </td>
      <td> <a href="rdelete.jsp?id=<%=list.get(i).getId()%>">click</a> </td>
    </tr>
<%} %>
    <tr align="center">
    <td colspan="7" >
    <a href="rwrite.jsp">등록</a>
    </td>
    </tr>
  </table>
  
</body>
</html>