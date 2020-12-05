package ants.com.chatting.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatMemberVo;
import ants.com.chatting.model.ChatVo;
import ants.com.chatting.service.ChatService;
import ants.com.member.model.ProjectMemberVo;

@RequestMapping("/chat")
@Controller
public class ChatController {
	@Resource(name="chatService")
	ChatService chatService;
	
	@RequestMapping("/readChatList")
	public String readChatList(String memId, Model model) {
		
//		List<ChatGroupVo> chatList = chatService.readChatList(memId);
//		
//		model.addAttribute("chatList", chatList);
		return "chat/chatList";
	}
	
	@RequestMapping("/readMessages")
	public String readMessages(String cgroupId, Model model) {
		// 채팅방 번호에 맞는 메시지를 모두 불러온다 !
		List<ChatVo> msgList = chatService.readMessages(cgroupId);
		
		// 채팅방 이름을 불러오기 위해, cgroupId PK를 이용하여 객체를 불러온다.
		ChatGroupVo cgroup = chatService.readCgroupName(cgroupId);
		
		model.addAttribute("msgList", msgList);
		model.addAttribute("cgroup", cgroup);
		
		return "chat/msgList";
	}
	
	// 전송한 메시지를 DB에 저장한다..
	@RequestMapping("/sendMessage")
	@ResponseBody
	public String sendMessage(ChatVo chatVo) {
		int result = chatService.sendMessage(chatVo);
		if (result > 0) {
			return "yes";
		}
		else return "error";
	}
	
	@RequestMapping("/readChatMembers")
	public String readChatMembers(String projectId, Model model) {
		List<ProjectMemberVo> chatMemList = chatService.readChatMembers(projectId);
		
		model.addAttribute("chatMemList", chatMemList);
		return "chat/chatMemList";
	}
	
	@RequestMapping("/insertChatGroup")
	@ResponseBody	// view를 생성하는 것이 아니라, Object 또는 JSON 을 전송할 수 있다.
	public String insertChatGroup(ChatGroupVo chatGroupVo, Model model) {
		chatService.insertChatGroup(chatGroupVo);
		return chatGroupVo.getCgroupId();
	}
	
	@RequestMapping("/insertChatMembers")
	@ResponseBody	// view를 생성하는 것이 아니라, Object 또는 JSON 을 전송할 수 있다.
	public int insertChatMembers(@RequestParam(value="memList[]")String[] memList, 
								  @RequestParam(value="cgroupId") String cgroupId) {
		
		int result = 0;
		for (int i = 0 ; i < memList.length ; i++) {
			
			ChatMemberVo chatMemberVo = new ChatMemberVo();
			chatMemberVo.setMemId(memList[i]);
			chatMemberVo.setCgroupId(cgroupId);
			
			result += chatService.insertChatMembers(chatMemberVo);
		}
		return result;
	}
}
