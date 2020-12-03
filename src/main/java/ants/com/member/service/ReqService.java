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
	
	public List<ReqVo> reqList(ReqVo reqVo) {
		return mapper.reqList(reqVo);
	}

	public int reqListCount(ReqVo reqVo) {
		return mapper.reqListCount(reqVo);
	}
	
	public int reqInsert(ReqVo reqVo) {
		return mapper.reqInsert(reqVo);
	}

	public int reqUpdate(ReqVo reqVo) {
		return mapper.reqUpdate(reqVo);
	}

	public int reqDelete(String reqId) {
		return mapper.reqDelete(reqId);
	}
	
	public ReqVo getReq(ReqVo reqVo) {
		return mapper.getReq(reqVo);
	}
    
	public List<MemberVo> getAllMember(String term){
		return mapper.getAllMember(term);
	}

	public MemberVo getMember(MemberVo memberVo) {
		return mapper.getMember(memberVo);
	}







}
