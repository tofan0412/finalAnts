package ants.com.chatting.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatHistoryVo;
import ants.com.chatting.model.ChatMemberVo;
import ants.com.chatting.model.ChatVo;
import ants.com.chatting.service.ChatService;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.service.MemberService;

@RequestMapping("/chat")
@Controller
public class ChatController {
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	@Resource(name = "chatService")
	ChatService chatService;

	@Resource(name = "memberService")
	MemberService memberService;

	// 내가 참여하고 있는 모든 채팅방 목록을 불러온다.
	@RequestMapping("/readChatList")
	public String readChatList(ChatGroupVo chatGroupVo, Model model) {

		List<ChatGroupVo> chatList = chatService.readChatList(chatGroupVo);
		List<List<ChatMemberVo>> eachChatMemList = new ArrayList<>();
		List<String> recentMsgList = new ArrayList<>();
		
		// 각각의 채팅방에 대해, 채팅방 참여 멤버도 뽑아온다.
		for (int i = 0; i < chatList.size(); i++) {
			List<ChatMemberVo> chatMemList = chatService.readCgroupMembers(chatList.get(i).getCgroupId());
			eachChatMemList.add(chatMemList);
			// 각각의 채팅방 최신 메시지를 뽑아오기 위해, 메시지 리스트도 뽑아온다.  
			String recentMsg = chatService.recentMsg(chatList.get(i).getCgroupId());
			recentMsgList.add(recentMsg);
		}
		
		model.addAttribute("recentMsgList", recentMsgList);
		model.addAttribute("eachChatMemList", eachChatMemList);
		model.addAttribute("chatList", chatList);
		return "chat/chatList";
	}

	// 채팅방 이름을 누르면, 해당 채팅방 PK를 세션에 저장한다.
	@RequestMapping("/changeCgroupSession")
	public String changeCgroupSession(String cgroupId, HttpSession session) {
		session.setAttribute("cgroupId", cgroupId);
		return "success";
	}

	@RequestMapping("/readMessages")
	public String readMessages(String cgroupId, Model model, HttpSession session) {

		// 채팅방 번호에 맞는 메시지를 모두 불러온다 !
		List<ChatVo> msgList = chatService.readMessages(cgroupId);

		// 채팅방 이름을 불러오기 위해, cgroupId PK를 이용하여 객체를 불러온다.
		ChatGroupVo cgroup = chatService.readCgroupName(cgroupId);

		// 채팅방에 참여하고 있는 회원 리스트를 불러온다.
		List<ChatMemberVo> chatMemList = chatService.readCgroupMembers(cgroupId);
		
		// 유저 이름을 알기 위해, 회원 정보 또한 출력해 온다.
		List<MemberVo> memInfoList = new ArrayList<>();
		for (int i = 0; i < chatMemList.size(); i++) {
			MemberVo memInfo = new MemberVo();
			memInfo.setMemId(chatMemList.get(i).getMemId());

			MemberVo memberVo = memberService.getMember(memInfo);
			memInfoList.add(memberVo);
		}
		
		model.addAttribute("memInfoList", memInfoList);
		model.addAttribute("chatMemList", chatMemList);
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
		} else
			return "error";
	}

	// 현재 프로젝트에 참여하고 있는 모든 멤버 목록을 불러온다.
	@RequestMapping("/readChatMembers")
	public String readChatMembers(String projectId, HttpSession session, Model model) {
		List<ProjectMemberVo> chatMemList = chatService.readChatMembers(projectId);
		
		// 위 리스트에서 로그인한 당사자는 제외해야 한다. 
		MemberVo smember =(MemberVo) session.getAttribute("SMEMBER");
		for (int i = 0 ; i < chatMemList.size(); i++) {
			if (smember.getMemId().equals(chatMemList.get(i).getMemId())) {
				chatMemList.remove(i);
			}
		}
		
		// 해당 memId를 통해 유저 정보를 출력하기 위해, 유저 리스트 또한 함께 저장한다.
		List<MemberVo> memInfoList = new ArrayList<>();

		for (int i = 0; i < chatMemList.size(); i++) {
			MemberVo memInfo = new MemberVo();
			memInfo.setMemId(chatMemList.get(i).getMemId());

			MemberVo memberVo = memberService.getMember(memInfo);
			memInfoList.add(memberVo);
		}

		model.addAttribute("memInfoList", memInfoList);
		model.addAttribute("chatMemList", chatMemList);
		return "chat/chatMemList";
	}

	// 채팅 그룹을 생성한다.
	@RequestMapping("/insertChatGroup")
	@ResponseBody // view를 생성하는 것이 아니라, Object 또는 JSON 을 전송할 수 있다.
	public String insertChatGroup(ChatGroupVo chatGroupVo, Model model) {
		chatService.insertChatGroup(chatGroupVo);
		return chatGroupVo.getCgroupId();
	}

	// 사용자가 생성한 채팅 그룹에 대한 멤버를 DB에 저장한다.
	@RequestMapping("/insertChatMembers")
	@ResponseBody // view를 생성하는 것이 아니라, Object 또는 JSON 을 전송할 수 있다.
	public String insertChatMembers(@RequestParam(value = "memList[]") String[] memList,
			@RequestParam(value = "cgroupId") String cgroupId) {

		int cnt = 0;
		for (int i = 0; i < memList.length; i++) {

			ChatMemberVo chatMemberVo = new ChatMemberVo();
			chatMemberVo.setMemId(memList[i]);
			chatMemberVo.setCgroupId(cgroupId);

			cnt += chatService.insertChatMembers(chatMemberVo);
			
			// 회원별로, 해당 채팅방에서 마지막으로 읽은 메시지 인덱스가 몇번인지를 저장해야 한다.
			ChatHistoryVo chatHistoryVo = new ChatHistoryVo();
			chatHistoryVo.setCgroupId(cgroupId);
			chatHistoryVo.setMemId(memList[i]);
			
			chatService.insertChatHistory(chatHistoryVo);
		}
		
		// cnt : 개설한 채팅방에 초대한 인원을 나타낸다.
		String result = cgroupId.concat("$$").concat(Integer.toString(cnt));
		return result;
	}
	
	// 사용자가 한 채팅방에서 읽은 최신 메시지 번호를 기록해 둔다.
	@RequestMapping("/updateChatHistory")
	@ResponseBody
	public int updateChatHistory(String memId, String cgroupId, String chatId) {
		
		ChatHistoryVo chatHistoryVo = new ChatHistoryVo();
		chatHistoryVo.setMemId(memId);
		chatHistoryVo.setCgroupId(cgroupId);
		chatHistoryVo.setChatId(chatId);
		int result = chatService.updateChatHistory(chatHistoryVo);
		return result;
	}
	
	@RequestMapping("/exitChat")
	@ResponseBody
	public int exitChat(ChatMemberVo chatMemberVo) {
		int result = chatService.exitChat(chatMemberVo);
		return result;
	}
	
	
}
