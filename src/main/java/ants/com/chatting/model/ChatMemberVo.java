package ants.com.chatting.model;

public class ChatMemberVo {

	
	private String cgroup_id;
	private String chatmem_id;
	private String promem_id;
	
	
	public String getCgroup_id() {
		return cgroup_id;
	}
	public void setCgroup_id(String cgroup_id) {
		this.cgroup_id = cgroup_id;
	}
	public String getChatmem_id() {
		return chatmem_id;
	}
	public void setChatmem_id(String chatmem_id) {
		this.chatmem_id = chatmem_id;
	}
	public String getPromem_id() {
		return promem_id;
	}
	public void setPromem_id(String promem_id) {
		this.promem_id = promem_id;
	}
	
	
	@Override
	public String toString() {
		return "ChatMemberVo [cgroup_id=" + cgroup_id + ", chatmem_id=" + chatmem_id + ", promem_id=" + promem_id + "]";
	}
	
	
	
	
}
