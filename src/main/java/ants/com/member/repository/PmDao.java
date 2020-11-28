package ants.com.member.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ants.com.member.model.ReqVo;

@Repository("pmDao")
public class PmDao implements PmDaoI{

	@Override
	public List<ReqVo> reqList(String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int reqInsert(ReqVo reqVo) {
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
