package ants.com.member.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import ants.com.member.mapper.MemberMapper;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;

@Service("memberService")
public class MemberService{
	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);
	
	@Resource(name="memberMapper")
	private MemberMapper mapper;
	
	public MemberVo getMember(MemberVo memberVo) {
		return mapper.getMember(memberVo);
	}
	
	 
	public int insertMember(MemberVo memberVo) throws SQLException, IOException {
		logger.debug("memberService memberVo : {}", memberVo);
		return mapper.insertMember(memberVo);
	}


	public int updatePass(MemberVo memberVo) {
		logger.debug("memberService updatePass : {}", memberVo);
		return mapper.updatePass(memberVo);
	}
	
	
	public List<MemberVo> getAllMember(String term){
		return mapper.getAllMember(term);
	}
	
	public List<MemberVo> getAllMemberList(){
		return mapper.getAllMemberList();
	}
	
	
	public int checkSignup(MemberVo memberVo) {
		logger.debug("memberService checkSignup : {}", memberVo);
		return mapper.checkSignup(memberVo);
	}
	
	
	public MemberVo logincheck(MemberVo memberVo) {
		logger.debug("memberService logincheck : {}", memberVo);
		return mapper.logincheck(memberVo);
	}

	
	public int profileupdate(MemberVo memberVo) {
		logger.debug("memberService profileupdate : {}", memberVo);
		return mapper.profileupdate(memberVo);
	}
	
	
	public int updateAlarm(MemberVo memberVo) {
		return mapper.updateAlarm(memberVo);
	}
	
	public int memTypeUpdate(MemberVo memberVo) {
		return mapper.memTypeUpdate(memberVo);
	}
	
}
