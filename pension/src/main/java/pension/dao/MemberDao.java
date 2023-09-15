package pension.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import pension.dto.MemberDto;
import pension.dto.ReviewDto;

public class MemberDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	public MemberDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/pension";
		conn = DriverManager.getConnection(db, "root", "1234");
	}

	public void member_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String name = request.getParameter("name");

		String sql = "insert into member(userid,name,pwd,phone,email,writeday)";
		sql = sql + " values(?,?,?,?,?,now())";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, name);
		pstmt.setString(3, pwd);
		pstmt.setString(4, phone);
		pstmt.setString(5, email);

		pstmt.executeUpdate();

		pstmt.close();
		conn.close();

		response.sendRedirect("login.jsp");

	}

	public void userid_check(HttpServletRequest request, JspWriter out) throws Exception {
		// 읽어오기 = userid
		String userid = request.getParameter("userid");
		// 쿼리생성
		String sql = "select count(*) as cnt from member where userid=?";
		// 프레파라
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		// 쿼리실행
		rs = pstmt.executeQuery();
		rs.next();
		out.print(rs.getString("cnt"));
		// 실행결과에 따라 두개의 값 중에 하나를 보낸다. (if문)
	}

	public void login_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws Exception {
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		//reserve에서 이동한 변수 받기
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String id = request.getParameter("id");
		
		String sql = "select * from member where userid=? and pwd=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, pwd);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			// 세션변수 생성
			session.setAttribute("userid", userid);
			session.setAttribute("name", rs.getString("name"));
			// 메인페이지로 이동
			if(year == null) {
				// top.jsp, login_ok.jsp, member_ok.jsp를 통해 login으로 온 경우
				response.sendRedirect("../main/index.jsp");				
			}else {
				// reserve_next.jsp에서 온 경우
				response.sendRedirect("../reserve/reserve_next.jsp?year="+year+"&month="+month+"&day="+day+"&id="+id);
			}
		} else {
			response.sendRedirect("../member/login.jsp?cyd=1"); // cyd=틀렸다고 알려주기 위해 아무값이나 넣어줌
		}
	}

	public void logout(HttpSession session, HttpServletResponse response) throws Exception {
		session.invalidate();
		response.sendRedirect("../main/index.jsp");
	}

	public void member_view(HttpSession session, HttpServletRequest request) throws Exception {

		String userid = session.getAttribute("userid").toString();

		String sql = "select * from member where userid=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);

		rs = pstmt.executeQuery();
		rs.next();
		// rs > dto
		MemberDto mdto = new MemberDto();
		mdto.setUserid(rs.getString("userid"));
		mdto.setName(rs.getString("name"));
		mdto.setPhone(rs.getString("phone"));
		mdto.setEmail(rs.getString("email"));
		mdto.setWriteday(rs.getString("writeday"));

		request.setAttribute("mdto", mdto);

		rs.close();
		pstmt.close();
		conn.close();

	}

	public void phone_change(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws Exception {
		String phone = request.getParameter("phone");
		String userid = session.getAttribute("userid").toString();

		String sql = "update member set phone=? where userid=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, phone);
		pstmt.setString(2, userid);

		pstmt.executeUpdate();

		pstmt.close();
		conn.close();
		response.sendRedirect("member_view.jsp");
	}

	public void email_change(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws Exception {
		String email = request.getParameter("email");
		String userid = session.getAttribute("userid").toString();

		String sql = "update member set email=? where userid=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, userid);

		pstmt.executeUpdate();

		pstmt.close();
		conn.close();

		response.sendRedirect("member_view.jsp");
	}

	public int pwd_change_ok(HttpServletRequest request,
			HttpSession session) throws Exception
	{
		String opwd=request.getParameter("opwd");
		String pwd=request.getParameter("pwd");
		String userid=session.getAttribute("userid").toString();
		// 테이블에 있는 비밀번호를 가져오기
		String sql="select pwd from member where userid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		String pwd2=rs.getString("pwd");  // 테이블에 있는 비번
		
		if(opwd.equals(pwd2))
		{   // 변수 재사용
			sql="update member set pwd=? where userid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, userid);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			session.invalidate();
			
			return 1; 
		}
		else
		{
			pstmt.close();
			conn.close();
			
            return 0;
		}
	}
	
	//리뷰를 쓸 때 객실 이름과 입실일을 넘기기
	public void review(HttpServletRequest request) throws Exception {
		
		String rid = request.getParameter("rid");
		String jcode = request.getParameter("jcode");
		
		String sql = "select name from room where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, rid);
		rs = pstmt.executeQuery();
		rs.next();
		String name = rs.getString("name");
			
		sql = "select inday from reserve where jcode=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, jcode);
		rs = pstmt.executeQuery();
		rs.next();
		String inday = rs.getString("inday");
		
		request.setAttribute("name", name);
		request.setAttribute("inday", inday);
		//innerjoin 사용시
		// select room.name, reserve.inday from room inner join reserve on room.id=reserve.rid and reserve.jcode=?;
		pstmt.close();
		conn.close();
	}
	
	public void review_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		String rid = request.getParameter("rid");
		String jcode = request.getParameter("jcode");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String star = request.getParameter("star");
		String userid = session.getAttribute("userid").toString();
		
		
		String sql = "insert into review(rid,jcode,title,content,star,userid,writeday)";
		sql = sql + " values(?,?,?,?,?,?,now())";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, rid);
		pstmt.setString(2, jcode);
		pstmt.setString(3, title);
		pstmt.setString(4, content);
		pstmt.setString(5, star);
		pstmt.setString(6, userid);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("../reserve/my_reserve.jsp");
	}

	// 리뷰가 작성됐는지 확인하는 메소드
	public static boolean isReview(String jcode) throws Exception {
		
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/pension";
		Connection conn = DriverManager.getConnection(db, "root", "1234");
		
		String sql = "select count(*) as cnt from review where jcode=?";
		PreparedStatement pstmt =  conn.prepareStatement(sql);
		pstmt.setString(1, jcode);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		if(rs.getInt("cnt") == 0) {
			return true;
		}else {
			return false;
		}
	}
	// 객실 조회시 해당 객실의 리뷰를 전달하는 메소드
	public void getReview(HttpServletRequest request) throws SQLException {
		String id = request.getParameter("id"); // room table id
		String sql = "select * from review where rid=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		int hap = 0; // 총점
		ArrayList<ReviewDto> reviewlist = new ArrayList<ReviewDto>();
		while(rs.next()) {
			ReviewDto rdto = new ReviewDto();
			rdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
			rdto.setId(rs.getInt("id"));
			rdto.setJcode(rs.getString("jcode"));
			rdto.setRid(rs.getInt("rid"));
			rdto.setStar(rs.getInt("star"));
			rdto.setTitle(rs.getString("title"));
			rdto.setUserid(rs.getString("userid"));
			rdto.setWriteday(rs.getString("writeday"));
			reviewlist.add(rdto);
			
			hap = hap + rs.getInt("star"); //총점
		}
		
		//총점 구하기 쩜오로 만들기?
		double staravg = hap/(reviewlist.size()*1.0);
		request.setAttribute("staravg", staravg);
		
		request.setAttribute("reviewlist", reviewlist);
		
	}
	
	
	
	
	
	
	
	
	
	 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
