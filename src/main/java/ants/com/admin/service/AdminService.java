package ants.com.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.admin.mapper.AdminMapper;
import ants.com.admin.model.AdminVo;
import ants.com.admin.model.IpVo;
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
	
	/////////////////////////////////////////관리자 로그인
	public AdminVo getAdmin(AdminVo adminVo) {
		return mapper.getAdmin(adminVo);
	}
	
	public AdminVo adlogincheck(AdminVo adminVo) {
		return mapper.adlogincheck(adminVo);
	}
	///////////////////////////////////////////////////////////////////////ip
	
	//IP리스트글 
	public List<IpVo> iplist(IpVo ipVo) {
		// TODO Auto-generated method stub
		return null;
	}

	//카테고리 조회
	public int ipPagingListCnt(IpVo ipVo) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	//test iplist
	public int selectClientIpCnt(IpVo ipVo) {
		// TODO Auto-generated method stub
		return 0;
	}

	public void insertClientIp(IpVo ipVo) {
		
	}

	public void updateBoardReadCnt(IpVo ipVo) {
		// TODO Auto-generated method stub
		
	}


	

	
	
/////////////////////////////////////////////////////////////////////////////test

	
	
	
	
	
	
}
