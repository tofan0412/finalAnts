package ants.com.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.mapper.ProjectMapper;
import ants.com.member.mapper.ProjectmemberMapper;
import ants.com.member.model.ProjectVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("projectService")
public class ProjectService extends EgovAbstractServiceImpl {

	@Resource(name = "projectMapper")
	private ProjectMapper mapper;

	// left바 프로젝트명 불러오는 메서드
	public List<ProjectVo> memInProjectList(String memId) {
		return mapper.memInProjectList(memId);
	}
	
	// pm,pl left바 불러오는 메서드
	public List<ProjectVo> plpmInProjectList(String memId) {
		return mapper.plpmInProjectList(memId);
	}
}
