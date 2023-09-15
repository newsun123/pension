package pension.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pension.dto.BoardDto;
import pension.dto.HugiDto;
import pension.dto.InquiryDto;

public class InquiryDao {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	public InquiryDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/pension";
		conn = DriverManager.getConnection(db, "root", "1234");
	}

	public void write_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {

		request.setCharacterEncoding("utf-8");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String userid = session.getAttribute("userid").toString();

		String sql = "insert into inquiry(title,content,userid,writeday) values(?,?,?,now())";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, userid);

		pstmt.executeUpdate();

		pstmt.close();
		conn.close();

		response.sendRedirect("success.jsp");
	}

	public void mine(HttpServletRequest request, HttpSession session) throws Exception {

		// board , tour, inquiry, review
		String userid = session.getAttribute("userid").toString();

		String sql = "select * from board where userid=? order by id desc limit 3";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		rs = pstmt.executeQuery();
		ArrayList<BoardDto> blist = new ArrayList<BoardDto>();
		while (rs.next()) {
			BoardDto bdto = new BoardDto();
			bdto.setId(rs.getInt("id"));
			bdto.setTitle(rs.getString("title"));
			bdto.setReadnum(rs.getInt("readnum"));
			bdto.setWriteday(rs.getString("writeday"));
			blist.add(bdto);
		}
		request.setAttribute("blist", blist);
		
		sql= "select * from hboard where userid=? order by id desc limit 3";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		rs = pstmt.executeQuery();
		ArrayList<HugiDto> hlist = new ArrayList<HugiDto>();
		while (rs.next()) {
			HugiDto hdto = new HugiDto();
			hdto.setId(rs.getInt("id"));
			hdto.setTitle(rs.getString("title"));
			hdto.setReadnum(rs.getInt("readnum"));
			hdto.setWriteday(rs.getString("writeday"));
			hlist.add(hdto);
		}
		request.setAttribute("hlist", hlist);
		
		sql = "select * from inquiry where userid=? order by id desc limit 3";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		rs = pstmt.executeQuery();
		ArrayList<InquiryDto> ilist = new ArrayList<InquiryDto>();
		while (rs.next()) {
			InquiryDto idto = new InquiryDto();
			idto.setId(rs.getInt("id"));
			idto.setTitle(rs.getInt("title"));
			idto.setContent(rs.getString("content"));
			idto.setWriteday(rs.getString("writeday"));
			idto.setState(rs.getInt("state"));
			idto.setAnswer(rs.getString("answer"));
			ilist.add(idto);
		}
		request.setAttribute("ilist", ilist);
		
	}

}
