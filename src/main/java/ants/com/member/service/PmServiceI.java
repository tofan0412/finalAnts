package ants.com.member.service;

import java.util.List;
import java.util.Map;

import ants.com.member.model.ReqVo;

public interface PmServiceI {
	
	public List<ReqVo> reqList(String mem_id);
	
	public int reqInsert(Map<String, Object> reqIMap);
	
	public int reqUpdate(Map<String, Object> reqUMap);
	
	public int reqDelete(String req_id);
	
		
}
