package ants.com.member.repository;

import java.util.List;
import java.util.Map;

import ants.com.member.model.ReqVo;

public interface PmDaoI {

	public List<ReqVo> reqList(String mem_id);

	public int reqInsert(ReqVo reqVo);

	public int reqUpdate(Map<String, Object> reqUMap);

	public int reqDelete(String req_id);

}
