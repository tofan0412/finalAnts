package ants.com.file.web;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.admin.service.AdminService;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.common.model.IpHistoryVo;
import ants.com.member.model.MemberVo;
import ants.com.member.service.ProjectmemberService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@RequestMapping("/excel")
@Controller
public class ExcelContoller {
	
	@Resource(name="promemService")
	ProjectmemberService promemService;
	
	@Resource(name="adminService")
	AdminService adminService;
	
	@RequestMapping("/memlistexcelDown")
	public String memlistexcelDown(Model model, HttpSession session) {

		List<MemberVo> resultList = adminService.allmemberlist();
		
		// Model 객페에 header, data
		List<String> header = new ArrayList<String>();
		header.add("No");
		header.add("회원 아이디");
		header.add("회원 이름");
		header.add("회원 전화번호");
		header.add("직급");
		header.add("탈퇴여부");
		
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();		
		
		for(int i =0; i< resultList.size();i++) {
			Map<String, String > map = new HashMap<String, String>();
			map.put("memId", resultList.get(i).getMemId());
			map.put("memName", resultList.get(i).getMemName());
			map.put("memTel", resultList.get(i).getMemTel());
			map.put("memType", resultList.get(i).getMemType());
			map.put("del", resultList.get(i).getDel());
			data.add(map);
		}

		model.addAttribute("header", header);
		model.addAttribute("data", data);
		
		
		return "memexcelView";
	}
	
	@RequestMapping("/iplistexcelDown")
	public String iplistexcelDown(Model model, HttpSession session) {
		
		List<IpHistoryVo> resultList = adminService.allloginList();
		
		// Model 객페에 header, data
		List<String> header = new ArrayList<String>();
		header.add("No");
		header.add("IP");
		header.add("접속 회원 아이디");
		header.add("날짜");
		
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();		
		
		for(int i =0; i< resultList.size();i++) {
			Map<String, String > map = new HashMap<String, String>();
			map.put("ip", resultList.get(i).getIpAddr());
			map.put("memid", resultList.get(i).getMemId());
			map.put("regDt", resultList.get(i).getIphistDate());
	
			data.add(map);
		}
		
		model.addAttribute("header", header);
		model.addAttribute("data", data);
		
		
		return "ipexcelView";
	}

}
