package ants.com.member.mapper;

import java.util.List;

import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
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
}
