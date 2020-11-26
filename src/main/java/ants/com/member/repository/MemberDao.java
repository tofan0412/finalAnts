package ants.com.member.repository;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import ants.com.member.model.MemberVo;

@Repository
public class MemberDao implements MemberDaoI{
	@Resource(name="sqlSessionTemplate")
	
	@Override
	public MemberVo login(Map<String, String> memInfo) {
		// TODO Auto-generated method stub
		return null;
	}

}
