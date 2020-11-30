package ants.com.member.service;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import ants.com.member.model.MemberVo;
import ants.com.member.repository.MemberDaoI;

@Service("memberService")
public class MemberService implements MemberServiceI {
	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);
	
	@Resource(name="memberDao")
	MemberDaoI memberDao;
	
	@Override
	public MemberVo getMember(String memId) {
		logger.debug("memberService login : {}", memId);
		return memberDao.getMember(memId);
	}
	
	
	@Override
	public int insertMember(MemberVo memberVo) {
		logger.debug("memberService memberVo : {}", memberVo);
		return memberDao.insertMember(memberVo);
	}
		
	
}
