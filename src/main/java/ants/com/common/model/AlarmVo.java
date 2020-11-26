package ants.com.common.model;

public class AlarmVo {

	
	private String alarm_id;
	private String alarm_cont;
	private String alarm_status;
	private String mem_id;
	
	
	public String getAlarm_id() {
		return alarm_id;
	}
	public void setAlarm_id(String alarm_id) {
		this.alarm_id = alarm_id;
	}
	public String getAlarm_cont() {
		return alarm_cont;
	}
	public void setAlarm_cont(String alarm_cont) {
		this.alarm_cont = alarm_cont;
	}
	public String getAlarm_status() {
		return alarm_status;
	}
	public void setAlarm_status(String alarm_status) {
		this.alarm_status = alarm_status;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	
	@Override
	public String toString() {
		return "AlarmVo [alarm_id=" + alarm_id + ", alarm_cont=" + alarm_cont + ", alarm_status=" + alarm_status
				+ ", mem_id=" + mem_id + "]";
	}
	
	
	
}
