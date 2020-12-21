package ants.com.board.memBoard.mapper;

import java.util.List;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.model.SuggestVo;
import ants.com.file.model.PublicFileVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("suggestMapper")
public interface SuggestMapper {
	
	// 프로젝트 번호(reqId)를 이용하여 프로젝트 내 일감에 대해 등록된 건의사항을 모두 불러온다.
	public List<SuggestVo> readSuggestList(SuggestVo suggestVo);
	
	// 키워드를 통해 일감 검색하기
	public List<TodoVo> searchTodo(TodoVo todoVo);
	
	// 건의 사항 등록하기
	public int suggestInsert(SuggestVo suggestVo);
	
	// 페이징 처리 위해 게시글 개수 불러오기
	public int suggestPagingListCnt(SuggestVo suggestVo);
	
	// 하나의 건의사항 읽기
	public SuggestVo suggestDetail(SuggestVo suggestVo);
	
	// 건의사항 수정하기
	public int suggestMod(SuggestVo suggestVo);
	
	// 건의사항 삭제하기
	public int delSuggest(SuggestVo suggestVo);
	
	// 파일 업로드 위해 시퀀스 값 가져오기
	public String getSgtSeq();
	
	// 건의사항 글에서 올린 파일 목록 불러오기
	public List<PublicFileVo> suggestFileList(SuggestVo suggestVo);
	
	// 건의사항 첨부파일 다운로드
	public String suggestFileDownload(PublicFileVo publicFileVo);
	
	// 건의사항 파일 하나 불러오기
	public PublicFileVo suggestFile(PublicFileVo publicFileVo);
	
	// 건의사항에서 올린 첨부파일 하나 삭제하기
	public int suggestFileDel(PublicFileVo publicFileVo);
	
	// 건의사항 승인 또는 반려하기
	public int acceptOrReject(SuggestVo suggestVo);
}
