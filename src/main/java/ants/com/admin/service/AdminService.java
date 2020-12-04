package ants.com.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.admin.mapper.AdminMapper;
import ants.com.admin.model.NoticeVo;
import ants.com.board.memBoard.model.IssueVo;
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
	
/////////////////////////////////////////////////////////////////////////////test

	
	
	
	
	
	
}
