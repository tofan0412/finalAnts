package ants.com.member.repository;

import java.util.List;
import java.util.Map;

import ants.com.member.model.ReqVo;

public interface ReqDaoI {

	public List<ReqVo> reqList(ReqVo reqVo);
	
	public int reqListCount(ReqVo reqVo);

	public int reqInsert(ReqVo reqVo);

	public int reqUpdate(Map<String, Object> reqUMap);

	public int reqDelete(String req_id);

}
