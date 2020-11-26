package ants.com.chatting.model;

public class ChatGroupVo {

	
	private String cgroup_id;
	private String cgroup_name;
	private String req_id;
	
	
	public String getCgroup_id() {
		return cgroup_id;
	}
	public void setCgroup_id(String cgroup_id) {
		this.cgroup_id = cgroup_id;
	}
	public String getCgroup_name() {
		return cgroup_name;
	}
	public void setCgroup_name(String cgroup_name) {
		this.cgroup_name = cgroup_name;
	}
	public String getReq_id() {
		return req_id;
	}
	public void setReq_id(String req_id) {
		this.req_id = req_id;
	}
	
	
	@Override
	public String toString() {
		return "ChatGroupVo [cgroup_id=" + cgroup_id + ", cgroup_name=" + cgroup_name + ", req_id=" + req_id + "]";
	}
	
	
	
}
