package ants.com.member.service;

import java.util.List;
import java.util.Map;

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
	
	public int reqInsert(Map<String, Object> reqIMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int reqUpdate(Map<String, Object> reqUMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int reqDelete(String req_id) {
		// TODO Auto-generated method stub
		return 0;
	}








}
