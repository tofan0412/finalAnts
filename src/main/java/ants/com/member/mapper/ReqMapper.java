package ants.com.member.mapper;

import java.util.List;
import java.util.Map;

import ants.com.member.model.ReqVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("reqMapper")
public interface ReqMapper {

	public List<ReqVo> reqList(ReqVo reqVo);
	
	public int reqListCount(ReqVo reqVo);

	public int reqInsert(ReqVo reqVo);

	public int reqUpdate(Map<String, Object> reqUMap);

	public int reqDelete(String req_id);

	public ReqVo getReq(ReqVo reqVo);

}
