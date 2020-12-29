package ants.com.common.model;

import java.util.Arrays;

import ants.com.base.model.BaseVo;

public class AlarmVo extends BaseVo{

	
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
	private String reqStatus;
	private String[] memIds;
	private String del;
	private String url;
	private String id;
	private String reqId;
	private String regDt;
	private String regTime;
	private String days;
	
	
	
	
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public String getRegTime() {
		return regTime;
	}
	public void setRegTime(String regTime) {
		this.regTime = regTime;
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
	public String getReqStatus() {
		return reqStatus;
	}
	public void setReqStatus(String reqStatus) {
		this.reqStatus = reqStatus;
	}
	public String[] getMemIds() {
		return memIds;
	}
	public void setMemIds(String[] memIds) {
		this.memIds = memIds;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	
	
	
	@Override
	public String toString() {
		return "AlarmVo [alarmId=" + alarmId + ", alarmCont=" + alarmCont + ", alarmStatus=" + alarmStatus + ", memId="
				+ memId + ", alarmType=" + alarmType + ", reqPl=" + reqPl + ", resPl=" + resPl + ", reply=" + reply
				+ ", posts=" + posts + ", totalCnt=" + totalCnt + ", reqStatus=" + reqStatus + ", memIds="
				+ Arrays.toString(memIds) + ", del=" + del + ", url=" + url + ", id=" + id + ", reqId=" + reqId
				+ ", regDt=" + regDt + ", regTime=" + regTime + ", days=" + days + "]";
	}
	public AlarmVo() {
		
	}
	
	
	
	
	
	

	
	
}
