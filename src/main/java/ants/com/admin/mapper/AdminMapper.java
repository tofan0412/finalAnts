package ants.com.admin.mapper;

import java.util.List;

import ants.com.admin.model.NoticeVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("adminMapper")
public interface AdminMapper {

		// 공지사항리스트
		public List<NoticeVo> noticelist(String adminId);
		
//		// 공지사항
//		public NoticeVo geteachnotice(String noticeVo);
		
		// 공지사항 작성
		public int insertissue(NoticeVo noticeVo);
		
		// 공지사항 수정
		public int updatenotice(NoticeVo noticeVo);
	
		// 공지사항 삭제
		public int delnotice(String noticeId);
	
	
//		public void create(NoticeVo noticeVo) throws Exception;
//		
//		NoticeVo read(NoticeVo noticeVo) throws Exception;
//		
//		public void update(NoticeVo noticeVo) throws Exception;
//		
//		public void delete(NoticeVo noticeVo) throws Exception;
//		
//		List<NoticeVo> listAll() throws Exception;
}
