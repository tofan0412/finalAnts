package ants.com.board.memBoard.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.memBoard.mapper.memBoardMapper;

@Service("memBoardService")
public class memBoardService{
	@Resource(name="memBoardMapper")
	private memBoardMapper mapper;
}
