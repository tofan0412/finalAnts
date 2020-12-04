package ants.com.common.model;

public class AlarmVo {

	
	private String alarmId;
	private String alarmCont;
	private String alarmStatus;
	private String memId;
	private String alarmType;
	
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
	@Override
	public String toString() {
		return "AlarmVo [alarmId=" + alarmId + ", alarmCont=" + alarmCont + ", alarmStatus=" + alarmStatus + ", memId="
				+ memId + ", alarmType=" + alarmType + "]";
	}
	
	

	
	
}
