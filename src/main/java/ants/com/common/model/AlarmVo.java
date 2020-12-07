package ants.com.common.model;

public class AlarmVo {

	
	private String alarmId;
	private String alarmCont;
	private String alarmStatus;
	private String memId;
	private String alarmType;
	private int reqPl;
	private int resPl;
	private int reply;
	private int posts;
	private int totalCnt;
	
	public AlarmVo() {
		
	}
	public String getAlarmId() {
		return alarmId;
	}
	public void setAlarmId(String alarmId) {
		this.alarmId = alarmId;
	}
	public String getAlarmCont() {
		return alarmCont;
	}
	public void setAlarmCont(String alarmCont) {
		this.alarmCont = alarmCont;
	}
	public String getAlarmStatus() {
		return alarmStatus;
	}
	public void setAlarmStatus(String alarmStatus) {
		this.alarmStatus = alarmStatus;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getAlarmType() {
		return alarmType;
	}
	public void setAlarmType(String alarmType) {
		this.alarmType = alarmType;
	}
	public int getReqPl() {
		return reqPl;
	}
	public void setReqPl(int reqPl) {
		this.reqPl = reqPl;
	}
	public int getResPl() {
		return resPl;
	}
	public void setResPl(int resPl) {
		this.resPl = resPl;
	}
	public int getReply() {
		return reply;
	}
	public void setReply(int reply) {
		this.reply = reply;
	}
	public int getPosts() {
		return posts;
	}
	public void setPosts(int posts) {
		this.posts = posts;
	}
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	public AlarmVo(String alarmId, String alarmCont, String alarmStatus, String memId, String alarmType, int reqPl,
			int resPl, int reply, int posts, int totalCnt) {
		super();
		this.alarmId = alarmId;
		this.alarmCont = alarmCont;
		this.alarmStatus = alarmStatus;
		this.memId = memId;
		this.alarmType = alarmType;
		this.reqPl = reqPl;
		this.resPl = resPl;
		this.reply = reply;
		this.posts = posts;
		this.totalCnt = totalCnt;
	}
	
	
	
	
	

	
	
}
