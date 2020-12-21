package ants.com.board.manageBoard.model;

public class todoHistoryVo {
	private String todoHid;
	private String todoId;
	private String regDt;
	private String percent;
	private String memId;
	private String memName;
	private String reqId;

	
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getTodoHid() {
		return todoHid;
	}
	public void setTodoHid(String todoHid) {
		this.todoHid = todoHid;
	}
	public String getTodoId() {
		return todoId;
	}
	public void setTodoId(String todoId) {
		this.todoId = todoId;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getPercent() {
		return percent;
	}
	public void setPercent(String percent) {
		this.percent = percent;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	@Override
	public String toString() {
		return "todoHistoryVo [todoHid=" + todoHid + ", todoId=" + todoId + ", regDt=" + regDt + ", percent=" + percent
				+ ", memId=" + memId + ", memName=" + memName + ", reqId=" + reqId + "]";
	}

}
