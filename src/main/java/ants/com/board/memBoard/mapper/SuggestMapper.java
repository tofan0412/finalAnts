package ants.com.board.memBoard.mapper;

import java.util.List;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.model.SuggestVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("suggestMapper")
public interface SuggestMapper {
	
	// 프로젝트 번호(reqId)를 이용하여 프로젝트 내 일감에 대해 등록된 건의사항을 모두 불러온다.
	public List<SuggestVo> readSuggestList(SuggestVo suggestVo);
	
	// 키워드를 통해 일감 검색하기
	public List<TodoVo> searchTodo(TodoVo todoVo);
	
	// 건의 사항 등록하기
	public int suggestInsert(SuggestVo suggestVo);
	
	// 하나의 건의사항 읽기
	public SuggestVo suggestDetail(SuggestVo suggestVo);
	
	// 건의사항 수정하기
	public int suggestMod(SuggestVo suggestVo);
	
	// 건의사항 삭제하기
	public int delSuggest(SuggestVo suggestVo);
}
