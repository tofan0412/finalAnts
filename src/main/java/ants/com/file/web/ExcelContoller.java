package ants.com.file.web;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.admin.service.AdminService;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.vote.model.VoteItemVo;
import ants.com.board.vote.model.VoteResultVo;
import ants.com.board.vote.model.VoteVo;
import ants.com.board.vote.service.VoteService;
import ants.com.common.model.IpHistoryVo;
import ants.com.member.model.MemberVo;
import ants.com.member.service.ProjectmemberService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.sf.jxls.exception.ParsePropertyException;


@RequestMapping("/excel")
@Controller
public class ExcelContoller {
	
	@Resource(name="promemService")
	ProjectmemberService promemService;
	
	@Resource(name="adminService")
	AdminService adminService;
	
	
	@Resource(name ="voteService")
	private VoteService voteService;
	
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
	
	@RequestMapping("/voteExcel")
	public void voteExcel(HttpServletRequest request, HttpServletResponse response, VoteVo voteVo) throws Exception {
				
		List<VoteItemVo> itemlist = voteService.voteitemDetail(voteVo);
		VoteVo dbvoteVo = voteService.voteDetail(voteVo);
		
		for(int i =0; i<itemlist.size();i++) {
			double a = Math.round(Double.parseDouble(itemlist.get(i).getVoteCount())/Double.parseDouble(dbvoteVo.getVotedNo())*100);
			itemlist.get(i).setPercent(String.valueOf(a));
		}
		
		double percent =  Math.round(Double.parseDouble(dbvoteVo.getVotedNo())/Double.parseDouble(dbvoteVo.getVoteTotalno())*100);
		dbvoteVo.setVotepercent(String.valueOf(percent));
		
        Map<String , Object> beans = new HashMap<String , Object>();
        beans.put("itemlist" , itemlist );
        beans.put("voteVo" , dbvoteVo );
      
        

        MakeExcel me = new MakeExcel();
        me.download(request, response, beans, "voteDetail", "vote.xlsx");
	
	}

}
