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
	@Override
	public String toString() {
		return "AlarmVo [alarmId=" + alarmId + ", alarmCont=" + alarmCont + ", alarmStatus=" + alarmStatus + ", memId="
				+ memId + ", alarmType=" + alarmType + ", reqPl=" + reqPl + ", resPl=" + resPl + ", reply=" + reply
				+ ", posts=" + posts + ", totalCnt=" + totalCnt + ", reqStatus=" + reqStatus + ", memIds="
				+ Arrays.toString(memIds) + "]";
	}
	
	
	
	
	
	
	
	

	
	
}
