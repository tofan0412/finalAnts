package ants.com.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.admin.mapper.AdminMapper;
import ants.com.admin.model.AdminVo;
import ants.com.admin.model.IpVo;
import ants.com.admin.model.NoticeVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.common.model.IpHistoryVo;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("adminService")
public class AdminService extends EgovAbstractServiceImpl{
	
	@Resource(name="adminMapper")
	private AdminMapper mapper;
	
	// 공지사항글 리스트
	public List<NoticeVo> noticelist(NoticeVo noticeVo) {
		return mapper.noticelist(noticeVo);
	}

	// 각 공지사항글 내용
	public NoticeVo geteachnotice(String noticeId) {
		return mapper.geteachnotice(noticeId);
	}

	// 공지사항글 작성하기
	public int insertnotice(NoticeVo noticeVo) {
		return mapper.insertnotice(noticeVo);
	}

	// 공지사항글 수정하기
	public int updatenotice(NoticeVo noticeVo) {
		
		return mapper.updatenotice(noticeVo);
	}

	// 공지사항글 삭제하기
	public int delnotice(String noticeId) {
		return mapper.delnotice(noticeId);
	}
	
	//회원이 사용가능한 카테고리 조회
	public int noticePagingListCnt(NoticeVo noticeVo) {
		return mapper.noticePagingListCnt(noticeVo);
	}
	
	/////////////////////////////////////////관리자 로그인
	public AdminVo getAdmin(AdminVo adminVo) {
		return mapper.getAdmin(adminVo);
	}
	
	public AdminVo adlogincheck(AdminVo adminVo) {
		return mapper.adlogincheck(adminVo);
	}
	
	// 탈퇴하지 않은 모든 멤버리스트
	public  List<MemberVo> allmemberlist() {
		return mapper.allmemberlist();
	}
	
	//////////멤버 리스트 
	public List<MemberVo> memberlist(MemberVo memberVo) {
		return mapper.memberlist(memberVo);
	}

	public int memberlistPagingListCnt(MemberVo memberVo) {
		return mapper.memberlistPagingListCnt(memberVo);
	}

	public MemberVo geteachmemlist(String memId) {
		return mapper.geteachmemlist(memId);
	}

	public MemberVo getMember(MemberVo memberVo) {
		return mapper.getMember(memberVo);
	}
	
	public int memlistproupdate(MemberVo memberVo) {
		return mapper.memlistproupdate(memberVo);
	}
	
	//회원삭제
	public int delmemlist(String memId) {
		return mapper.delmemlist(memId);
	}
	
	// IP히스토리 최근 500개 가져오기
	public List<IpHistoryVo> allloginList(){
		return mapper.allloginList();
	}	
	
	
	// Ip 전체 리스트 가져오기
	public List<IpVo> getIpList(IpVo ipVo){
		return mapper.getIpList(ipVo);
	}
	
	// Ip 전체 리스트 가져오기(확인하기위함)
	public List<IpVo> getIpListcheck(){
		return mapper.getIpListcheck();
	}
	
	// 특정 Ip만 가져오기
	public IpVo getIp(IpVo ipVo) {
		return mapper.getIp(ipVo);
	}
	
	// Ip 삭제하기
	public int delIp(IpVo ipVo) {
		return mapper.delIp(ipVo);
	}
	
	// Ip 수정하기
	public int updateIp(IpVo ipvo) {
		return mapper.updateIp(ipvo);
	}
	
	// Ip 입력하기
	public int insertIp(IpVo ipVo) {
		return mapper.insertIp(ipVo);
	}
	
	// Ip 카운트 세기
	public int getIpCount() {
		return mapper.getIpCount();
	}

	// 사용자 로그인 기록 등록하기
	public int insertMemLoginLog(IpHistoryVo log) {
		return mapper.insertMemLoginLog(log);
	}
	
	// 사용자 로그인 기록 불러오기
	public List<IpHistoryVo> loginLogList(){
		return mapper.loginLogList();
	}

	
	// 프로젝트 리스트
	public List<ProjectVo> projectlist(ProjectVo projectVo) {
		return mapper.projectlist(projectVo);
	}
	
	//카테고리 검색 리스트
	public int projectPagingListCnt(ProjectVo projectVo) {
		return mapper.projectPagingListCnt(projectVo);
	}
	
	//프로젝트 삭제하기 2
	public int delproject(ProjectVo projectVo) {
		return mapper.delproject(projectVo);
	}
	
	//1개 프로젝트 가져오기
	public ProjectVo getProject(ProjectVo projectVo) {
		return mapper.getProject(projectVo);
	}

	//프로젝트 삭제 테스트중
//	public int delproject(String reqId) {
//		return mapper.delproject(reqId);
//	}



	
	

	
	
	
	
	
	
}
