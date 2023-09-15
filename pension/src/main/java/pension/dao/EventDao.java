package pension.dao;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pension.dto.EventDto;

public class EventDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	public EventDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/pension";
		conn = DriverManager.getConnection(db, "root", "1234");
	}
	
	public void write_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String path = request.getRealPath("/admin/event/img");
		int size = 1024*1024*10;
		
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		String title= multi.getParameter("title");
 		String content = multi.getParameter("content");
 		String img = multi.getOriginalFileName("img");
 		String gihan = multi.getParameter("gihan");
 		
 		String sql = "insert into event(title,content,img,writeday,gihan) values(?,?,?,now(),?)";
 		
 		pstmt = conn.prepareStatement(sql);
 		pstmt.setString(1, title);
 		pstmt.setString(2, content);
 		pstmt.setString(3, img);
 		pstmt.setString(4, gihan);
 		
 		pstmt.executeUpdate();
 		
 		pstmt.close();
 		conn.close();
 		
 		response.sendRedirect("list.jsp");
		 
	}
	
	public void list(HttpServletRequest request) throws Exception {
		
		String sql = "select * from event order by id desc";
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		ArrayList<EventDto> elist = new ArrayList<EventDto>();
		
		while(rs.next()) {
			EventDto edto = new EventDto();
			
			edto.setContent(rs.getString("title"));
			edto.setId(rs.getInt("id"));
			edto.setTitle(rs.getString("title"));
			edto.setImg(rs.getString("img"));
			edto.setWriteday(rs.getString("writeday"));
			edto.setGihan(rs.getString("gihan"));
			
			elist.add(edto);
		}
		
		request.setAttribute("elist", elist);
	}
	
	public void content(HttpServletRequest request) throws Exception {
		
		String id = request.getParameter("id");
		String sql = "select * from event where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		EventDto edto = new EventDto();
		edto.setId(rs.getInt("id"));
		edto.setTitle(rs.getString("title"));
		edto.setWriteday(rs.getString("writeday"));
		edto.setContent(rs.getString("content"));
		edto.setImg(rs.getString("img"));
		edto.setGihan(rs.getString("gihan"));
		
		
		request.setAttribute("edto", edto);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public void update(HttpServletRequest request) throws Exception {
		
		String id = request.getParameter("id");
		String sql = "select * from event where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		EventDto edto = new EventDto();
		edto.setId(rs.getInt("id"));
		edto.setTitle(rs.getString("title"));
		edto.setWriteday(rs.getString("writeday"));
		edto.setContent(rs.getString("content"));
		edto.setImg(rs.getString("img"));
		edto.setGihan(rs.getString("gihan"));
		
		request.setAttribute("edto", edto);
		
		rs.close();
		pstmt.close();
		conn.close();
		
	}
	
	public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String path = request.getRealPath("/admin/event/img");
		int size = 1024*1024*10;
		
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String img = multi.getOriginalFileName("img");
		String id = multi.getParameter("id");
		
		String del = multi.getParameter("del");
		File file = new File(path+"/"+del);
		if(file.exists()) {
			file.delete();
		}
		
		String sql = "update event set title=?,content=?,img=? where id=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, img);
		pstmt.setString(4, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id = request.getParameter("id");
		
		String sql = "delete from event where id=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("list.jsp");
	}
	
	public void getSixEvent(HttpServletRequest request) throws Exception {
		
		String sql = "select id,img from event order by id desc limit 4";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();

		ArrayList<EventDto> elist = new ArrayList<EventDto>();
		
		while(rs.next()) {
			EventDto edto = new EventDto();
			
			edto.setId(rs.getInt("id"));
			edto.setImg(rs.getString("img"));
			
			elist.add(edto);
		}
		
		request.setAttribute("elist", elist);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public void user_content(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		
		String sql = "select * from event where id=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		
		EventDto edto = new EventDto();
		
		edto.setContent(rs.getString("content"));
		edto.setId(rs.getInt("id"));
		edto.setGihan(rs.getString("gihan"));
		edto.setImg(rs.getString("img"));
		edto.setTitle(rs.getString("title"));
		edto.setWriteday(rs.getString("writeday"));
		
		request.setAttribute("edto", edto);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
