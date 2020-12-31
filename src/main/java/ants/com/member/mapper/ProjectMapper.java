package ants.com.member.mapper;

import java.util.List;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.model.SuggestVo;
import ants.com.board.vote.model.VoteVo;
import ants.com.common.model.AlarmVo;
import ants.com.file.model.PublicFileVo;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.model.ReqVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("projectMapper")
public interface ProjectMapper {

	// 프로젝트명 불러오기
	public List<ProjectVo> memInProjectList(String memId);

	// pl,pm메뉴 불러오기
	public List<ProjectVo> plInProjectList(String memId);

	public List<ProjectVo> pmInProjectList(String memId);

	// 나에게 요청된 요구사항정의서 리스트 출력하는 메서드
	public List<ReqVo> readReqList(String plId);

	public int insertProject(ProjectVo projectVo);

	public List<MemberVo> userSearch(String keyword);

	// 프로젝트 멤버를 추가하기 전, 아이디가 실제로 존재하는 ID인지를 확인한다..
	public MemberVo chkMemId(String memId);

	// 프로젝트 회원 추가하기
	public int insertPjtMember(ProjectMemberVo pjtMem);

	public int propercentChange(ProjectVo projectVo);

	// 프로젝트 수정하기
	public int updateProject(ProjectVo projectVo);

	// 개요 페이지 프로젝트 정보가져오기
	public ProjectVo getoutlinepro(String reqId);

	// 개요 프로젝트멤버 조회
	public List<ProjectMemberVo> getoutlinepromem(String reqId);
	
	// 개요 프로젝트파일량 조회
	public PublicFileVo getoutlinefiles(String reqId);

	// 개요 프로젝트 투표율 조회
	public VoteVo getoutlinevote(String reqId);
	
	// 개요 프로젝트  댓글 조회
	public ReplyVo getoutlinereply(String reqId);

	// 개요 프로젝트 건의사항 accept율 조회
	public SuggestVo getoutlinsuggest(String reqId);
	
	// 개요 프로젝트 건의사항 REJECT율 조회
	public SuggestVo getoutlinsuggestreject(String reqId);
	
	// 개요 프로젝트 마감임박할일 조회
	public List<TodoVo> getoutlindeadline(String reqId);
	
	// 프로젝트 삭제
	public int deleteProject(String reqId);

	public List<SuggestVo> chartsuggestcnt(String reqId);

	public List<VoteVo> barchartvoteindi(String reqId);

	public List<PublicFileVo> chartfilesday(String reqId);

	public List<PublicFileVo> chartfilesmonth(String reqId);

	public List<PublicFileVo> chartfilesextension(String reqId);

	public List<IssueVo> chartIssuesday(String reqId);

	public List<IssueVo> chartIssuesmonth(String reqId);

	public List<IssueVo> chartIssuesCnt(String reqId);

	public int updatePjtMember(ProjectMemberVo projectMemberVo);

	public List<ProjectMemberVo> requestPjtMember(MemberVo memberVo);

	public int deletePjtMember(ProjectMemberVo projectMemberVo);

	public List<ProjectVo> chartproday(String reqId);

	public List<ProjectVo> projectListmain(String memId);

	public List<AlarmVo> alarmlistmain(String memId);

	public int projectManage(ProjectVo projectVo);

}
