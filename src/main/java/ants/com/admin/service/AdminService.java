package ants.com.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.admin.mapper.AdminMapper;
import ants.com.admin.model.AdminVo;
import ants.com.admin.model.IpVo;
import ants.com.admin.model.NoticeVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.model.MemberVo;
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
	
	// Ip 전체 리스트 가져오기
	public List<IpVo> getIpList(){
		return mapper.getIpList();
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

	
	

	
	
	
	
	
	
}
