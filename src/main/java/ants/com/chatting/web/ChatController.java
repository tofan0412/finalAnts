package ants.com.chatting.web;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatVo;
import ants.com.chatting.service.ChatService;

@RequestMapping("/chat")
@Controller
public class ChatController {
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	@Resource(name="chatService")
	ChatService chatService;
	
	
	@RequestMapping("/readChatList")
	public String readChatList(String memId, Model model) {
		
		List<ChatGroupVo> chatList = chatService.readChatList(memId);
		logger.debug("불러온 채팅 개수 : {}", chatList.size());
		
		
		model.addAttribute("chatList", chatList);
		return "chat/chatList";
	}
	
	@RequestMapping("/readMessages")
	public String readMessages(String cgroupId, Model model) {
		List<ChatVo> msgList = chatService.readMessages(cgroupId);
		
		ChatGroupVo cgroup = chatService.readChatGroup(cgroupId);
		
		model.addAttribute("msgList", msgList);
		model.addAttribute("cgroup", cgroup);
		
		return "chat/msgList";
	}
	
}
