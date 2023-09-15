package pension.dao;

import java.io.UnsupportedEncodingException;
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
import pension.dto.GongJiDto;
import pension.dto.RoomDto;

public class BoardDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	public BoardDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/pension";
		conn = DriverManager.getConnection(db, "root", "1234");
	}
	
	public void write_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		request.setCharacterEncoding("utf-8");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String userid = session.getAttribute("userid").toString();
		
		String sql = "insert into board(title,userid,content,writeday) values(?,?,?,now())";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, userid);
		pstmt.setString(3, content);
		
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		response.sendRedirect("list.jsp");
	
	}
	
	public void list(HttpServletRequest request) throws Exception {
		//첫 페이지값 잡기
		int pager = this.getPager(request);
		
		//페이지당 인덱스 구하기
		int index = (pager-1) * 10;
		//10개만 나오게 하기
		String sql = "select * from board order by id desc limit ?,10";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, index);
		rs = pstmt.executeQuery();
		
		ArrayList<BoardDto> blist = new ArrayList<BoardDto>();
		while(rs.next()) {
			BoardDto bdto = new BoardDto();
			bdto.setId(rs.getInt("id"));
			bdto.setUserid(rs.getString("userid"));
			bdto.setTitle(rs.getString("title"));
			bdto.setContent(rs.getString("content"));
			bdto.setWriteday(rs.getString("writeday"));
			
			blist.add(bdto);
			request.setAttribute("blist", blist);
		}
	}
	
	public void readnum(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		
		String sql = "update board set readnum=readnum+1 where id=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void content(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		
		String sql = "select * from board where id=?";
		pstmt =conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		rs.next();
		BoardDto bdto = new BoardDto();
		bdto.setTitle(rs.getString("title"));
		bdto.setId(rs.getInt("id"));
		bdto.setContent(rs.getString("content"));
		bdto.setUserid(rs.getString("userid"));
		bdto.setReadnum(rs.getInt("readnum"));
		bdto.setWriteday(rs.getString("writeday"));
		
		request.setAttribute("bdto", bdto);	
	}
	
	public void update_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception {
		
		//아이디 체크 한번 더 하기 - 집에서 작성할 것
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String userid = session.getAttribute("userid").toString();
		
		String sql ="update board set title=?,content=? where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		if(request.getParameter("mychk") == null) // || request.getParameter("mychk").equals("null")) 
			response.sendRedirect("content.jsp?id="+id);
		else
			response.sendRedirect("../inquiry/mine.jsp");
		
	}
	
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//아이디 체크 한번 더 하기 - 집에서 작성할 것
		String id = request.getParameter("id");
				
		String sql = "delete from board where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		if (request.getParameter("mychk") == null) {
			response.sendRedirect("list.jsp");
		} else {
			response.sendRedirect("../inquiry/mine.jsp");
		}
	}
	// 페이지 요청
	public ResultSet pager(HttpServletRequest request) throws Exception {
		
		//첫 페이지값 잡기
		int pager = this.getPager(request);
		
		//페이지당 인덱스 구하기
		int index = (pager-1) * 10;
		
		//쿼리
		String sql = "select * from board order by id desc limit ?,10";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, index);
		rs = pstmt.executeQuery();
		//값 가져오기
		return rs;
	}
	
	public int getPager(HttpServletRequest request) {

		// 페이지 요청
		int pager;

		if (request.getParameter("pager") == null) {
			pager = 1;
		} else {
			pager = Integer.parseInt(request.getParameter("pager"));
		}
		return pager;
	}
	
	//Pstart 값 구하기
	public int getPstart(HttpServletRequest request) {
		//1~10p pstart = 1
		//11~20p pstart=11
		
		int pager = this.getPager(request);
	
		//pstart 값 구하기 (pager/10)*10+1
		int imsi = pager/10;
		if(pager %10 == 0) {
			imsi = imsi -1;
		}
		int pstart = imsi * 10 +1;
		
		return pstart;
	}
	//Pend 값 구하기 = 총 페이지가 pend보다 크면 그 값이 pend가 된다
	public int getPend(int pstart, int chong) {
		int pend = pstart + 9;
		if(chong <pend) {
			pend=chong;
		}
		return pend;
	}
	
	public int getChong() throws Exception {
		String sql = "select ceil(count(*)/10) as chong from board";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		rs.next();
		int chong = rs.getInt("chong");
		return chong;
	}
	
	public void getFiveBoard(HttpServletRequest request) throws Exception {
		String sql = "select id,title,writeday from board order by id desc limit 5";
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		ArrayList<BoardDto> blist = new ArrayList<BoardDto>();
		
		while(rs.next()) {
			
			BoardDto bdto = new BoardDto();
			
			bdto.setId(rs.getInt("id"));
			bdto.setTitle(rs.getString("title"));
			bdto.setWriteday(rs.getString("writeday"));
			
			blist.add(bdto);
		}
		
		request.setAttribute("blist", blist);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	
	
}
