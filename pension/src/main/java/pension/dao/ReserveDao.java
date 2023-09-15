package pension.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pension.dto.ReserveDto;
import pension.dto.RoomDto;
import pension.util.Util;


public class ReserveDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	public ReserveDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/pension";
		conn = DriverManager.getConnection(db, "root", "1234");
	}

	public void getCalendar(HttpServletRequest request) {
		// 달력
		int year, month;
		// 다음달도 만들기
		if (request.getParameter("year") != null) { // 년,월이 오는 경우
			year = Integer.parseInt(request.getParameter("year"));
			month = Integer.parseInt(request.getParameter("month"));
			// month가 0이 오는 경우
			if (month == 0) {
				year--;
				month = 12;
			}
			// month가 13이 오는 경우
			if (month == 13) {
				year++;
				month = 1;
			}
		} else { // 년,월이 없는 경우

			// 오늘 날짜 = > 1일의 요일을 구한다, 몇주, 총일수
			LocalDate today = LocalDate.now();
			year = today.getYear(); // year
			month = today.getMonthValue(); // month - can nhan so thi phai dung Value.

		}

		// ngay trong tuan
		// today.getDayOfWeek().getValue(); // can nhan so thi dung .getValue(); neu ko
		// dung getValue thi nhan ngay torng tuan o tieng anh// 1~7 (CN la 7)
		// 오늘 요일은 달력에 필요없다.
		// 년/월에 해당하는 달의 1일의 요일에 해당하는 날짜 객체를 생성
		LocalDate xday = LocalDate.of(year, month, 1); // of(year,month,date)
		// 1일의 요일
		int yoil = xday.getDayOfWeek().getValue();
		// 비어있는 칸수 찾기
		if (yoil == 7)
			yoil = 0;
		// 총 일수
		int chong = xday.lengthOfMonth();
		// 몇주
		// System.out.println(chong+yoil;
		int ju = (int) Math.ceil((chong + yoil) / 7.0);

		request.setAttribute("yoil", yoil);
		request.setAttribute("chong", chong);
		request.setAttribute("ju", ju);
		request.setAttribute("year", year);
		request.setAttribute("month", month);
	}

	public void getRoomInfo(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");

		String sql = "select * from room where id=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		// rs = > dto
		RoomDto rdto = new RoomDto();
		rdto.setId(rs.getInt("id"));
		rdto.setName(rs.getString("name"));
		rdto.setPrice(rs.getInt("price"));
		rdto.setMin(rs.getInt("min"));
		rdto.setMax(rs.getInt("max"));
		rdto.setContent(rs.getString("content"));
		rdto.setImg(rs.getString("img"));

		request.setAttribute("rdto", rdto);

		// 년,월,일 합치기
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");

		String inday = year + "년 " + month + "월 " + day + "일";
		String inday2 = year + "-" + month + "-" + day;
		request.setAttribute("inday", inday);
		request.setAttribute("inday2", inday2);
	}

	public void reserve_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		// 저장할 것 읽어오기
		request.setCharacterEncoding("utf-8");
		String inday = request.getParameter("inday");
		//outday 만들기
		int suk = Integer.parseInt(request.getParameter("suk"));
		
		LocalDate outday = Util.getDate(inday, suk);
		
		
		String rid = request.getParameter("rid");
		String userid = session.getAttribute("userid").toString();
		String inwon = request.getParameter("inwon");
		String bbq = request.getParameter("bbq");
		String chacol = request.getParameter("chacol");
		String chongprice = request.getParameter("chongprice");
		

		
		// 주문번호 생성 => j+년월일+001부터 시작
		LocalDate today = LocalDate.now();
		int year = today.getYear();
		int month = today.getMonth().getValue();
		int date = today.getDayOfMonth();
		// 월, 일이 1자리 수일때 0 붙여주기
		String mon = month + "";
		if (mon.length() == 1) {
			mon = "0" + mon;
		}
		String day = date + "";
		if (day.length() == 1) {
			day = "0" + day;
		}
		String jcode = "j" + year + mon + day;

		String sql = "select max( right(jcode,3) ) as num from reserve where jcode like ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, jcode + "%");

		rs = pstmt.executeQuery();
		rs.next();
		int num = rs.getInt("num") + 1;

		String num2 = num + "";
		if (num2.length() == 1) {
			num2 = "00" + num2;
		} else if (num2.length() == 2) {
			num2 = "0" + num2;
		}
		jcode = jcode + num2;
		
		// 쿼리생성
		sql = "insert into reserve(inday,outday,rid,userid,inwon,bbq,chacol,chongprice,writeday,jcode)";
		sql = sql + " values(?,?,?,?,?,?,?,?,now(),?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, inday);
		pstmt.setString(2, outday.toString());
		pstmt.setString(3, rid);
		pstmt.setString(4, userid);
		pstmt.setString(5, inwon);
		pstmt.setString(6, bbq);
		pstmt.setString(7, chacol);
		pstmt.setString(8, chongprice);
		pstmt.setString(9, jcode);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("reserve_view.jsp?jcode="+jcode);
	}
	
	public void reserve_view_old(HttpServletRequest request) throws Exception {
		String jcode = request.getParameter("jcode");
		
		String sql = "select * from reserve where jcode=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, jcode);
		rs = pstmt.executeQuery();
		rs.next();
		
		ReserveDto rdto = new ReserveDto();
		rdto.setId(rs.getInt("id"));
		rdto.setInday(rs.getString("inday"));
		rdto.setOutday(rs.getString("outday"));
		rdto.setRid(rs.getInt("rid"));
		rdto.setUserid(rs.getString("userid")); // 궂이
		rdto.setInwon(rs.getInt("inwon"));
		rdto.setBbq(rs.getInt("bbq"));
		rdto.setChacol(rs.getInt("chacol"));
		rdto.setChongprice(rs.getInt("chongprice"));
		rdto.setWriteday(rs.getString("writeday"));
		rdto.setJcode(rs.getString("jcode"));
		
		
		//예약한room테이블의 이름을 가져오기
		sql = "select name from room where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, rdto.getRid());
		rs = pstmt.executeQuery();
		rs.next();
		//request.setAttribute("name",rs.getString("name"));
		rdto.setName(rs.getString("name"));
		
		request.setAttribute("rdto", rdto);
	}
	
	public void reserve_view(HttpServletRequest request) throws Exception {
		String jcode = request.getParameter("jcode");
		// inner join 사용하기
		String sql = "select r1.* , r2.name from reserve as r1 inner join room as r2 on r1.rid=r2.id where jcode=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, jcode);
		rs = pstmt.executeQuery();
		rs.next();
		
		ReserveDto rdto = new ReserveDto();
		rdto.setId(rs.getInt("id"));
		rdto.setInday(rs.getString("inday"));
		rdto.setOutday(rs.getString("outday"));
		rdto.setRid(rs.getInt("rid"));
		rdto.setUserid(rs.getString("userid")); // 궂이
		rdto.setInwon(rs.getInt("inwon"));
		rdto.setBbq(rs.getInt("bbq"));
		rdto.setChacol(rs.getInt("chacol"));
		rdto.setChongprice(rs.getInt("chongprice"));
		rdto.setWriteday(rs.getString("writeday"));
		rdto.setJcode(rs.getString("jcode"));
		rdto.setName(rs.getString("name"));
		
		request.setAttribute("rdto", rdto);
	}
	
	//특정 날자의 예약 가능 여부를 리턴해주는 메소드를 생성(boolean)
	public boolean isEmpty(int y, int m, int d, int rid) throws Exception {
		String ymd= y+"-"+m+"-"+d; // yyyy-mm-dd
		
		String sql = "select * from reserve where inday <= ? and outday > ? and rid=? and state !=2";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, ymd);
		pstmt.setString(2, ymd);
		pstmt.setInt(3, rid);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			//예약 불가
			return false;
		}else {
			//예약 가능
			return true;
		}
	}
	
	//숙박일수 보내주기 - reserve_next 67
	public int getSuk(HttpServletRequest request) throws Exception {
		int y = Integer.parseInt(request.getParameter("year"));
		int m = Integer.parseInt(request.getParameter("month"));
		int d = Integer.parseInt(request.getParameter("day"));
		int rid = Integer.parseInt(request.getParameter("id")); //reserve테이블이 rid값
		//숙박 시작일의 날짜 객체를 생성하기
		LocalDate xday = LocalDate.of(y, m, d);
		
		int suk=1; // 클릭하는 날은 숙박이 되기 때문에 숫자 1을 준다.
		// 숙박원하는 날짜 2023-07-15는 1박 무조건 가능.
		for(int i=1;i<=6;i++) { //6번만 돌기 때문에 최대 7박이다.
			//2023-07-16 부터 숙박 가능 검사 = > 가능시 suk++
			xday = xday.plusDays(1); // xday 하루 다음날의 날짜 정보를 다시 xday에 저장
			String sql ="select * from reserve where inday <= ? and outday > ? and rid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, xday.toString());
			pstmt.setString(2, xday.toString());
			pstmt.setInt(3, rid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				break; // 있으면 끝.
			}else {
				suk++; // 없으므로 suk 일자 1 추가
			}
		}
		
		return suk;
	}
	
	public void sendLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String id = request.getParameter("id");
		
		response.sendRedirect("../member/login.jsp?year="+year+"&month="+month+"&day="+day+"&id="+id);
		
	}
	
	//mypage 보여주기
	public void my_reserve(HttpSession session, HttpServletRequest request) throws Exception {
		String userid = session.getAttribute("userid").toString();
		
		String sql = "select * from reserve where userid=? order by inday desc";
		pstmt =conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		rs = pstmt.executeQuery();
		
		ArrayList<ReserveDto> relist = new ArrayList<ReserveDto>();
		
		while(rs.next()) {
			ReserveDto rdto = new ReserveDto();
			rdto.setId(rs.getInt("id"));
			rdto.setInday(rs.getString("inday"));
			rdto.setOutday(rs.getString("outday"));
			rdto.setRid(rs.getInt("rid"));
			rdto.setUserid(rs.getString("userid"));
			rdto.setInwon(rs.getInt("inwon"));
			rdto.setBbq(rs.getInt("bbq"));
			rdto.setChacol(rs.getInt("chacol"));
			rdto.setChongprice(rs.getInt("chongprice"));
			rdto.setWriteday(rs.getString("writeday"));
			rdto.setJcode(rs.getString("jcode"));
			rdto.setState(rs.getInt("state"));
			
			relist.add(rdto);
		}
		request.setAttribute("relist", relist);
		
	}
	
	public void chgstate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String state = request.getParameter("state");
		String id = request.getParameter("id");
				
		String sql = "update reserve set state=? where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, state);
		pstmt.setString(2, id);
		
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		response.sendRedirect("my_reserve.jsp");
	}
	
	
}
