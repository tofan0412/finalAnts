package ants.com.member.service;

import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import ants.com.member.model.ReqVo;

@Service("pmService")
public class PmService implements PmServiceI {
	private static final Logger logger = LoggerFactory.getLogger(PmService.class);
	
	@Override
	public List<ReqVo> reqList(String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}
	


}
