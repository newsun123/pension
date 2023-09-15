<%@page import="pension.dao.GongJiDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%> <!-- 다른파일 연결 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#fourth {
  width:1980px;
  height:1080px;
  margin:auto;
  overflow:hidden;
}
#fourth #inner {
	width:5940px;
}
#fifth {
  width:1100px;
  margin:auto;
  margin-top:50px;
  font-size:16px;
  font-family: 'Dovemayo_gothic';
}
#fifth .comm {
	width:350px;
	height:200px;
	float:left;
	margin-left:10px;
}
#fifth .comm .title {
	display:inline-block;
	width:240px;
}
#fifth .comm .writeday {
	display:inline-block;
	width:100px;
}
.ptag {
	border-bottom:2px solid purple;
}
#sixth {
  width:1100px;
  margin:auto;
  margin-top:50px;
  display:flex;
  justify-content: space-between; <!-- 두마리는 짝궁이다. 플렉스랑 저스티파이 -->
}
#seventh {
	 width:1100px;
	 height:199px;
	 margin:auto;
	 margin-top:50px;
	 background:#00FF66; /* 추후 삭제 */
}
#slide{
	width: 1100px;
    height: 590px;
    margin: auto;
    margin-top:50px;
    padding: 0;
    position: relative;
	}
	.slide_ul{
		display: block;
	}
	#slide img{
	width: 100%;
	height: 100%;
	background-position: center center;
	background-size: cover;
	display: table;
	}
	.slide_ul>li{
	    width: 100%;
	    height: 100%;
	    position: absolute;
	    top: 0;
	    left: 0;
	    display: block;
	}
	#slide_text{
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	}
	#slide_text p{
		color:#fff;
		font-size:35px;
    	font-family: 'ChosunGs';
    	text-align:center;
    	margin-bottom: 0;
	}
	#slide_text p:last-child{
		font-size:15px;
		font-family: 'Noto Sans KR', sans-serif;
	}
	.slide_btn{
		width: 100%;
	    display: block;
	    position: absolute;
	    bottom: 30px;
	    text-align:center;
	}
	.slide_btn li{
		width: 10px;
	    height: 10px;
	    color: #fff;
	    border-width: 5px;
	    border-style: solid;
	    border-radius: 50%;
	    margin: 4px;
	    display: inline-block;
	    box-sizing: border-box;
	    cursor: pointer;
	    vertical-align: middle;
	}
	.slide_btn li.active{
		width: 25px;
    	border-radius: 5px;
	}
	#botpadding {
		height:80px;
	}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
  $(function(){  
	  setInterval(function(){
		  $("#inner").animate({
			  marginLeft:"-1980px"
		  },2000,function(){
			  $(".sld").eq(0).insertAfter($(".sld").eq(2));
			  $("#inner").css("margin-left","0px");
		  });
	  },6000);
	  
	  var current = 0;
		var slide_length = $(".slide_ul > li").length;
		
		$(".slide_ul > li").hide();
		$(".slide_ul > li").first().show();
		$(".slide_btn > li").first().addClass("active");
		$(".slide_btn > li").on("click",slide_stop);
		
		function auto_slide(){
			
			if(current == slide_length-1){
				current = 0;
			}else{
				current++;
			}
			
			$(".slide_ul > li").stop().fadeOut(1000);
			$(".slide_ul > li").eq(current).stop().fadeIn(800);
			$(".slide_btn > li").removeClass("active");	
			$(".slide_btn > li").eq(current).addClass("active");
		}
		
		ss=setInterval(auto_slide,3000);
		
		function slide_stop(){
			clearInterval(ss);
			
			var idx = $(this).index();
			current = $(this).index();
			
			if($(".slide_ul > li:animated").length >= 1){
				return false; //버튼 반복 클릭시 딜레이 방지
			}
			$(".slide_ul > li").stop().fadeOut(1000);	
			$(".slide_ul > li").eq(idx).fadeIn(800);
			$(".slide_btn > li").removeClass("active");	
			$(this).addClass("active");
			
			ss=setInterval(auto_slide,3000);
		} 
  });
</script>
<%@page import="pension.dao.GongJiDao"%>
<%@page import="pension.dao.BoardDao"%>
<%@page import="pension.dao.HugiDao"%>
<%@page import="pension.dao.EventDao"%>
<%@page import="pension.dto.*"%>
<script>
<%
	GongJiDao gdao = new GongJiDao();
	gdao.getFiveGongji(request);
	ArrayList<GongJiDto> glist = (ArrayList<GongJiDto>)request.getAttribute("glist"); 
	BoardDao bdao = new BoardDao();
	bdao.getFiveBoard(request);
	ArrayList<BoardDto> blist = (ArrayList<BoardDto>)request.getAttribute("blist");
	HugiDao hdao = new HugiDao();
	hdao.getFiveHugi(request);
	ArrayList<HugiDto> hlist = (ArrayList<HugiDto>)request.getAttribute("hlist");
	EventDao edao = new EventDao();
	edao.getSixEvent(request);
	ArrayList<EventDto> elist = (ArrayList<EventDto>)request.getAttribute("elist");
	
%>
</script>
</head>
<body><!-- 인덱스 -->
 <div id="fourth">
 	<div id="inner">
   		<img src="../img/banner1.jpg" width="1980" height="1080" class="sld"><img src="../img/banner2.jpg" width="1980" height="1080" class="sld"><img src="../img/banner3.jpg" width="1980" height="1080" class="sld">
   	</div>
 </div>
 <div id="fifth"> <!-- 공지사항,게시판,여행후기 5개 : 제목 날짜 -->
 	<div class="comm">
 		<p align="center" class="ptag"> 공지사항 </p>
			<%for(int i=0; i<glist.size();i++) {
				String title = glist.get(i).getTitle();
				if(title.length() > 13)
					title = title.substring(0,13)+"...";
			%>
				<span class="title"><a href="../gongji/readnum.jsp?id=<%=glist.get(i).getId()%>"><%=title%></a></span>
				<span class="writeday"><%=glist.get(i).getWriteday()%></span> <br>
			<%} %>
	 	</div>
	 	<div class="comm">
	 		<p align="center" class="ptag"> 자유게시판 </p>
				<%for(int i=0; i<blist.size();i++) {
					String title = blist.get(i).getTitle();
					if(title.length() > 13)
						title = title.substring(0,13)+"...";
				%>
					<span class="title"><a href="../board/readnum.jsp?id=<%=blist.get(i).getId()%>"><%=title%></a></span>
					<span class="writeday"><%=blist.get(i).getWriteday()%></span> <br>
				<%} %>
	 	</div>
	 	<div class="comm">
			<p align="center" class="ptag"> 후기게시판 </p>	
				<%for(int i=0; i<hlist.size();i++) {
					String title = hlist.get(i).getTitle();
					if(title.length() > 13)
						title = title.substring(0,13)+"...";
				%>
					<span class="title"><a href="../hugi/readnum.jsp?id=<%=hlist.get(i).getId()%>"><%=title%></a></span>
					<span class="writeday"><%=hlist.get(i).getWriteday()%></span> <br>
				<%} %>		
	 	</div>
 </div>
 <div id="sixth">
<%for (int i=0; i < elist.size(); i++) { %> 
 	<div class="ef">
 		<a href="../event/content.jsp?id=<%=elist.get(i).getId()%>"><img src="../admin/event/img/<%=elist.get(i).getImg()%>"></a>	
 	</div>
<%} %>
 </div>
	<div id="slide">
        <ul class="slide_ul">
        	<li><img src="../tour/t1.jpg"></li>
        	<li><img src="../tour/t2.jpg"></li>
        	<li><img src="../tour/t3.jpg"></li>
        	<li><img src="../tour/t4.jpg"></li>
        	<li><img src="../tour/t5.jpg"></li>
        	<li><img src="../tour/t6.jpg"></li>
        	<li><img src="../tour/t7.jpg"></li>
        	<li><img src="../tour/t8.jpg"></li>
        	<li><img src="../tour/t9.jpg"></li>
        	<li><img src="../tour/t10.jpg"></li>
        </ul>
        <ul class="slide_btn">
        	<li></li>
        	<li></li>
        	<li></li>
        	<li></li>
        	<li></li>
        	<li></li>
        	<li></li>
        	<li></li>
        	<li></li>
        	<li></li>
        </ul>
   	</div>
 <div id="botpadding"></div>
 <%@include file="../bottom.jsp" %>
