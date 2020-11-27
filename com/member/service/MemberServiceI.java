package ants.com.member.service;

import java.util.Map;

import ants.com.member.model.MemberVo;

public interface MemberServiceI {
	public MemberVo login(Map<String, String> memInfo);
		
}
