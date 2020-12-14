package ants.com.admin.mapper;

import java.util.List;

import ants.com.admin.model.AdminVo;
import ants.com.admin.model.IpVo;
import ants.com.admin.model.NoticeVo;
import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.common.model.IpHistoryVo;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("adminMapper")
public interface AdminMapper {
	
	// 공지사항리스트
	public List<NoticeVo> noticelist(NoticeVo noticeVo);
	
	// 해당 공지사항
	public NoticeVo geteachnotice(String noticeId);
	
	// 공지사항게시글 작성
	public int insertnotice(NoticeVo noticeVo);
	
	// 공지사항게시글 수정
	public int updatenotice(NoticeVo noticeVo);
	
	// 공지사항게시글 삭제
	public int delnotice(String noticeId);
	
	//회원이 사용가능한 카테고리 조회
	public int noticePagingListCnt(NoticeVo noticeVo);

	//관리자 로그인
	public AdminVo getAdmin(AdminVo adminVo);

	public AdminVo adlogincheck(AdminVo adminVo);

	//멤버 리스트
	public List<MemberVo> memberlist(MemberVo memberVo);
	
	public int memberlistPagingListCnt(MemberVo memberVo);

	//멤버 리스트 상세보기
	public MemberVo geteachmemlist(String memId);
	
	public MemberVo getMember(MemberVo memberVo);
	
	public int memlistproupdate(MemberVo memberVo);

	//회원삭제
	public int delmemlist(String memId);
	
	// Ip 전체 리스트 가져오기
	public List<IpVo> getIpList();
	
	// 특정 Ip만 가져오기
	public IpVo getIp(IpVo ipVo);
	
	// Ip 삭제하기
	public int delIp(IpVo ipVo);
	
	// Ip 수정하기
	public int updateIp(IpVo ipvo);
	
	// Ip 입력하기
	public int insertIp(IpVo ipVo);
	
	// Ip 카운트 세기
	public int getIpCount();
	
	// 사용자 로그인 기록 등록하기
	public int insertMemLoginLog(IpHistoryVo log);
	
	// 사용자 로그인 기록 리스트로 불러오기
	public List<IpHistoryVo> loginLogList();

	
	
}
