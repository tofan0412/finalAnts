package ants.com.board.memBoard.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.mapper.SuggestMapper;
import ants.com.board.memBoard.model.SuggestVo;
import ants.com.file.model.PublicFileVo;

@Service("suggestService")
public class SuggestService {

	@Resource(name="suggestMapper")
	private SuggestMapper mapper;
	
	public List<SuggestVo> readSuggestList(SuggestVo suggestVo){
		return mapper.readSuggestList(suggestVo);
	}
	
	public List<TodoVo> searchTodo(TodoVo todoVo){
		return mapper.searchTodo(todoVo);
	}
	
	public int suggestInsert(SuggestVo suggestVo) {
		return mapper.suggestInsert(suggestVo);
	}
	
	// 페이징 처리 위해 게시글 개수 가져오기
	public int suggestPagingListCnt(SuggestVo suggestVo) {
		return mapper.suggestPagingListCnt(suggestVo);
	}
	
	// 하나의 건의사항 읽기
	public SuggestVo suggestDetail(SuggestVo suggestVo) {
		return mapper.suggestDetail(suggestVo);
	}
	
	// 건의사항 수정하기
	public int suggestMod(SuggestVo suggestVo) {
		return mapper.suggestMod(suggestVo);
	}
	
	// 건의사항 삭제하기
	public int delSuggest(SuggestVo suggestVo) {
		return mapper.delSuggest(suggestVo);
	}
	
	// 파일 업로드 위해 시퀀스 값 가져오기
	public String getSgtSeq() {
		return mapper.getSgtSeq();
	}
	
	// 건의사항 글에서 올린 파일 목록 불러오기
	public List<PublicFileVo> suggestFileList(SuggestVo suggestVo){
		return mapper.suggestFileList(suggestVo);
	}
	
	// 건의사항 첨부 파일 다운로드
	public String suggestFileDownload(PublicFileVo publicFileVo) {
		return mapper.suggestFileDownload(publicFileVo);
	}
	
	// 파일 하나 불러오기 
	public PublicFileVo suggestFile(PublicFileVo publicFileVo) {
		return mapper.suggestFile(publicFileVo);
	}
	
	// 파일 하나 DB에서 삭제하기
	public int suggestFileDel(PublicFileVo publicFileVo) {
		return mapper.suggestFileDel(publicFileVo);
	}
	
	// 건의사항 승인 또는 반려하기..
	public int acceptOrReject(SuggestVo suggestVo) {
		return mapper.acceptOrReject(suggestVo);
	}
}
