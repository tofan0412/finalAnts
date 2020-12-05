package ants.com.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.http.RequestLine;
import org.springframework.stereotype.Service;

import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.mapper.ProjectMapper;
import ants.com.member.mapper.ProjectmemberMapper;
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
	
	public String insertProject(ProjectVo projectVo) {
		return mapper.insertProject(projectVo);
	}
	
}
