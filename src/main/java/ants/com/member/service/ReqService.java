package ants.com.member.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.member.mapper.ProjectMapper;
import ants.com.member.mapper.ReqMapper;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.model.ReqVo;

@Service("reqService")
public class ReqService{
	
	@Resource(name="reqMapper")
	private ReqMapper mapper;
	
	@Resource(name="projectMapper")
	private ProjectMapper proMapper;
	
	
	/**
	 * 요구사항정의서 목록가져오기
	 * @param reqVo 페이징처리
	 * @return reqVo 리스트
	 */
	public List<ReqVo> reqList(ReqVo reqVo) {
		return mapper.reqList(reqVo);
	}
	
	/**
	 * 요구사항정의서 개수
	 * @param reqVo 검색조건, 페이징
	 * @return
	 */
	public int reqListCount(ReqVo reqVo) {
		return mapper.reqListCount(reqVo);
	}
	
	/**
	 * 요구사항정의서 등록 
	 * @param reqVo 등록할 요구사항정의서 객체
	 * @return 성공:2  실패:0
	 */
	public int reqInsert(ReqVo reqVo) {
		int cnt = 0;
		cnt += mapper.reqInsert(reqVo);
		ProjectVo projectVo = new ProjectVo();
		projectVo.setReqId(reqVo.getReqId());
		
		cnt += proMapper.insertProject(projectVo);
		return cnt;
	}
	
	/**
	 * 요구사항정의서 수정
	 * @param reqVo 수정할 요구사항정의서 객체
	 * @return 성공:1 실패:0
	 */
	public int reqUpdate(ReqVo reqVo){
		return mapper.reqUpdate(reqVo);
	}
	
	/**
	 * 요구사항정의서 삭제
	 * @param reqId 삭제할 요구사항정의서 id
	 * @return 성공:1 실패:0
	 */
	public int reqDelete(String reqId) {
		int cnt = 0;
		cnt += mapper.reqDelete(reqId);
		cnt += proMapper.deleteProject(reqId);
		return cnt;
	}
	
	/**
	 * 요구사항정의서 한개의 정보
	 * @param reqVo 조건
	 * @return 요구사항정의서 객체
	 */
	public ReqVo getReq(ReqVo reqVo) {
		return mapper.getReq(reqVo);
	}
    
	/**
	 * pl삭제하기
	 * @param reqVo 검색조건
	 * @return 성공:3,2 실패:0
	 */
	public int plDelete(ReqVo reqVo) {
		int cnt = 0;
		// 요구사항정의서에서 삭제
		cnt += mapper.plDelete(reqVo);
		
		// 프로젝트멤버에서 del
		ProjectMemberVo projectMemberVo = new ProjectMemberVo();
		projectMemberVo.setMemId(reqVo.getMemId());
		projectMemberVo.setReqId(reqVo.getReqId());
		projectMemberVo.setPromemStatus("OUT");
		cnt += proMapper.updatePjtMember(projectMemberVo);
		
		//프로젝트에서 삭제
		ProjectVo projectVo = new ProjectVo();
		projectVo.setReqId(reqVo.getReqId());
		projectVo.setMemId("공석");
		cnt += proMapper.updateProject(projectVo);
		
		return cnt;
	}
	
	/**
	 * 요구사항정의서 다음 id가져오기
	 * @return 다음 reqId
	 */
	public String getReqId() {
		return mapper.getReqId();
	}
	
	/**
	 * 프로젝트 개요의 req 정보 가져오기
	 * @return reqVo
	 */
	public ReqVo getoutlinereq(String reqId) {
		return mapper.getoutlinereq(reqId);
	}







}
