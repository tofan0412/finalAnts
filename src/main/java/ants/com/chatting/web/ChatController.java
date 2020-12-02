package ants.com.chatting.web;

import java.util.List;

import javax.annotation.Resource;
import javax.xml.registry.infomodel.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.support.SecurityContextProvider;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatVo;
import ants.com.chatting.service.ChatService;
import ants.com.member.model.ProjectMemberVo;

@RequestMapping("/chat")
@Controller
public class ChatController {
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	@Resource(name="chatService")
	ChatService chatService;
	
	
	@RequestMapping("/readChatList")
	public String readChatList(String reqId, Model model) {
		
		List<ChatGroupVo> chatList = chatService.readChatList(reqId);
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
	
	// 전송한 메시지를 DB에 저장한다..
	@RequestMapping("/sendMessage")
	public void sendMessage(ChatVo chatVo) {
		int result = chatService.sendMessage(chatVo);
		
		logger.debug("chat 전송 결과 : {}",result);
	}
	
	@RequestMapping("/readChatMembers")
	public String readChatMembers(String reqId, Model model) {
		List<ProjectMemberVo> chatMemList = chatService.readChatMembers(reqId);
		
		model.addAttribute("chatMemList", chatMemList);
		return "chat/chatMemList";
	}
	
	
	
	
}
