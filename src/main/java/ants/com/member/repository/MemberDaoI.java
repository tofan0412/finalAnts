package ants.com.member.repository;

import java.util.Map;

import ants.com.member.model.MemberVo;

public interface MemberDaoI {
	
	public MemberVo getMember(String memId);
	
	int insertMember(MemberVo memberVo);
	
	
}
