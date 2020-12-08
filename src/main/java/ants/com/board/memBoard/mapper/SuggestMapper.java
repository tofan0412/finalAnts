package ants.com.board.memBoard.mapper;

import java.util.List;

import ants.com.board.memBoard.model.SuggestVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("suggestMapper")
public interface SuggestMapper {
	
	// 프로젝트 번호(reqId)를 이용하여 프로젝트 내 일감에 대해 등록된 건의사항을 모두 불러온다.
	public List<SuggestVo> readSuggestList(SuggestVo suggestVo);
	
	// 불러온 
}
