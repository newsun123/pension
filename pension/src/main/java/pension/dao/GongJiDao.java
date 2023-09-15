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

import pension.dto.GongJiDto;

public class GongJiDao {
	
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	public GongJiDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/pension";
		conn = DriverManager.getConnection(db, "root", "1234");
	}
	
	public void write_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String step = request.getParameter("step");
		if(step == null) {
			step = "0";
		}
		
		String sql = "insert into gongji(title,content,step,writeday)";
		sql = sql + " values(?,?,?,now())";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, step);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("list.jsp");
	}
	
	public void list(HttpServletRequest request) throws Exception {
		
		String sql = "select * from gongji order by step desc, id desc"; // step높은거부터 가져와라
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		ArrayList<GongJiDto> list = new ArrayList<GongJiDto>();
		
		while(rs.next()) {
			GongJiDto gdto = new GongJiDto();
			gdto.setTitle(rs.getString("title"));
			gdto.setReadnum(rs.getInt("readnum"));
			gdto.setContent(rs.getString("content"));
			gdto.setWriteday(rs.getString("writeday"));
			gdto.setStep(rs.getInt("step"));
			gdto.setId(rs.getInt("id"));
			
			list.add(gdto);
		}
		request.setAttribute("list", list);
		
	}
	
	public void readnum(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id = request.getParameter("id");
		
		String sql = "update gongji set readnum=readnum+1 where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void content(HttpServletRequest request) throws Exception {
		
		String id = request.getParameter("id");
		
		String sql = "select * from gongji where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		GongJiDto gdto = new GongJiDto();
		gdto.setTitle(rs.getString("title"));
		gdto.setReadnum(rs.getInt("readnum"));
		gdto.setWriteday(rs.getString("writeday"));
		gdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		gdto.setId(rs.getInt("id"));
		gdto.setStep(rs.getInt("step"));
		
		request.setAttribute("gdto", gdto);
	}
	
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id = request.getParameter("id");
		
		String sql = "delete from gongji where id=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("list.jsp");
	}
	
	public void update(HttpServletRequest request) throws Exception {
		
		String id = request.getParameter("id");
		
		String sql = "select * from gongji where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		GongJiDto gdto = new GongJiDto();
		gdto.setTitle(rs.getString("title"));
		gdto.setReadnum(rs.getInt("readnum"));
		gdto.setWriteday(rs.getString("writeday"));
		gdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		gdto.setId(rs.getInt("id"));
		gdto.setStep(rs.getInt("step"));
		
		request.setAttribute("gdto", gdto);
	}
	
	public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int step;
		if(request.getParameter("step") == null) {
			step = 0;
		} else {
			step = 1;
		}
		
		String sql = "update gongji set title=?,content=?,step=?,writeday=now() where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setInt(3, step);
		pstmt.setString(4, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void getFiveGongji(HttpServletRequest request) throws Exception {
		String sql = "select id,title,writeday from gongji order by step desc, id desc limit 5";
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		ArrayList<GongJiDto> glist = new ArrayList<GongJiDto>();
		
		while(rs.next()) {
			
			GongJiDto gdto = new GongJiDto();
			
			gdto.setId(rs.getInt("id"));
			gdto.setTitle(rs.getString("title"));
			gdto.setWriteday(rs.getString("writeday"));
			
			glist.add(gdto);
		}
		
		request.setAttribute("glist", glist);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
