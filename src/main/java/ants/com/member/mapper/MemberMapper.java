package ants.com.member.mapper;


import java.io.IOException;
import java.util.List;

import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper {
	
	public MemberVo getMember(String memId);
	
	int insertMember(MemberVo memberVo) throws IOException;

	public int updatePass(MemberVo memberVo);

	public List<MemberVo> getAllMember();

	public int checkSignup(String memId);
	
	
	
	
}
