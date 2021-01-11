package ants.com.member.mapper;

import java.io.IOException;
import java.util.List;

import ants.com.chatting.model.ChatMemberVo;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper {
	
	public MemberVo getMember(MemberVo memberVo);
	
	int insertMember(MemberVo memberVo) throws IOException;

	public int updatePass(MemberVo memberVo);

	public List<MemberVo> getAllMember(String term);

	public List<MemberVo> getAllMemberList();
	
	public int checkSignup(MemberVo memberVo);
	
	public MemberVo logincheck(MemberVo memberVo);
	
	public int profileupdate(MemberVo memberVo);
	
	public int projectmemberupdate(ProjectMemberVo projectmembervo);
	
	public int chatmemberupdate(ChatMemberVo chatmembervo);
		
	public int updateAlarm(MemberVo memberVo);
	
	public int memTypeUpdate(MemberVo memberVo);
}
