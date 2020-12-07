package ants.com.board.memBoard.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.memBoard.mapper.SuggestMapper;

@Service("suggestService")
public class SuggestService {

	@Resource(name="suggestMapper")
	private SuggestMapper mapper;
	
	
	
	
}
