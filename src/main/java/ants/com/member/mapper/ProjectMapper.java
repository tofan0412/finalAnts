package ants.com.member.mapper;

import java.util.List;

import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.model.ReqVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("projectMapper")
public interface ProjectMapper {
	
	//프로젝트명 불러오기
	public List<ProjectVo> memInProjectList(String memId);
	
	//pl,pm메뉴 불러오기
	public List<ProjectVo> plInProjectList(String memId);
	
	public List<ProjectVo> pmInProjectList(String memId);
	
	// 나에게 요청된 요구사항정의서 리스트 출력하는 메서드
	public List<ReqVo> readReqList(String plId);
	
	public int insertProject(ProjectVo projectVo);
	
	public List<MemberVo> userSearch(String keyword);
	
	//프로젝트 멤버를 추가하기 전, 아이디가 실제로 존재하는 ID인지를 확인한다..
	public MemberVo chkMemId(String memId);
	
	// 프로젝트 회원 추가하기
	public int insertPjtMember(ProjectMemberVo pjtMem);
	
	public int propercentChange(ProjectVo projectVo);
	
	// 프로젝트 수정하기
	public int updateProject(ProjectVo projectVo);
	
	//개요 페이지 프로젝트 정보가져오기
	public ProjectVo getoutlinepro(String reqId);
	
	
}
