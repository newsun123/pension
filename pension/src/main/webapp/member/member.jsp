<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp" %>
<style>
  #section {
    width:1100px;
    height:500px;
    line-height:20px;/* 인풋 거리 조절 */
    margin:auto;
    text-align:center;
  }
  #section #uid {
    font-size:12px;
  }
  #section #chkpwd {
    font-size:12px;
  }
  #section input[type=text] {
    width:300px;
    height:30px;
    border:1px solid #00C935;
    outline:none;
  }
  #section input[type=password] {
    width:300px;
    height:30px;
    border:1px solid #00C935;
    outline:none;  
  }
  #section input[type=submit] {
    width:300px;
    height:30px;
    border:1px solid #cccccc;
    outline:none;  
    /* background: #00C935;  버튼 안 색 변경 할때는 백구라운드*/ 
  }
</style>
<script>
 
	function check(my) { //ajax 기본 틀
		// id를 4자 이상일 때 체크가 가능해야 한다.
		// id가 4자 미만이면 메세지가 필요함.
		if (my.value.length >= 4) {

			var cyd = new XMLHttpRequest();
			cyd.onload = function() {
				//cyd.responseText //서버에서 동작 후 돌아오는 텍스트
				if (cyd.responseText.trim() == 1) {
					document.getElementById("uid").innerText = "사용 불가능한 아이디입니다.";
					document.getElementById("uid").style.color = "red";
					userid_chk = 0;
				} else {
					document.getElementById("uid").innerText = "사용 가능한 아이디입니다.";
					document.getElementById("uid").style.color = "blue";
					userid_chk = 1;
				}
			}
			cyd.open("GET", "userid_check.jsp?userid=" + my.value); // usrid_check.jsp?usrid= 아이디값
			cyd.send();
			response.sendRedirect("login.jsp");
		} else {
			document.getElementById("uid").innerText = "아이디 길이는 4자 이상입니다.";
			document.getElementById("uid").style.color = "red";
			userid_chk = 0;
		}
	}

	function pcheck() {

		var pwd1 = document.mform.pwd.value;
		var pwd2 = document.mform.pwd2.value;
		if (pwd2.length > 0) {
			if (pwd1 == pwd2) {
				document.getElementById("chkpwd").innerText = "비밀번호가 일치합니다.";
				document.getElementById("chkpwd").style.color = "blue";
				pwd_chk = 1;
			} else {
				document.getElementById("chkpwd").innerText = "비밀번호가 다릅니다.";
				document.getElementById("chkpwd").style.color = "red";
				pwd_chk = 0;
			}
		}
	}
	// 가입 눌렀을 때 한번더 크로스체크
	var userid_chk = 0;
	var pwd_chk = 0;
	
	function member_check() { 
		//아이디가 사용불가능인지 확인
		//비밀번호가 둘다 일치하는지 체크
		if (userid_chk == 0) {
			alert("아이디를 확인해주세요");
			return false;
		} else if (pwd_chk == 0) {
			alert("비밀번호를 확인해주세요");
			return false;
		} else {
			return true;
		}
	}
</script>
<div id="section"> <h3> 회원 가입</h3>
  <form name="mform" method="post" action="member_ok.jsp" onsubmit="return member_check()">
    <!-- 아이디 중복확인은 아이디 입력 폼에서 blur 될 때 ajax로 확인하자 -->
    <input type="text" name="userid" placeholder="아이디를 입력하세요" onblur="check(this)">
    <br><span id="uid"></span>
    <p>
    <input type="text" name="name" placeholder="이름을 입력하세요"> <p>
    <input type="password" name="pwd" placeholder="비밀번호를 입력하세요" onkeyup="pcheck()"> <p>
    <input type="password" name="pwd2" placeholder="비밀번호를 확인해주세요" onkeyup="pcheck()">
    <br><span id="chkpwd"></span>
    <p>
    <input type="text" name="phone" placeholder="전화번호를 입력해주세요"> <p>
    <input type="text" name="email" placeholder="이메일을 입력해주세요"> <p>
    <input type="submit" value="가입하기">
  </form>
</div>
<%@include file="../bottom.jsp" %>