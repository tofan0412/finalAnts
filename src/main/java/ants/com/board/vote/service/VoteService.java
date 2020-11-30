package ants.com.board.vote.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.vote.mapper.VoteMapper;

@Service("voteService")
public class VoteService{
	@Resource(name="voteMapper")
	private VoteMapper mapper; 
}
