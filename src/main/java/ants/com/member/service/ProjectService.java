package ants.com.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.http.RequestLine;
import org.springframework.stereotype.Service;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.model.SuggestVo;
import ants.com.board.vote.model.VoteVo;
import ants.com.file.model.PublicFileVo;
import ants.com.member.mapper.ProjectMapper;
import ants.com.member.mapper.ProjectmemberMapper;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.model.ReqVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("projectService")
public class ProjectService extends EgovAbstractServiceImpl {

	@Resource(name = "projectMapper")
	private ProjectMapper mapper;

	// left바 mem=프로젝트명 불러오는 메서드
	public List<ProjectVo> memInProjectList(String memId) {
		return mapper.memInProjectList(memId);
	}
	// left바 pl=프로젝트명 불러오는 메서드
	public List<ProjectVo> plInProjectList(String memId) {
		return mapper.plInProjectList(memId);
	}
	// left바 pm=프로젝트명 불러오는 메서드
	public List<ProjectVo> pmInProjectList(String memId) {
		return mapper.pmInProjectList(memId);
	}
	
	// 나에게 요청된 요구사항정의서 리스트 출력하는 메서드
	public List<ReqVo> readReqList(String plId){
		return mapper.readReqList(plId);
	}
	
	public int insertProject(ProjectVo projectVo) {
		return mapper.insertProject(projectVo);
	}
	
	public List<MemberVo> userSearch(String keyword){
		keyword = ("%").concat(keyword).concat("%");
		return mapper.userSearch(keyword);
	}
	
	// 추가할 회원 아이디가 실제로 존재하는 아이디인지 확인한다.
	public MemberVo chkMemId(String memId) {
		return mapper.chkMemId(memId);
	}
	
	// 프로젝트에 참여하는 회원 DB에 저장하기
	public int insertPjtMember(ProjectMemberVo pjtMem) {
		return mapper.insertPjtMember(pjtMem);
	}
	
	// 프로젝트 진행도 update
	public int propercentChange(ProjectVo projectVo) {
		return mapper.propercentChange(projectVo);
	}
	
	// 프로젝트 수정하기
	public int updateProject(ProjectVo projectVo) {
		return mapper.updateProject(projectVo);
	}
	// 개요페이지 프로젝트 정보가져오기
	public ProjectVo getoutlinepro(String reqId) {
		return mapper.getoutlinepro(reqId);
	}
	// 개요페이지 프로젝트멤버 정보가져오기
	public List<ProjectMemberVo>getoutlinepromem(String reqId) {
		return mapper.getoutlinepromem(reqId);
	}
	// 개요페이지 프로젝트파일함 사용량 정보가져오기
	public PublicFileVo getoutlinefiles(String reqId) {
		return mapper.getoutlinefiles(reqId);
	}
	// 개요페이지 프로젝트투표율 정보가져오기
	public VoteVo getoutlinevote(String reqId) {
		return mapper.getoutlinevote(reqId);
	}
	// 개요페이지 이슈댓글 가져오기
	public ReplyVo getoutlinereply(String reqId) {
		return mapper.getoutlinereply(reqId);
	}
	// 개요페이지 건의사항 ACCEPT율 가져오기
	public SuggestVo getoutlinsuggest(String reqId) {
		return mapper.getoutlinsuggest(reqId);
	}
	
	// 개요페이지 건의사항 reject율 가져오기
	public SuggestVo getoutlinsuggestreject(String reqId) {
		return mapper.getoutlinsuggestreject(reqId);
	}
	
	// 개요페이지 마감임박 할일 가져오기
	public List<TodoVo> getoutlindeadline(String reqId) {
		return mapper.getoutlindeadline(reqId);
	}
	
	public List<SuggestVo> chartsuggestcnt(String reqId) {
		return mapper.chartsuggestcnt(reqId);
	}
	
	public List<VoteVo> barchartvoteindi(String reqId) {
		return mapper.barchartvoteindi(reqId);
	}
	public List<PublicFileVo> chartfilesday(String reqId) {
		return mapper.chartfilesday(reqId);
	}
	public List<PublicFileVo> chartfilesmonth(String reqId) {
		return mapper.chartfilesmonth(reqId);
	}
	public List<PublicFileVo> chartfilesextension(String reqId) {
		return mapper.chartfilesextension(reqId);
	}
	
	
	
}
