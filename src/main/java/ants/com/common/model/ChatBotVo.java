package ants.com.common.model;

public class ChatBotVo {
	private String botId;
	private String botCont;
	public String getBotId() {
		return botId;
	}
	public void setBotId(String botId) {
		this.botId = botId;
	}
	public String getBotCont() {
		return botCont;
	}
	public void setBotCont(String botCont) {
		this.botCont = botCont;
	}
	@Override
	public String toString() {
		return "ChatBotVo [botId=" + botId + ", botCont=" + botCont + "]";
	}
	
	
	
}
