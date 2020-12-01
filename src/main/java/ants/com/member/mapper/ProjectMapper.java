package ants.com.member.mapper;

import java.util.List;

import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.model.ProjectVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("projectMapper")
public interface ProjectMapper {
	
	//프로젝트명 불러오기
	public List<ProjectVo> memInProjectList(String memId);
	
	//pl,pm메뉴 불러오기
	public List<ProjectVo> plpmInProjectList(String memId);
}
