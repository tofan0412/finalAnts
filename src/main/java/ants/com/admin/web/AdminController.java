package ants.com.admin.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import ants.com.admin.model.AdminVo;
import ants.com.admin.model.IpVo;
import ants.com.admin.model.NoticeVo;
import ants.com.admin.service.AdminService;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.common.model.IpHistoryVo;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.service.MemberService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@Resource(name="adminService")
	AdminService adminService;
	
	@Resource(name="memberService")
	MemberService memberService;
	
	//관리자 로그인 페이지
	@RequestMapping("/adloginView")
	public String adloginView() {
		return "/login/adlogin2";
	}
	
	// 로그인 로직
	@RequestMapping(path = "/adloginFunc")
	public String adloginFunc(AdminVo adminVo, HttpSession session, Model model) {

		AdminVo dbAdmin = adminService.getAdmin(adminVo);
		
		if (dbAdmin != (null) && adminVo.getAdminPass().equals(dbAdmin.getAdminPass())) {
			session.setAttribute("SADMIN", dbAdmin);
			return "admin.tiles/admin/adcontentmain";
			
		} else {
			return "redirect:/admin/adloginView";
		}

	}
	
	// 로그인 체크 ajax
	@RequestMapping(path = "/adlogincheck", method = RequestMethod.GET)
	public String adlogincheck(AdminVo adminVo, Model model) {
		
		
		AdminVo dbAdmin = adminService.adlogincheck(adminVo);
		
		
		
		model.addAttribute("adminId", dbAdmin.getAdminId());
		model.addAttribute("adminPass", dbAdmin.getAdminPass());
		
		return "/login/adlogin2";
	}
	
	//관리자 로그아웃
	@RequestMapping("/adlogout")
	public String adlogout(HttpSession session) {
		session.invalidate();
		return "redirect:/admin/adloginView";
	}
	
	// 화면 상단 로고 클릭 시 메인 페이지로 이동
	@RequestMapping("/adMainView")
	public String adMainView() {
		return "admin.tiles/admin/adcontentmain";
	}
	
	
//////////////////////////////////////////////////////////////////////////////////////////////관리자 공지사항	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	@RequestMapping("/adeachproject")
	public String adeachproject(HttpSession session) {
		
		session.setAttribute("noticeId", "1");
		
		return "notice/admineachproject";
	}
	
	
	// 공지사항리스트 출력
	@RequestMapping("/noticelist")
	public String getnoticelist(@ModelAttribute("noticeVo") NoticeVo noticeVo, HttpSession session, Model model) throws Exception{
			
		String noticeId = (String)session.getAttribute("noticeId");
	
		noticeVo.setNoticeId(noticeId);
		
		/** EgovPropertyService.sample */
		noticeVo.setPageUnit(propertiesService.getInt("pageUnit"));
		noticeVo.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(noticeVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(noticeVo.getPageUnit());
		paginationInfo.setPageSize(noticeVo.getPageSize());

		noticeVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		noticeVo.setLastIndex(paginationInfo.getLastRecordIndex());
		noticeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<NoticeVo> resultList = adminService.noticelist(noticeVo);
		model.addAttribute("noticelist", resultList);

		int totCnt = adminService.noticePagingListCnt(noticeVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		if(noticeVo.getSearchKeyword() != null) {			
			session.setAttribute("searchKeyword", noticeVo.getSearchKeyword());
			session.setAttribute("searchCondition",noticeVo.getSearchCondition());
			session.setAttribute("pageIndex", noticeVo.getPageIndex());
		}
		return "admin.tiles/notice/noticelist2";
		
	}
	
	// 각 공지사항 상세보기
	@RequestMapping("/eachnoticeDetail")
	public String geteachnotice(String noticeId, HttpSession session, Model model) {
		
		NoticeVo noticevo = adminService.geteachnotice(noticeId);
		
		model.addAttribute("noticevo", noticevo);
		
		
		model.addAttribute("adminId", "admin");
		 
		return "admin.tiles/notice/noticeDetail";
	}
	
	// 공지사항 작성 View
	@RequestMapping("/insertnoticeView")
	public String insertnoticeView(HttpSession session) {

		return "admin.tiles/notice/noticeInsert";
	}
	
	// 공지사항 작성
	@RequestMapping("/insertnotice")
	public String insertnotice(NoticeVo noticeVo, HttpSession session, Model model) {
		
		String noticeId = (String)session.getAttribute("noticeId");
		
		noticeVo.setAdminId("admin");
		
//		int insertCnt = adminService.insertnotice(noticeVo);
		adminService.insertnotice(noticeVo);

//		if(insertCnt>0) {		
			return "redirect:/admin/noticelist";
//		}else {
//			return "redirect:/admin/insertnoticeView";
//			
//		}	
	}
	
	
	// 공지사항 update View
	@RequestMapping("/updatenoticeView")
	public String updatenoticeView(String noticeId, HttpSession session, Model model) {
		
		NoticeVo noticevo = adminService.geteachnotice(noticeId);
		model.addAttribute("noticeVo", noticevo);
		
		return "admin.tiles/notice/noticeUpdate";
	}
	
	// 공지사항 update 
	@RequestMapping("/updatenotice")
	public String updatenotice(NoticeVo noticeVo, HttpSession session, Model model) {
		
		String noticeId = (String)session.getAttribute("noticeId");

		noticeVo.setAdminId("admin");
		
		int insertCnt = adminService.updatenotice(noticeVo);
		
		if(insertCnt>0) {		
			return "redirect:/admin/eachnoticeDetail?noticeId=" + noticeVo.getNoticeId();
		}else {
			return "redirect:/admin/updatenoticeView";
			
		}
	}
	
	// 공지사항 delete 
	@RequestMapping("/delnotice")
	public String delnotice(String noticeId, HttpSession session, Model model) {		
		int delCnt = adminService.delnotice(noticeId);
		if(delCnt>0) {		
			return "redirect:/admin/noticelist";
		}else {
			return "redirect:/admin/eachnoticeDetail?noticeId="+noticeId;
		}
	}
	
	
	//회원 리스트 목록 조회
	@RequestMapping("/memberlist")
	public String getmemberlist(@ModelAttribute("memberVo") MemberVo memberVo,
									Model model, HttpSession session)throws Exception {
		String memId = (String)session.getAttribute("memId");
	
		memberVo.setMemId(memId);
		
		/** EgovPropertyService.sample */
		memberVo.setPageUnit(propertiesService.getInt("pageUnit"));
		memberVo.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(memberVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(memberVo.getPageUnit());
		paginationInfo.setPageSize(memberVo.getPageSize());

		memberVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		memberVo.setLastIndex(paginationInfo.getLastRecordIndex());
		memberVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<MemberVo> resultList = adminService.memberlist(memberVo);
		model.addAttribute("memberlist", resultList);

		int totCnt = adminService.memberlistPagingListCnt(memberVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "admin.tiles/memberlist/memberList2";
	}
	
	// 각 회원정보 상세보기
	@RequestMapping("/eachmemlistDetail")
	public String geteachmemlist(String memId, HttpSession session, Model model) {
		
		MemberVo membervo = adminService.geteachmemlist(memId);
		
		model.addAttribute("membervo", membervo);
		 
		return "admin.tiles/memberlist/memlistDetail";
	}
	
	
	
	// 프로필 보기
	@RequestMapping("/memlistprofile")
	public String memlistprofile(HttpSession session, MemberVo memberVo, Model model) {
		
		MemberVo dbMember = adminService.getMember(memberVo);
//		MemberVo dbMember = null;
//		if(memberVo.getMemId() != ((MemberVo) session.getAttribute("SMEMBER")).getMemId()) {
//			dbMember = adminService.getMember(memberVo);
//		}else {
//			memberVo = (MemberVo) session.getAttribute("SMEMBER");
//			dbMember = adminService.getMember(memberVo);
//		}
		
		model.addAttribute("memberVo",dbMember);
		
		return "admin.tiles/memberlist/memberProfile";
	}
	
	
	// 프로필 수정 페이지
	@RequestMapping("/memlistprofileupdate")
	public String memlistprofileupdate(MemberVo memberVo, Model model) {
		MemberVo dbMember = adminService.getMember(memberVo);
		model.addAttribute("memberVo", dbMember);
		return "admin.tiles/memberlist/profileupdateview";
	}
	
	
	 @RequestMapping(path="/memlistproupdate", method = RequestMethod.POST)                // VO 객체 바로 뒤에 Binding 와야함... 안그럼 매칭안됨
	public String memlistproupdate(HttpSession session, Model model, String imgname, MemberVo memberVo, BindingResult br,
			@RequestPart(value = "Filename", required = false) MultipartFile file) {

		String Filename = "";
		String Filepath = "";

		if (!file.getOriginalFilename().equals("") && !file.getOriginalFilename().equals(null)) {

			if (br.hasErrors()) {
				// return "main.tiles/member/memberRegist";
			}

			String filekey = UUID.randomUUID().toString();

			Filepath = "D:\\upload\\" + file.getOriginalFilename();
			Filename = file.getOriginalFilename();
			File uploadFile = new File(Filepath);

			try {
				file.transferTo(uploadFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

		} else {

			// 기본 이미지 중에 선택했을때
			if (!imgname.equals(memberVo.getMemFilepath())) {
				Filepath = "/profile/"+ imgname.split("/")[4];
				Filename = imgname.split("/")[4];
			// 기본이미지 값이 널일때 (기본이미지/파일 아무것도 선택 안함)
			}else {
				Filepath = memberVo.getMemFilepath();
				Filename = memberVo.getMemFilename();
			}
		}
		memberVo.setMemFilepath(Filepath);
		memberVo.setMemFilename(Filename);

		int updateCnt = adminService.memlistproupdate(memberVo);

		if (updateCnt == 1) {
			return "redirect:/admin/memlistprofile?memId=" + memberVo.getMemId();
//			return "redirect:/admin/memlistprofile";
		} else {
			return "admin.tiles/memberlist/profileupdateview";
		}

	}
	
	 //회원 삭제
	@RequestMapping("/delmemlist")
	public String delmemlist(String memId, HttpSession session, Model model) {		
		int delCnt = adminService.delmemlist(memId);
//		if(delCnt>0) {		
//			return "redirect:/admin/memberlist";
//		}else {
//			return "redirect:/admin/eachmemlistDetail?memId="+memId;
//		}
		return "redirect:/admin/memberlist";
	}
	
	// Ip 리스트 전체 가져오기 -> 차단 리스트 또는 허용 리스트
	@RequestMapping("/getIpList")
	public String getIpList(@ModelAttribute("issueVo")  IpVo ipVo, Model model, HttpSession session) {
	
		ipVo.setPageUnit(propertiesService.getInt("pageUnit"));
		ipVo.setPageSize(propertiesService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(ipVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(ipVo.getPageUnit());
		paginationInfo.setPageSize(ipVo.getPageSize());
		
		ipVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		ipVo.setLastIndex(paginationInfo.getLastRecordIndex());
		ipVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<IpVo> ipList = adminService.getIpList(ipVo);
		model.addAttribute("ipList", ipList);
		
		int totCnt = adminService.getIpCount();
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageIndex", ipVo.getPageIndex());
		
		return "admin.tiles/admin/ipAcceptedList";
		
	}
	
	// Ip 하나만 가져오기
	@RequestMapping("/getIp")
	public String getIp(IpVo ipVo) {
		IpVo result = adminService.getIp(ipVo);
		return "admin.tiles/admin/ipDetail";
	}
	
	// Ip 삭제하기
	@RequestMapping("/delIp")
	public String delIp(IpVo ipVo) {
		int result = adminService.delIp(ipVo);
		return "redirect:/admin/getIpList";
	}
	
	
	//Ip 입력창으로 이동
	@RequestMapping("/insertIpView")
	public String insertIpView() {
		return "admin.tiles/admin/ipInsert";
	}
	
	// Ip 입력하기
	@RequestMapping("/insertIp")
	public String insertIp(String ip1,String ip2,String ip3,String ip4, HttpSession session) {
		
		
		String ip = ip1.concat(".")
					.concat(ip2)
					.concat(".")
					.concat(ip3)
					.concat(".")
					.concat(ip4);
		
		AdminVo admin =(AdminVo) session.getAttribute("SADMIN");
		IpVo ipVo = new IpVo();
		
		ipVo.setIpAddr(ip);
		ipVo.setAdminId(admin.getAdminId());
		ipVo.setDel("N");
		ipVo.setIpStatus("ACCEPTED");
		
		int result = adminService.insertIp(ipVo);
		
		return "redirect:/admin/getIpList";
	}
	
	@RequestMapping("/getIpCount")
	@ResponseBody
	public int getIpCount() {
		int result = adminService.getIpCount();
		
		return result;
	}
	
	// ip 메인 화면으로 이동하기
	@RequestMapping("/ipMain")
	public String ipMain() {
//		return "redirect:/admin/getIpList";
		return "admin.tiles/admin/ipMain";
	}
	
	@RequestMapping("/loginLogList")
	@ResponseBody
	public List<IpHistoryVo> loginLogList() {
		return adminService.loginLogList();
	}
	
	
	// 프로젝트 리스트 전체 가져오기 -> 차단 리스트 또는 허용 리스트
	@RequestMapping("/projectlist")
	public String getprojectlist(@ModelAttribute("projectVo") ProjectVo projectVo, HttpSession session, Model model) throws Exception {
		
		String reqId = (String)session.getAttribute("reqId");
		
		projectVo.setReqId(reqId);
		
		/* EgovPropertyService.sample */
		projectVo.setPageUnit(propertiesService.getInt("pageUnit"));
		projectVo.setPageSize(propertiesService.getInt("pageSize"));
		
		/* pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(projectVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(projectVo.getPageUnit());
		paginationInfo.setPageSize(projectVo.getPageSize());

		projectVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		projectVo.setLastIndex(paginationInfo.getLastRecordIndex());
		projectVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<ProjectVo> resultList = adminService.projectlist(projectVo);
		model.addAttribute("projectlist", resultList);

		int totCnt = adminService.projectPagingListCnt(projectVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "admin.tiles/admin/projectlist";
		
	}
	
	// 프로젝트 delete 2
	@RequestMapping("/delproject")
	public String delproject(ProjectVo projectVo,String reqId) {		
		int delCnt = adminService.delproject(projectVo);
//		int delCnt = adminService.delproject(reqId);
		return "redirect:/admin/projectlist";
	}
	
	// 프로젝트 하나만 가져오기
	@RequestMapping("/projectDetail")
	public String getproject(ProjectVo projectVo) {
		ProjectVo result = adminService.getProject(projectVo);
		return "admin.tiles/admin/projectDetail";
	}
	
	
}

