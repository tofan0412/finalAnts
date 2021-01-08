package ants.com.common.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ants.com.common.model.MsgVo;
import ants.com.common.service.MsgService;

@RequestMapping("/msg")
@Controller
public class MsgController {

	@Resource(name="msgService")
	MsgService msgService;
	
	@RequestMapping("/insertMsg")
	@ResponseBody
	public int insertMsg(MsgVo msgVo) {
		return msgService.insertMsg(msgVo);
	}
	
	@RequestMapping("/msgList")
	public String msgList(MsgVo msgVo, Model model){
		List<MsgVo> result = msgService.msgList(msgVo);
		
		model.addAttribute("msgList", result);
		return "admin.tiles/admin/adminMsgList";
	}
	
}
