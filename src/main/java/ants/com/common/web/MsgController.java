package ants.com.common.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
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
	
}
