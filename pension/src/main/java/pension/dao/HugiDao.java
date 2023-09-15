package pension.dao;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pension.dto.GongJiDto;
import pension.dto.HugiDto;

public class HugiDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	public HugiDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/pension";
		conn = DriverManager.getConnection(db, "root", "1234");
	}
	
	public void write_ok(HttpServletRequest request,HttpSession session, HttpServletResponse response) throws IOException, SQLException {
		int size = 1024*1024*100;
		String path = request.getRealPath("/hugi/img");
		
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String userid = session.getAttribute("userid").toString();
 
		Enumeration file = multi.getFileNames();
		
		String img = "";
		
		int i=1;
		while (file.hasMoreElements()) { // hasnext() 와 동일 == 파일 안에 끄집어낼게 있냐? 파일의 이름을 알기위해 만드는 코드다.
			String imsi = file.nextElement().toString(); // 요소를 꺼내는 메소드.문자열로 변경하는 메소드

			img = img + multi.getFilesystemName(imsi) + ",";
			System.out.println(i);
			i++;
		}
		img = img.replace("null,", ""); // 이미지 null값 없애기
		
		System.out.println(img);
		String sql = "insert into hboard(title,content,img,userid,writeday)";
		sql = sql + " values(?,?,?,?,now())";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, img);
		pstmt.setString(4, userid);
		
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
				
		String sql = "select * from hboard order by id desc limit ?,10";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, index);
		
		rs = pstmt.executeQuery();
		
		ArrayList<HugiDto> list = new ArrayList<HugiDto>();
		
		while(rs.next()) {
			HugiDto hdto = new HugiDto();
			hdto.setId(rs.getInt("id"));
			hdto.setTitle(rs.getString("title"));
			hdto.setUserid(rs.getString("userid"));
			hdto.setContet(rs.getString("content"));
			hdto.setWriteday(rs.getString("writeday"));
			hdto.setReadnum(rs.getInt("readnum"));
			
			list.add(hdto);
		}
		request.setAttribute("list", list);
		
	}
	public void readnum(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		
		String sql = "update hboard set readnum=readnum+1 where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void content(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		
		String sql = "select * from hboard where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		
		HugiDto hdto = new HugiDto();
		hdto.setId(rs.getInt("id"));
		hdto.setTitle(rs.getString("title"));
		hdto.setUserid(rs.getString("userid"));
		hdto.setContet(rs.getString("content"));
		hdto.setWriteday(rs.getString("writeday"));
		hdto.setReadnum(rs.getInt("readnum"));
		
		String[] arrayimg = rs.getString("img").split(",");
		hdto.setArryimg(arrayimg);
		
		request.setAttribute("hdto", hdto);
	}
	
	public void update(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		
		String sql ="select * from hboard where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		
		HugiDto hdto = new HugiDto();
		hdto.setId(rs.getInt("id"));
		hdto.setTitle(rs.getString("title"));
		hdto.setUserid(rs.getString("userid"));
		hdto.setContet(rs.getString("content"));
		hdto.setWriteday(rs.getString("writeday"));
		hdto.setReadnum(rs.getInt("readnum"));
		
		String[] arrayimg = rs.getString("img").split(",");
		hdto.setArryimg(arrayimg);
		
		request.setAttribute("hdto", hdto);
		
	}
	
	public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String path = request.getRealPath("/hugi/img");
		int size = 1024*1204*100;
		
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		String id = multi.getParameter("id");
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String dimg = multi.getParameter("dimg");
		String aimg = multi.getParameter("aimg");
		String mychk = multi.getParameter("mychk");
		
		//추가할 이미지 가져오기
		Enumeration enu = multi.getFileNames(); // type="file"의 이름을 다 가져옴
		String addimg = "";
		while(enu.hasMoreElements()) { // 꺼내올게 있는지 확인하는 것.
			String imsi = enu.nextElement().toString(); // 꺼내오기 + string으로 변환
			
			addimg = addimg + multi.getFilesystemName(imsi)+",";
		}
		
		addimg = addimg.replace("null,", ""); // null값으로 들어온 값을 빈값으로 넣는다.
		//추가할 이미지에 기존 이미지 더하기
		String img = aimg + addimg; // 이미지 추가 완료.
		
		
		// 이미지 삭제하기
		String[] del = dimg.split(",");
		
		for(int i=0; i<del.length; i++) {
			File file = new File(path+"/"+del[i]);
			if(file.exists()) {
				file.delete();
			} // 이미지 삭제 완료
		}
		
		//쿼리생성
		String sql = "update hboard set title=?,content=?,img=? where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, img);
		pstmt.setString(4, id);
		System.out.println(pstmt.toString());
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		if(mychk == null)
			response.sendRedirect("content.jsp?id="+id);
		else
			response.sendRedirect("../inquiry/mine.jsp");
		
	}
	
	public void delete(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (session.getAttribute("userid") == null) {
			response.sendRedirect("../member/login.jsp");
		} else {

			String id = request.getParameter("id");

			String sql = "delete from hboard where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			if(request.getParameter("mychk") == null)
				response.sendRedirect("list.jsp");
			else
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
			String sql = "select * from hboard order by id desc limit ?,10";
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
			String sql = "select ceil(count(*)/10) as chong from hboard";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			int chong = rs.getInt("chong");
			return chong;
		}
	
	
		public void getFiveHugi(HttpServletRequest request) throws Exception {
			String sql = "select id,title,writeday from hboard order by id desc limit 5";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ArrayList<HugiDto> hlist = new ArrayList<HugiDto>();
			
			while(rs.next()) {
				
				HugiDto hdto = new HugiDto();
				
				hdto.setId(rs.getInt("id"));
				hdto.setTitle(rs.getString("title"));
				hdto.setWriteday(rs.getString("writeday"));
				
				hlist.add(hdto);
			}
			
			request.setAttribute("hlist", hlist);
			
			rs.close();
			pstmt.close();
			conn.close();
		}
	
	
}
