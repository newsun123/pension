package pension.util;

import java.io.File;
import java.text.DecimalFormat;
import java.time.LocalDate;

public class Util {
	//가격의 , 를 찍어주는 유틸을 만들자잉
	public static String comma(int num) {
		
		DecimalFormat df = new DecimalFormat("#,###");
		//df.format(num);
		
		return df.format(num);	
		
	}
	//xday부터 suk값 이후의 날짜를 String으로 리턴해주기
	public static LocalDate getDate(String xday, int suk) {
		// xday의 값을 가지고 날짜 객체를 생성
		String[] imsi = xday.split("-");
		int y = Integer.parseInt(imsi[0]);
		int m = Integer.parseInt(imsi[1]);
		int d = Integer.parseInt(imsi[2]);
		LocalDate myday = LocalDate.of(y, m, d);
		
		//myday로부터 suk 변수 값에 해당하는 날
		LocalDate resultday = myday.plusDays(suk);
		
		return resultday;
		
	}
	
	//오늘 날자와 특정 날자를 비교하여 이전인지 체크하는 메소드
	public static boolean isCheck(int y, int m, int d) {
		LocalDate today = LocalDate.now(); // 당일날짜 확인
		LocalDate xday = LocalDate.of(y, m, d);
		
		boolean kk = xday.isBefore(today);
		
		return kk;
		
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
