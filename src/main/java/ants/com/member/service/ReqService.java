package ants.com.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.member.mapper.ReqMapper;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ReqVo;

@Service("reqService")
public class ReqService{
	
	@Resource(name="reqMapper")
	private ReqMapper mapper;
	
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
	 * @return 성공:1  실패:0
	 */
	public int reqInsert(ReqVo reqVo) {
		return mapper.reqInsert(reqVo);
	}
	
	/**
	 * 요구사항정의서 수정
	 * @param reqVo 수정할 요구사항정의서 객체
	 * @return 성공:1 실패:0
	 */
	public int reqUpdate(ReqVo reqVo) {
		return mapper.reqUpdate(reqVo);
	}
	
	/**
	 * 요구사항정의서 삭제
	 * @param reqId 삭제할 요구사항정의서 id
	 * @return 성공:1 실패:0
	 */
	public int reqDelete(String reqId) {
		return mapper.reqDelete(reqId);
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
	 * @return 성공:1 실패:0
	 */
	public int plDelete(ReqVo reqVo) {
		return mapper.plDelete(reqVo);
	}
	
	/**
	 * 요구사항정의서 다음 id가져오기
	 * @return 다음 reqId
	 */
	public String getReqId() {
		return mapper.getReqId();
	}







}
