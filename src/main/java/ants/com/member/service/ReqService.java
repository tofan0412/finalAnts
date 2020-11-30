package ants.com.member.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import ants.com.member.model.ReqVo;
import ants.com.member.repository.ReqDaoI;

@Service("reqService")
public class ReqService implements ReqServiceI {
	private static final Logger logger = LoggerFactory.getLogger(ReqService.class);
	
	@Resource(name="reqDao")
	private ReqDaoI reqDao;
	
	@Override
	public List<ReqVo> reqList(ReqVo reqVo) {
		return reqDao.reqList(reqVo);
	}

	@Override
	public int reqListCount(ReqVo reqVo) {
		return reqDao.reqListCount(reqVo);
	}
	
	@Override
	public int reqInsert(Map<String, Object> reqIMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int reqUpdate(Map<String, Object> reqUMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int reqDelete(String req_id) {
		// TODO Auto-generated method stub
		return 0;
	}








}
