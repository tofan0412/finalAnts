package ants.com.board.memBoard.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.memBoard.mapper.SuggestMapper;
import ants.com.board.memBoard.model.SuggestVo;

@Service("suggestService")
public class SuggestService {

	@Resource(name="suggestMapper")
	private SuggestMapper mapper;
	
	public List<SuggestVo> readSuggestList(SuggestVo suggestVo){
		return mapper.readSuggestList(suggestVo);
	}
	
	
}
