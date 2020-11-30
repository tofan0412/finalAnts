package ants.com.member.repository;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import ants.com.member.model.ReqVo;

@Repository("pmDao")
public class PmDao implements PmDaoI{
	
	@Resource(name="SqlSessionTemplate")
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<ReqVo> reqList(ReqVo reqVo) {
		return sqlSession.selectList("pm.reqList",reqVo);
	}

	public int reqListCount(ReqVo reqVo) {
		return sqlSession.selectOne("pm.reqListCount",reqVo);
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
