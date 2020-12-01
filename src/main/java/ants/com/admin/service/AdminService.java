package ants.com.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.admin.mapper.AdminMapper;
import ants.com.admin.model.NoticeVo;

@Service("adminService")
public class AdminService {
	@Resource(name="adminMapper")
	private AdminMapper mapper;
	
	
//	// 공지사항리스트
//	public List<NoticeVo> noticelist(String adminId){
//		return mapper.noticelist(adminId);
//	}
//	
////	// 공지사항
////	public NoticeVo geteachnotice(String noticeVo) {
////		return mapper.geteachnotice(noticeVo);
////	}
//	
//	// 공지사항 작성
//	public int insertissue(NoticeVo noticeVo) {
//		return mapper.insertissue(noticeVo);
//	}
//	
//	// 공지사항 수정
//	public int updatenotice(NoticeVo noticeVo) {
//		return mapper.updatenotice(noticeVo);
//	}
//	
//	// 공지사항 삭제
//	public int delnotice(String noticeId) {
//		return mapper.delnotice(noticeId);
//	}
	
//	public void create(NoticeVo noticeVo) throws Exception;
//	
//	NoticeVo read(NoticeVo noticeVo) throws Exception;
//	
//	public void update(NoticeVo noticeVo) throws Exception;
//	
//	public void delete(NoticeVo noticeVo) throws Exception;
//	
//	List<NoticeVo> listAll() throws Exception;
	
}
