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

	////////////////////////////////////////////////////////////////테스트지만 이게 맞는듯??
//	//멤버 리스트 목록 테스트
//	public List<MemberVo> memberlist(MemberVo memberVo) {
//		return mapper.memberlist(memberVo);
//	}
//	
//	//각 멤버리스트 상세보기
//	public MemberVo geteachmember(String memId) {
//		return mapper.geteachmember(memId);
//	}
//
//	// 멤버리스트 작성
//	public int insertmember(MemberVo memberVo) {
//		return mapper.insertmember(memberVo);
//	}
//
//	// 멤버리스트 update
//	public int updatemember(MemberVo memberVo) {
//		return mapper.updatemember(memberVo);
//	}
//
//	// 멤버리스트 delete
//	public int delmember(String memId) {
//		return mapper.delmember(memId);
//	}

	/////////////////////////////////////////
	
	

	
	

	
	
	
	
	
	
}
