package ants.com.admin.mapper;

import java.util.List;

import ants.com.admin.model.AdminVo;
import ants.com.admin.model.NoticeVo;
import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
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

	public AdminVo getAdmin(AdminVo adminVo);

	public AdminVo adlogincheck(AdminVo adminVo);
	
//	// 회원이 사용가능한 카테고리 조회
//	public List<CategoryVo> categorylist(String memId);
//	
//	//프로젝트명 불러오기
//	public List<ProjectVo> memInProjectList(String memId);
	
	/////////////////////////////////////////////////test


	
	
}
