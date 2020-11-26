package ants.com.member.repository;

import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import ants.com.member.model.MemberVo;

@Repository("memberDao")
public class MemberDao implements MemberDaoI{
	private static final Logger logger = LoggerFactory.getLogger(MemberDao.class);
	
	@Resource(name="SqlSessionTemplate")
	SqlSessionTemplate sqlSession;
	
	@Override
	public MemberVo login(Map<String, String> memInfo) {
		logger.debug("서비스 진입 ...");
		return sqlSession.selectOne("member.login", memInfo);
	}

}
