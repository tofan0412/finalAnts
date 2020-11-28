package ants.com.member.web;



import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.member.service.PmServiceI;


@RequestMapping("/req")
@Controller
public class ReqListController {
	private static final Logger logger = LoggerFactory.getLogger(ReqListController.class);
	
	@Resource(name="pmService")
	private PmServiceI pmService;
	
	@RequestMapping("/reqList")
	public String selectReqList() {
		return "member/pmReqList";
	}

	
}
