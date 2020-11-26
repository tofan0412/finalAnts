package ants.com.common.model;

public class ChatBotVo {
	
	
	private String bot_id;
	private String bot_cont;
	
	
	public String getBot_id() {
		return bot_id;
	}
	public void setBot_id(String bot_id) {
		this.bot_id = bot_id;
	}
	public String getBot_cont() {
		return bot_cont;
	}
	public void setBot_cont(String bot_cont) {
		this.bot_cont = bot_cont;
	}
	
	
	@Override
	public String toString() {
		return "ChatBotVo [bot_id=" + bot_id + ", bot_cont=" + bot_cont + "]";
	}
	
	
	
}
