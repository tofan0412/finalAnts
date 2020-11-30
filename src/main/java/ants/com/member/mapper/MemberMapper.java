package ants.com.member.mapper;


import ants.com.member.model.MemberVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper {
	
	public MemberVo getMember(String memId);
	
	int insertMember(MemberVo memberVo);
	
	
}
