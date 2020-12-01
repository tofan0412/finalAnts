package ants.com.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import ants.com.member.mapper.ReqMapper;
import ants.com.member.model.ReqVo;

@Service("reqService")
public class ReqService{
	private static final Logger logger = LoggerFactory.getLogger(ReqService.class);
	
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








}
