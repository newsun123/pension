package pension.dto;

public class HugiDto {

	private int id , readnum;
	private String title,contet,img, userid, writeday;
	
	private int pager,index,pstart,pend,chong;
	
	public String getUserid() {
		return userid;
	}

	public int getPager() {
		return pager;
	}

	public void setPager(int pager) {
		this.pager = pager;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getPstart() {
		return pstart;
	}

	public void setPstart(int pstart) {
		this.pstart = pstart;
	}

	public int getPend() {
		return pend;
	}

	public void setPend(int pend) {
		this.pend = pend;
	}

	public int getChong() {
		return chong;
	}

	public void setChong(int chong) {
		this.chong = chong;
	}

	public String getWriteday() {
		return writeday;
	}

	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	private String[] arryimg;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getReadnum() {
		return readnum;
	}

	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContet() {
		return contet;
	}

	public void setContet(String contet) {
		this.contet = contet;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String[] getArryimg() {
		return arryimg;
	}

	public void setArryimg(String[] arryimg) {
		this.arryimg = arryimg;
	}
	
}
