package ants.com.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import ants.com.member.mapper.MemberMapper;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;

@Service("memberService")
public class MemberService{
	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);
	
	@Resource(name="memberMapper")
	private MemberMapper mapper;
	
	public MemberVo getMember(String memId) {
		logger.debug("memberService login : {}", memId);
		return mapper.getMember(memId);
	}
	
	
	public int insertMember(MemberVo memberVo) {
		logger.debug("memberService memberVo : {}", memberVo);
		return mapper.insertMember(memberVo);
	}


	public int updatePass(MemberVo memberVo) {
		logger.debug("memberService updatePass : {}", memberVo);
		return mapper.updatePass(memberVo);
	}
	
	public List<MemberVo> getAllMember(){
		return mapper.getAllMember();
	}

	
	
}
