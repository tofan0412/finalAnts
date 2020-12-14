package ants.com.member.mapper;

import java.util.List;

import ants.com.member.model.MemberVo;
import ants.com.member.model.ReqVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("reqMapper")
public interface ReqMapper {

	public List<ReqVo> reqList(ReqVo reqVo);
	
	public int reqListCount(ReqVo reqVo);

	public int reqInsert(ReqVo reqVo);

	public int reqUpdate(ReqVo reqVo);

	public int reqDelete(String reqId);

	public ReqVo getReq(ReqVo reqVo);
	
	public List<MemberVo> getAllMember(String term);

	public MemberVo getMember(MemberVo memberVo);

	public int plDelete(ReqVo reqVo);

	public String getReqId();
	
	public ReqVo getoutlinereq(String reqId);

}
